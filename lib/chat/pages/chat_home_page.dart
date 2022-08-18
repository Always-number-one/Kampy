// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat/helper/helper_Functions.dart';
import 'package:flutter_application_1/chat/widgets/recent_chats.dart';
import 'package:flutter_application_1/kampy_posts.dart';
import 'package:intl/intl.dart';
import 'chat_page.dart';
// navbar

import 'package:flutter_application_1/kampy_event.dart';
import 'package:flutter_application_1/kampy_welcome.dart';
import 'package:flutter_application_1/chat/chat_main.dart';
import 'package:flutter_application_1/navbar_animated.dart';

// hex color
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({
    Key? key,
  }) : super(key: key);

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
  List usersID = [];
  List messages = [];
  String? _name;
  String? _photoUrl;
  String? _uid;
  String? peerID;
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
    return DateFormat("hh:mm a").format(dateFromTimeStamp);
  }
  // get a coversation between two users

  Future addConversation(idConversation) async {
    FirebaseFirestore.instance
        .collection('chats')
        .add(idConversation)
        .catchError((e) {
      print(e);
    });
  }

  Future getConversation() async {
    List tmpmessages = [];
    String idConversation = HelperFunctions.getConvoID(_uid!, peerID!);

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(idConversation)
        .collection('messages')
        .orderBy('date', descending: true)
        .get()
        .then((snapshot) => {
              if (snapshot.docs.length==0) {
                print('not found'),
                addConversation(idConversation)
              },
              snapshot.docs.forEach((element) {
                print(element.data()['content']);
                tmpmessages.add({'message': element.data()['content']});
              })
            });
    messages = tmpmessages;
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
    print(messages);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kampy Chat'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [HexColor('#675975'), HexColor('#7b94c4')]),
          ),
        ),
      ),
      drawer: Drawer(),
      // navbar bottom
      bottomNavigationBar: Builder(
          builder: (context) => AnimatedBottomBar(
                defaultIconColor: HexColor('#7b94c4'),
                activatedIconColor: HexColor('#7b94c4'),
                background: Colors.white,
                buttonsIcons: const [
                  Icons.sunny_snowing,
                  Icons.explore_sharp,
                  Icons.messenger_outlined,
                  Icons.person
                ],
                buttonsHiddenIcons: const [
                  Icons.event_outlined,
                  Icons.shopping_bag,
                  Icons.image_rounded,
                  Icons.post_add_rounded
                ],
                backgroundColorMiddleIcon: HexColor('#7b94c4'),
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
                color: HexColor('#7b94c4'),
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
                  color: HexColor('#7b94c4'),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25, left: 5),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < usersPhotos.length; i++)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: GestureDetector(
                          onTap: () {
                            print(usersPhotos[i]['id']);
                            peerID = usersPhotos[i]['id'];
                            getConversation();
                            print(messages);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(conversation:messages,user:peerID ,)));
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(usersPhotos[i]['photoUrl']),
                          ),
                        ),
                      ),
                    ),
                ],
              )),
        ),
        RecentChats(chats: lastMessages),
      ]),
    );
  }
}
