import 'package:get/get.dart';
import 'controller_create.dart';

class BindingCreate extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerCreate>(() => ControllerCreate());
  }
}
