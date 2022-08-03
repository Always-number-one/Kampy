// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'pages/chat_page.dart';
import 'pages/chat_home_page.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
       
      ),
      routes: {
        "/":(context)=> ChatHome(),
        "chatPage": (context)=>ChatPage()
      },
    );
  }
}