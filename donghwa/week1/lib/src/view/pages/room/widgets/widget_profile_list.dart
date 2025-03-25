import 'package:flutter/material.dart';
import '../../../../models/model_profile.dart';

Widget widgetProfileList(
  List<Profile> profileList,
  Function(int) onUserSelect,
) {
  return Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text('joined(${profileList.length.toString()})'),
      ),
      SizedBox(height: 24),
      SizedBox(
          height: 400,
          child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: profileList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onUserSelect(index);
                  },
                  child: _profileImage(profileList[index]),
                );
              }))
    ],
  );
}

Widget _profileImage(Profile profile) {
  return GridTile(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xffBEBFC4),
          child: Icon(
            Icons.person,
            size: 40,
            color: Colors.white,
          )),
      Text(
        profile.name,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )
    ],
  ));
}
