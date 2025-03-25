import 'package:get/get.dart';
import '../../../firebase/firestore_service.dart';
import '../../../models/model_profile.dart';

class ControllerUser extends GetxController {
  final _isLoggedIn = false.obs;

  bool get isLoggedIn => _isLoggedIn.value;

  final _userId = "".obs;

  String get userId => _userId.value;

  final RxList<Profile> _userList = <Profile>[].obs;

  List<Profile> get userList => _userList;

  final _selectedProfile = Rx<Profile?>(null);

  Profile? get selectedProfile => _selectedProfile.value;

  final _isMyProfile = false.obs;

  bool get isMyProfile => _isMyProfile.value;

  void resetLogin() {
    _isLoggedIn.value = false;
  }

  void login(bool success) {
    if (success) {
      _isLoggedIn.value = true;
    } else {
      _isLoggedIn.value = false;
    }
  }

  void specifyUser(String id) {
    _userId.value = id;
    int index = _userList.indexWhere((user) => user.id == id);

    if (index != -1) {
      _selectedProfile.value = _userList[index];
      _isMyProfile.value = true;
    } else {
      _selectedProfile.value = null;
      _isMyProfile.value = false;
    }
  }

  void selectProfile(int index) {
    _selectedProfile.value = _userList[index];
    if (_userList[index].id.trim() == _userId.trim()) {
      _isMyProfile.value = true;
    } else {
      _isMyProfile.value = false;
    }

    print(_selectedProfile.value!.name);
  }

  void saveContent(String link, String newContent) {
    FirestoreService().editUserContent(link, _userId.value, newContent);
    print("saved newContent : $newContent");
  }

  void listenToUsers(String link) {
    FirestoreService().getUsersStream(link).listen((userList) {
      final profiles = userList.map((userMap) {
        return Profile.fromMap(userMap);
      }).toList();

      _userList.assignAll(profiles);
    });
  }
}
