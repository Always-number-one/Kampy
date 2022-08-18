// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../widgets/chat_bottom_sheet.dart';
import '../widgets/chat_sample.dart';
// hex color
import 'package:hexcolor/hexcolor.dart';

class ChatPage extends StatefulWidget {


  ChatPage({Key? key, }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        
         
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [HexColor('#675975'), HexColor('#7b94c4')]),
          ),
        ),
        title: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(45),
                child: Image.asset(
                  'images/profile1.jpg',
                  height: 45,
                  width: 45,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'User',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
      
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
        children: [
          ChatSample(),
        ],
      ),
      bottomSheet: ChatBottomSheet(),
    );
  }
}
