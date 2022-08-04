// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat/widgets/recent_chats.dart';

import '../widgets/active_chats.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  final controller = TextEditingController();
  String? _name;
  String? _photoUrl;
  String? _uid;

  loggedUser() async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      _name = value.data()!['name'];
      _photoUrl = value.data()!["photorUrl"];
      _uid = value.data()!['uid'];
    });
  }

  @override
  Widget build(BuildContext context) {
    loggedUser();
    print(_name);
    return Scaffold(
      drawer: Drawer(),
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Text(
            "$_name",
            style: TextStyle(
                color: Color.fromARGB(255, 57, 1, 59),
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),

        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 300,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Search", border: InputBorder.none),
                      ),
                    )),
                Icon(
                  Icons.search,
                  color: Colors.purple,
                )
              ],
            ),
          ),
        ),
        ActiveChats(),
        RecentChats(),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.purple,
        child: Icon(Icons.message),
      ),
    );
  }
}
