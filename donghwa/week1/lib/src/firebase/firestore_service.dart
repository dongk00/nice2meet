import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nice2meet/src/models/response_firestore.dart';
import '../models/model_profile.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() => _instance;

  FirestoreService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore get instance => _firestore;

  //verify Room
  Future<bool> doesRoomExist(String link) async {
    try {
      final DocumentSnapshot roomSnapshot =
          await _firestore.collection('room').doc(link).get();
      return roomSnapshot.exists;
    } catch (e) {
      print('Error FirestoreService doesRoomExist: $e');
      return false;
    }
  }

  //addRoom
  Future<void> addRoom(String link, String name, String purpose) async {
    try {
      await _firestore.collection('room').doc(link).set({
        'name': name,
        'purpose': purpose,
      });
    } catch (e) {
      print('Error FirestoreService addRoom: $e');
    }
  }

  // Login or create a new user
  Future<Map<String, dynamic>> loginOrCreateUser(
      String link, String userName, String password) async {
    try {
      CollectionReference usersCollection =
          _firestore.collection('room').doc(link).collection('users');

      QuerySnapshot userSnapshot = await usersCollection
          .where('name', isEqualTo: userName)
          .limit(1)
          .get(const GetOptions(source: Source.server));

      if (userSnapshot.docs.isEmpty) {
        DocumentReference newDoc = usersCollection.doc();
        Profile newUser = Profile(
            id: newDoc.id, name: userName, password: password, content: '');

        await newDoc.set(newUser.toMap());

        return ResponseFirestore(
          success: true,
          message: "New User Created",
          userId: newUser.id,
        ).toMap();
      } else {
        var userDoc = userSnapshot.docs.first;
        if (userDoc['password'] == password) {
          return ResponseFirestore(
            success: true,
            message: "User Logged In",
            userId: userDoc.id,
          ).toMap();
        } else {
          return ResponseFirestore(
            success: false,
            message: 'Password mismatch',
            userId: userDoc.id,
          ).toMap();
        }
      }
    } catch (e) {
      return ResponseFirestore(
        success: false,
        message: 'Error FirestoreService loginOrCreateUser: $e',
        userId: userName,
      ).toMap();
    }
  }

  // Listen to room
  Stream<DocumentSnapshot> getRoomStream(String link) {
    return _firestore.collection('room').doc(link).snapshots();
  }

  // Listen to users in a room
  Stream<List<Map<String, dynamic>>> getUsersStream(String roomLink) {
    return _firestore
        .collection('room')
        .doc(roomLink)
        .collection('users')
        .snapshots()
        .map((snapshot) {
      var result = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
      print('userList : ${result.toString()}');
      return result;
    });
  }

  // Edit Content
  Future<void> editUserContent(
      String roomLink, String userId, String newContent) async {
    try {
      final userDoc = _firestore
          .collection('room')
          .doc(roomLink)
          .collection('users')
          .doc(userId);

      await userDoc.update({'content': newContent});
      return;
    } catch (e) {
      print('Error FirestoreService editUserContent: $e');
      return;
    }
  }
}
