// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

class ChatHome extends StatefulWidget {
  const ChatHome({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  // create firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // get the collection chats
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  
  // authonticaion
  final FirebaseAuth auth = FirebaseAuth.instance;
  // navbar
  final List<Widget> _pages = [KampyEvent(), Posts(), Welcome(), Chat()];
// plus button array of pages
  final List<Widget> _views = [KampyEvent(), Posts(), Chat(), Welcome()];
  int index = 0;

  final controller = TextEditingController();
 

// show users in the top

  // convert a TimeStamp into a string ;

  String formatteDate(timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat("hh:mm a").format(dateFromTimeStamp);
  }

  // body users list
  usersList (){
                // get current user connected
    final User? user = auth.currentUser;
    final uid = user?.uid;
    //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection
    CollectionReference Users = firestore.collection('users');
    return StreamBuilder<QuerySnapshot>(
       stream: Users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)  {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading");
          }
          if (snapshot.hasData) {
            return ListView(children: [
       
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
         
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25, left: 5),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < snapshot.data!.docs.length; i++)
                  if(uid!=snapshot.data!.docs[i]['uid'])
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
                          // on tap on user avatar
                          onTap: ()async  {
                            
                            var obj ={"fromId":uid,"message":"","toId":snapshot.data!.docs[i]['uid']};
                                QuerySnapshot chatsSnapshot = await chats.get();
                                 QuerySnapshot UsersSnapshot = await Users.get();

                                //  if users doesn't have converstion
                                          // add chat and store chat id
                                 
                            
                                //  get the currrent user messsages ids and update it 
                                for (var currid=0;currid<UsersSnapshot.docs.length;currid++){
                            
                                 
                                  if (UsersSnapshot.docs[currid]["uid"]==uid){
                                    print("current user connected");
                                    
                                    // loop into user one to check i he already has a conversation with anothe user 
                                    if (UsersSnapshot.docs[i]["messagesIds"].length>0){
                                    
                                      // compare with user clicked whish is use r2
                                    for(var us2=0;us2<UsersSnapshot.docs[currid]["messagesIds"].length;us2++){
                                                     if(UsersSnapshot.docs[i]["messagesIds"].contains(UsersSnapshot.docs[currid]["messagesIds"][us2])){
                                                      print("they already have a conversation together");
                                                      // if they have a conversation let's get it 
                                            for (var msg=0;msg<chatsSnapshot.docs.length; msg++){
                                     
                                              if(chatsSnapshot.docs[msg].reference.id==UsersSnapshot.docs[currid]["messagesIds"][us2]){
                                  
                                 await  Navigator.push( context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(from:uid,to:snapshot.data!.docs[i]['uid'],msgId:chatsSnapshot.docs[msg].reference.id,userphoto:snapshot.data!.docs[i]['photoUrl'],username:snapshot.data!.docs[i]['name']))
                                    );
                                  break;
                                              }
                                            
                                            }
                                                      
                                                     }   
                                        
                                                     
                                      }
                                     
                                      // 
                                                      print("they doesn't have conversation");
                                   // if length less than zero
                                  
                                        
                                  var currUserId;
                                  
                        await chats.add({
                               "conversation":[] 
                                })
                      .then((value) => currUserId=value.id)
                           .catchError((error) => print("Failed to add user: $error"));
                          snapshot.data!.docs[i].reference.id;

                                      // add message ids to the cureent user messsages                                    print ("this is the current user $UsersSnapshot.docs[currid]['uid']");
                                     var user1Id=UsersSnapshot.docs[currid]["messagesIds"];
                                    await user1Id.add(currUserId);
                                     await  UsersSnapshot.docs[currid].reference.update({
                                    "messagesIds":user1Id
                                });
                                 //  first user id
                                 var users2Id=snapshot.data!.docs[i]["messagesIds"];
                                    await users2Id.add(currUserId);
                                    //  update the user2 messages ids
                               await snapshot.data!.docs[i].reference.update({
                                    "messagesIds":users2Id
                                }
                                );
                               
                       
                         await Navigator.push( context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(from:uid,to:snapshot.data!.docs[i]['uid'],msgId:currUserId ,userphoto:snapshot.data!.docs[i]['photoUrl'],username:snapshot.data!.docs[i]['name']))
                                    );
                                
                                      
                                    }
                                    print("arr length is less than one");

                                     print("they doesn't have conversation");
                                   // if length less than zero
                                  
                                          var arrChats=[];
                                  var currUserId;
                                    arrChats.add(obj);
                        await chats.add({
                               "conversation":arrChats 
                                })
                      .then((value) => currUserId=value.id)
                           .catchError((error) => print("Failed to add user: $error"));
                          snapshot.data!.docs[i].reference.id;

                                      // add message ids to the cureent user messsages                                    print ("this is the current user $UsersSnapshot.docs[currid]['uid']");
                                     var user1Id=UsersSnapshot.docs[currid]["messagesIds"];
                                    await user1Id.add(currUserId);
                                     await  UsersSnapshot.docs[currid].reference.update({
                                    "messagesIds":user1Id
                                });
                                 //  first user id
                                 var users2Id=snapshot.data!.docs[i]["messagesIds"];
                                    await users2Id.add(currUserId);
                                    //  update the user2 messages ids
                               await snapshot.data!.docs[i].reference.update({
                                    "messagesIds":users2Id
                                }
                                );
                               
                       
                         await Navigator.push( context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(from:uid,to:snapshot.data!.docs[i]['uid'],msgId:currUserId,userphoto:snapshot.data!.docs[i]['photoUrl'],username:snapshot.data!.docs[i]['name']))
                                    );
                                                     
                            
                                }print("not the same user id");
                               
                                    }
                                
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(snapshot.data!.docs[i]['photoUrl']),
                          ),
                        ),
                      ),
                    ),
                ],
              )),
        ),
        // recent chats container
Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      decoration: BoxDecoration(
          color: Color.fromARGB(220, 255, 255, 255),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 2))
          ]
          ),
      child: Column(
        children: [
          for (int i = 0; i < 10 ; i++) // map throug the data
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: InkWell(
                // onTap: () {
                //  Navigator.push(context,
                //         MaterialPageRoute(builder: (context)=>ChatPage()));
                // },
                child: Container(
                  height: 65,
                  child: Row(
                    children: [
                      // CircleAvatar(
                      //   radius: 35,
                      //   backgroundImage: NetworkImage(chats[i]['senderURL']),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "sameh",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 19, 13, 24),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                             'hello',   
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                             '22',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    )
          ]);
     
          }
           return Text("nothing here yet");
  });
}
  @override
  Widget build(BuildContext context)  {
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

      body: usersList()
    );
  }
}
