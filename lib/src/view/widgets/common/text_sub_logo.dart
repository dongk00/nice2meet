import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nice2meet/src/routes/app_routes.dart';

Widget textSubLogo() {
  return InkWell(
      onTap: () {
        Get.offAllNamed(Routes.CREATE);
      },
      child: const Text(
        "Nice2Meet",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 20, fontFamily: 'IrishGroverRegular'),
      ));
}
