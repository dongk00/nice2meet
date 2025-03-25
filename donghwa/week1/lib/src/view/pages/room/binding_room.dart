import 'package:get/get.dart';
import 'package:nice2meet/src/view/pages/room/controller_room.dart';
import 'controller_user.dart';

class BindingRoom extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerUser>(() => ControllerUser());
    Get.lazyPut<ControllerRoom>(() => ControllerRoom());
  }
}
