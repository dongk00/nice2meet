import 'package:flutter/material.dart';
import '../../../widgets/common/text_sub_logo.dart';

Widget widgetRoomHeader() {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 40),
    child: Align(
      alignment: Alignment.centerLeft,
      child: textSubLogo(),
    ),
  );
}
