import 'package:flutter/material.dart';

InputDecoration decorationTextInput(String label, String hint) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelStyle: const TextStyle(fontSize: 16, color: Colors.black),
  );
}
