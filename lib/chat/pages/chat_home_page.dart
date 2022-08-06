// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat/widgets/recent_chats.dart';
import 'package:flutter_application_1/kampy_posts.dart';
import 'package:intl/intl.dart';
import '../widgets/active_chats.dart';

// navbar

import 'package:flutter_application_1/kampy_event.dart';
import 'package:flutter_application_1/kampy_welcome.dart';
import 'package:flutter_application_1/chat/chat_main.dart';
import 'package:flutter_application_1/navbar_animated.dart';

// hex color
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  // navbar
  final List<Widget> _pages = [KampyEvent(), Posts(), Welcome(), Chat()];
// plus button array of pages
  final List<Widget> _views = [KampyEvent(), Posts(), Chat(), Welcome()];
  int index = 0;

  final controller = TextEditingController();
  List usersPhotos = [];
  List lastMessages = [];
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

  Future getUsers() async {
    List tmpUsersPhotos = [];
    await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isNotEqualTo: _uid)
        .get()
        .then((snapshot) => snapshot.docs.forEach((doc) {
              tmpUsersPhotos.add({
                'photoUrl': doc.data()['photoUrl'],
                "name": doc.data()["name"],
                "id": doc.data()['uid']
              });
            }));
    usersPhotos = tmpUsersPhotos;
  }
  // convert a TimeStamp into a string ;

  String formatteDate(timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat("dd-MM-yyyy hh:mm a").format(dateFromTimeStamp);
  }

  Future getUserbyID(id) async {
    var result;
    await FirebaseFirestore.instance
        .collection("users")
        .where('id', isEqualTo: id)
        .get()
        .then((value) => result = {value});
  }

  Future getLastMessage() async {
    List tmpsLast = [];
    await FirebaseFirestore.instance
        .collection('chats')
        .orderBy('date', descending: true)
        .get()
        .then((snapshot) => snapshot.docs.forEach((doc) {
              tmpsLast.add({
                'message': doc.data()['message'],
                'date': formatteDate(doc.data()['date']),
                'fromID': doc.data()['fromID'],
                'senderURL': doc.data()['senderURL'],
                "name": doc.data()["name"]
              });
            }));

    lastMessages = tmpsLast;
  }

  @override
  Widget build(BuildContext context) {
    getLastMessage();
    getUsers();
    loggedUser();
    print(lastMessages);
    return Scaffold(
      drawer: Drawer(),
       // navbar bottom
        backgroundColor: Colors.white,
        bottomNavigationBar: Builder(
            builder: (context) => AnimatedBottomBar(
                  defaultIconColor: Colors.black,
                  activatedIconColor: const Color.fromARGB(255, 56, 3, 33),
                  background: Colors.white,
                  buttonsIcons: const [
                    Icons.sunny_snowing,
                    Icons.explore_sharp,
                    Icons.messenger_outlined,
                    Icons.person
                  ],
                  buttonsHiddenIcons: const [
                    Icons.campaign_rounded,
                    Icons.shopping_bag,
                    Icons.image_rounded,
                    Icons.post_add_rounded
                  ],
                  backgroundColorMiddleIcon:
                      const Color.fromARGB(255, 56, 3, 33),
                  onTapButton: (i) {
                    setState(() {
                      index = i;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => _views[i]),
                    );
                  },
                  // navigate between pages
                  onTapButtonHidden: (i) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => _pages[i]),
                    );
                  },
                )),
// navbar bottom ends here

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
        ActiveChats(
          photos: usersPhotos,
        ),
        RecentChats(chats: lastMessages),
      ]),
      floatingActionButton: FloatingActionButton(
        // this hero tag for the navbar 
        heroTag: "navbar",

        onPressed: () {},
        backgroundColor: Colors.purple,
        child: Icon(Icons.message),
      ),
    );
  }
}
