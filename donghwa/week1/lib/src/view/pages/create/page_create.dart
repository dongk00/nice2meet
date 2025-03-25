import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nice2meet/src/util/generate_random_link.dart';
import 'package:nice2meet/src/view/widgets/common/button_large.dart';
import 'package:nice2meet/src/view/widgets/common/text_main_logo.dart';
import '../../styles/decoration_text_input.dart';
import 'controller_create.dart';

class PageCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageCreateState();
}

class _PageCreateState extends State<PageCreate> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ControllerCreate controller = Get.find<ControllerCreate>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: SizedBox(
          width: 400,
          child: Column(children: [
            textMainLogo(),
            const SizedBox(height: 80),
            _formCreateRoom(),
            const SizedBox(height: 64),
            buttonLarge("Make a Room", () async {
              if (validateForm()) {
                var randomLink = generateRandomLink();
                controller.createRoom(randomLink);
                Get.offAllNamed('/$randomLink');
              }
            })
          ]),
        ),
      ),
    );
  }

  Widget _formCreateRoom() {
    return Form(
      key: _formKey,
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(fontSize: 15),
              controller: controller.roomNameController,
              decoration: decorationTextInput(
                'Room Name',
                'Name your room.',
              ),
              validator: (value) => controller.validateRoomName(value),
            ),
            const SizedBox(height: 32),
            Obx(
              () => DropdownButtonFormField<String>(
                value: controller.selectedPurpose.value.isEmpty
                    ? null
                    : controller.selectedPurpose.value,
                style: TextStyle(fontSize: 15),
                decoration: decorationTextInput(
                  'purpose',
                  'What\'s this for?',
                ),
                items: controller.purposes.map((String purpose) {
                  return DropdownMenuItem<String>(
                    value: purpose,
                    child: Text(purpose),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  controller.selectedPurpose.value = newValue ?? '';
                },
                validator: (value) => controller.validatePurpose(value),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }
}
