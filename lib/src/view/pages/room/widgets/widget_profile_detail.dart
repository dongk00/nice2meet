import 'package:flutter/material.dart';
import 'package:nice2meet/src/view/widgets/common/button_large.dart';
import '../../../../models/model_profile.dart';
import '../../../styles/decoration_text_input.dart';

class FormProfileDetail extends StatefulWidget {
  final Profile profile;
  final bool isMyProfile;
  final Function(String) onSave;

  FormProfileDetail({
    required this.profile,
    required this.isMyProfile,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  @override
  _FormProfileDetail createState() => _FormProfileDetail();
}

class _FormProfileDetail extends State<FormProfileDetail> {
  final TextEditingController contentController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    contentController.text = widget.profile.content;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.profile.name),
          SizedBox(height: 32),
          SizedBox(
            height: 300,
              child: SingleChildScrollView(
                  child: TextField(
            enabled: widget.isMyProfile,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            scrollController: scrollController,
            controller: contentController,
            decoration: decorationTextInput(
              'Introduction',
              widget.profile.content,
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            textInputAction: TextInputAction.newline,
          ))),
          if (widget.isMyProfile) ...[
            Column(
              children: [
                const SizedBox(height: 32),
                buttonLarge(
                  "Save",
                  () {
                    widget.onSave(contentController.text);
                  },
                ),
              ],
            )
          ]
        ],
      ),
    );
  }
}

void showProfileDetailPopup(
  BuildContext context,
  Profile profile,
  bool isMyProfile,
  Function(String) onSave,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: null,
        clipBehavior: Clip.none,
        content: FormProfileDetail(
          profile: profile,
          isMyProfile: isMyProfile,
          onSave: (newContent) {
            onSave(newContent);
            Navigator.of(context).pop();
          },
        ),
      );
    },
  );
}
