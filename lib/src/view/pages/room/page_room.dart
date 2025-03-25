import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nice2meet/src/models/model_profile.dart';
import 'package:nice2meet/src/view/pages/room/controller_room.dart';
import 'package:nice2meet/src/view/pages/room/controller_user.dart';
import 'package:nice2meet/src/view/pages/room/widgets/widget_profile_detail.dart';
import 'package:nice2meet/src/view/pages/room/widgets/widget_profile_list.dart';
import 'package:nice2meet/src/view/pages/room/widgets/widget_room_header.dart';
import 'package:nice2meet/src/view/pages/room/widgets/widget_room_info.dart';
import '../../styles/decoration_text_input.dart';
import '../../widgets/common/button_large.dart';

class PageRoom extends StatefulWidget {
  @override
  State<PageRoom> createState() => _PageRoomState();
}

class _PageRoomState extends State<PageRoom> {
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final ControllerUser controllerUser = Get.find<ControllerUser>();
  final ControllerRoom controllerRoom = Get.find<ControllerRoom>();

  @override
  void initState() {
    super.initState();
    _initializeRoom();
    _resetLogin();
  }

  void _initializeRoom() async {
    final String link = Get.parameters['randomLink'] ?? "";
    bool isValid = await controllerRoom.isLinkValid(link);

    if (isValid) {
      controllerRoom.listenToRoom(link);
      controllerUser.listenToUsers(link);
    } else {
      Get.back();
      Get.snackbar('Invalid Link', 'The link you provided does not exist.');
      return;
    }
  }

  void _resetLogin() {
    controllerUser.resetLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(children: [
        widgetRoomHeader(),
        Obx(() {
          return widgetRoomInfo(
              context, controllerRoom.link, controllerRoom.roomName);
        }),
        const SizedBox(height: 64),
        Obx(() {
          if (!controllerUser.isLoggedIn) {
            return _buildLoginLayout();
          } else {
            return _buildProfileLayout();
          }
        })
      ]),
    );
  }

/* --- Login Layout ---*/

  Widget _buildLoginLayout() {
    return Column(
      children: [
        _formLoginRoom(),
        SizedBox(height: 64),
        buttonLarge("Login and Enter", () async {
          login();
        })
      ],
    );
  }

  Widget _formLoginRoom() {
    return SizedBox(
      width: 400,
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              TextFormField(
                  style: TextStyle(fontSize: 15),
                  controller: controllerRoom.userNameController,
                  decoration: decorationTextInput(
                    'User Name',
                    'Enter your name.',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  }),
              const SizedBox(height: 32),
              TextField(
                  style: TextStyle(fontSize: 15),
                  controller: controllerRoom.passwordController,
                  obscureText: true,
                  decoration: decorationTextInput(
                    'Password',
                    'Never forget it..',
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    Map<String, dynamic> isSuccess = await controllerRoom.login(
      controllerRoom.userNameController.text,
      controllerRoom.passwordController.text,
    );

    if (isSuccess['success']) {
      controllerUser.login(true);

      String userId = isSuccess['user'].toString();
      controllerUser.specifyUser(userId);
    } else {
      controllerUser.login(false);
      String errorMessage = isSuccess['message'] ?? "null";
      Get.snackbar("Login Failed", errorMessage);
    }
  }

/* --- Profile Layout --- */

  Widget _buildProfileLayout() {
    return SizedBox(
      child: Container(
        width: 500,
        height: 500,
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          return widgetProfileList(
            controllerUser.userList,
            (int index) {
              controllerUser.selectProfile(index);
              showProfileDetailPopup(
                context,
                controllerUser.selectedProfile ?? Profile.empty(),
                controllerUser.isMyProfile,
                (newContent) {
                  controllerUser.saveContent(controllerRoom.link, newContent);
                },
              );
            },
          );
        }),
      ),
    );
  }
}
