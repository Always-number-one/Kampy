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
          child: Container(
            alignment: Alignment.centerRight,
            width: 250,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Type Something",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () => {print('pressed')},
          padding: EdgeInsets.only(right: 10),
          icon: Icon(
            Icons.send,
            color: Color.fromARGB(255, 148, 98, 195),
            size: 30,
          ),
        )
      ]),
    );
  }
}
