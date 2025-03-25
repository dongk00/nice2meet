import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../firebase/firestore_service.dart';

class ControllerCreate extends GetxController {
  final TextEditingController roomNameController = TextEditingController();
  final RxString selectedPurpose = ''.obs;

  final List<String> purposes = [
    'Social Gathering',
    'Networking',
    'Study',
    'Seminar',
    'Team Building',
    'Other'
  ];

  String? validateRoomName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your room name';
    } else {
      return null;
    }
  }

  String? validatePurpose(String? value) {
    if (value == null || value.isEmpty) {
      return 'Choose your purpose';
    } else {
      return null;
    }
  }

  Future<void> createRoom(String randomLink) async {
    try {
      await FirestoreService()
          .addRoom(randomLink, roomNameController.text, selectedPurpose.value);
    } catch (e) {
      print('Error ControllerCreate createRoom: $e');
    }
  }

  @override
  void onClose() {
    roomNameController.dispose();
    super.onClose();
  }
}
