import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget widgetRoomInfo(BuildContext context, String roomLink, String roomName) {
  const baseURL = "https://nice2meet.web.app/#/";
  final url = baseURL + roomLink;

  return SizedBox(
    width: 400,
    child: Column(
      children: [
        Text(
          roomName,
          style: TextStyle(fontSize: 30),
        ),
        FractionallySizedBox(
            widthFactor: 0.6,
            child: Column(
              children: [
                const SizedBox(height: 36),
                const Text('Share with your mates!'),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: url));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Link copied to clipboard!")),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          url,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.copy),
                    ],
                  ),
                ),

                // SizedBox(height: 8),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Expanded(child: Text('Open QR code')),
                //     Spacer(),
                //     Icon(Icons.qr_code),
                //   ],
                // )
              ],
            )),
      ],
    ),
  );
}
