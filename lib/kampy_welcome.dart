import 'dart:ffi';
import 'auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_controller.dart';
import 'package:flutter_application_1/kampy_signup.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'kampy_navbar.dart';

// hex color
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import firestore
import 'package:cloud_firestore/cloud_firestore.dart';
// firebase auth
import 'package:firebase_auth/firebase_auth.dart';

// navbar
import 'package:flutter/services.dart';
import 'navbar_animated.dart';
import 'kampy_posts.dart';
import 'kampy_event.dart';
import 'kampy_login.dart';
import 'kampy_signup.dart';
import 'package:get/get.dart';

import 'chat/chat_main.dart';

class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final List<Widget> _pages = [KampyEvent(), Posts(), Welcome(), Chat()];
// plus button array of pages
  final List<Widget> _views = [KampyEvent(), Posts(), Chat(), Welcome()];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection
    CollectionReference users = firestore.collection('users');

// create firebase auth instance
    final FirebaseAuth auth = FirebaseAuth.instance;
// get current user id
    final User? user = auth.currentUser;
    final uid = user?.uid;
// height and width full screen
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        // navbar bottom
        backgroundColor: HexColor("#170B31"),
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

// body starts here
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("images/background5.jpg"),
                fit: BoxFit.fill,
              )),
            ),

            // read data from firestore 
            StreamBuilder<QuerySnapshot>(
              // build dnapshot using users collection
                stream: users.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("loading");
                  }if (snapshot.hasData){
                 
           for (var i= 0 ;i<snapshot.data!.docs.length ;i++){//number of rows
          
               if (snapshot.data!.docs[i]['uid']==uid){
                return Card(
                  margin: const EdgeInsets.all(10),
                  // diplay current user if exists
                  child: ListTile(
                    title: Text(snapshot.data!.docs[i]['name']),
                    subtitle: Text(snapshot.data!.docs[i]['email'].toString()),
                  ),
                );
                }
               
           }
           return const Text("theris no user");
     
                  // return ListView(
                  //   children:
                  //       snapshot.data!.docs.map((DocumentSnapshot document) {
                  //     Map<String, dynamic> data =
                  //         document.data()! as Map<String, dynamic>;
                  //     return ListTile(
                  //       title: Text(data['email']),
                  //       subtitle: Text(data['name']),
                  //     );
                  //   }).toList(),
                  // );

                  //  Text("Full Name: ${data['email']} ${data['name']}");
                } else{
                  return Text("none");
                }  } 
             ),

            SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 224, 224, 228),
                      borderRadius: BorderRadius.circular(120),
                    ),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                    width: w,
// text
                    child: Column(
                      //  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // sign up title
                        //           Container(
                        // padding: const EdgeInsets.only(left: 10 ),
                        //    child: Row(
                        //     children: const  <Widget> [
                        //     Text(
                        //   'name: ${"hello"}' ,
                        //     style:  TextStyle(
                        //       color: Color.fromARGB(255, 14, 14, 14),
                        //        fontWeight: FontWeight.bold,
                        //       fontSize: 30,
                        //     ),

                        //   )

                        //     ],

                        //   )
                        //    ),

                        //             const SizedBox(  height: 10,),

                        //  avatar

// Container(
// child:const  CircleAvatar(
// minRadius: 50,
// maxRadius: 50,
// backgroundImage: NetworkImage("https://api.time.com/wp-content/uploads/2020/09/time-100-Selena-Gomez.jpg"),
//     ),
//   ),

                        // button container
                        GestureDetector(
                          onTap: () {
                            AuthController.instance.logOut();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            width: 150,
                            height: 60,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(700.0),
                                bottomRight: Radius.circular(700.0),
                                topLeft: Radius.circular(700.0),
                                topRight: Radius.circular(700.0),
                              ),
                              color: Color.fromARGB(255, 33, 1, 34),
                            ),
                            child: const Center(
                              child: Text("Log out",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
