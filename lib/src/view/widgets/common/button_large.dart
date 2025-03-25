import 'package:flutter/material.dart';

Widget buttonLarge(String btnText, onPressed) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 28, right: 28),
      child: Text(btnText),
    ),
  );
}
