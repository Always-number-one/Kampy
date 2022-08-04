// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChatBottomSheet extends StatelessWidget {
  const ChatBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 10,
          offset: Offset(0, 3),
        )
      ]),
      // ignore: prefer_const_literals_to_create_immutables
      child: Row(children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.add,
            color: Color.fromARGB(255, 57, 1, 59),
            size: 30,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.emoji_emotions,
            color: Color.fromARGB(255, 57, 1, 59),
            size: 30,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Container(
            alignment: Alignment.centerRight,
            width: 270,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Type Something",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.send,
            color: Color.fromARGB(255, 57, 1, 59),
            size: 30,
          ),
        )
      ]),
    );
  }
}
