import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nice2meet/src/firebase/firestore_service.dart';
import 'package:nice2meet/src/models/response_firestore.dart';

class ControllerRoom extends GetxController {
  final _link = "".obs;

  String get link => _link.value;

  final _roomName = "".obs;

  String get roomName => _roomName.value;

  final _roomPurpose = "".obs;

  String get roomPurpose => _roomPurpose.value;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> isLinkValid(String link) async {
    try {
      bool exists = await FirestoreService().doesRoomExist(link);
      return exists;
    } catch (e) {
      print('Error ControllerRoom isLinkValid: $e');
      return false;
    }
  }

  void listenToRoom(String link) {
    try {
      FirestoreService().getRoomStream(link).listen(
        (snapshot) {
          var data = snapshot.data() as Map<String, dynamic>?;
          _link.value = link;
          _roomName.value = data?['name'] ?? 'Nice2Meet';
          _roomPurpose.value = data?['purpose'] ?? '';

          print('Link listenToRoom: ${snapshot.id}');
        },
        onError: (e) {
          print('Error ControllerRoom listenToRoom : $e');
        },
      );
    } catch (e) {
      // Handle any unexpected errors
      print('Error ControllerRoom listenToRoom: $e');
      Get.snackbar('Error', 'An unexpected error occurred: $e');
    }
  }

  Future<Map<String, dynamic>> login(String userName, String password) async {
    try {
      Map<String, dynamic> result =
          await FirestoreService().loginOrCreateUser(link, userName, password);
      return result;
    } catch (e) {
      print('Error ControllerRoom login: $e');
      return ResponseFirestore(
        success: false,
        message: 'Error : $e',
        userId: userName,
      ).toMap();
    }
  }
}
