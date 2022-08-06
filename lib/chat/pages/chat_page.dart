// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../widgets/chat_bottom_sheet.dart';
import '../widgets/chat_sample.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Padding(
          padding: EdgeInsets.only(top: 5),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 57, 1, 59),
            leadingWidth: 50,
            // ignore: prefer_const_literals_to_create_immutables
            title: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(45),
                child: Image.asset('images/profile1.jpg',
                height: 45,
                width: 45,
                ),
                
              ),
              Padding(padding: EdgeInsets.only(left: 10),
              child: Text('User',
              style: TextStyle(color: Colors.white),),
              )
            ]),
          ),
        ),
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
