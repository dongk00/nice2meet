import 'package:get/get.dart';
import 'package:nice2meet/src/view/pages/create/binding_create.dart';
import 'package:nice2meet/src/view/pages/create/page_create.dart';
import 'package:nice2meet/src/view/pages/room/binding_room.dart';
import 'package:nice2meet/src/view/pages/room/page_room.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL_ROUTE = Routes.CREATE;
  static final INITIAL_BINDING = BindingCreate();

  static final routes = [
    GetPage(
      name: Routes.CREATE,
      page: () => PageCreate(),
      binding: BindingCreate(),
    ),
    GetPage(
      name: Routes.ROOM,
      page: () => PageRoom(),
      binding: BindingRoom(),
    ),
  ];
}
