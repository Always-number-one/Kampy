

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/create_event.dart';
import 'package:flutter_application_1/services/crud.dart';
import 'package:like_button/like_button.dart';
import 'package:path/path.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_application_1/event_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

// navbar
import 'navbar_animated.dart';
import 'kampy_posts.dart';
import 'kampy_event.dart';
import 'chat/chat_main.dart';
import 'kampy_welcome.dart';
import 'kampy_shops.dart';

class KampyEvent extends StatefulWidget {
  const KampyEvent({Key? key}) : super(key: key);

  @override
  State<KampyEvent> createState() => _KampyEventState();
}

class _KampyEventState extends State<KampyEvent> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // plus button array of pages
  final List<Widget> _pages = [KampyEvent(), Shops(), Posts(), CreateEvent()];

// original navbar
  final List<Widget> _views = [KampyEvent(), Posts(), Chat(), Welcome()];
  int index = 0;
  bool? participiteCheck;
  bool? checkUser;

  checkuser(name) async {
// get current user connected
    final User? user = auth.currentUser;
    final uid = user?.uid;
    //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection
    CollectionReference users = firestore.collection('users');
    // get docs from user reference
    QuerySnapshot querySnapshot = await users.get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i]['name'] == name) {
        return true;
      }
      return false;
    }
  }

  // checkParticipate() async {
  //   // get current user connected
  //   final User? user = auth.currentUser;
  //   final uid = user?.uid;
  //   //  create firestore instance
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   // grab the collection users
  //   CollectionReference users = firestore.collection('users');
  //   // get docs from user reference users
  //   QuerySnapshot querySnapshot = await users.get();
  //   // grab the collection events
  //   CollectionReference events = firestore.collection('events');
  //   // get docs from user reference events
  //   QuerySnapshot querySnapshotEvents = await events.get();
  //   for (var i = 0; i < querySnapshot.docs.length; i++) {
  //     if (querySnapshot.docs[i]['uid'] == uid) {
  //       for (var j = 0; j < querySnapshotEvents.docs.length; j++) {
  //         for (var k = 0;
  //             k < querySnapshotEvents.docs[j]['eventUsersList'].length;
  //             k++) {
  //           if (querySnapshotEvents.docs[j]['eventUsersList'][k] ==
  //               querySnapshot.docs[i]['name']) {
  //             participiteCheck = true;

  //             break;
  //           }
  //         }
  //       }
  //       participiteCheck = false;
  //       break;
  //     }
  //   }
  // }

  eventList() {
    //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection
    CollectionReference events = firestore.collection('events');
    return StreamBuilder<QuerySnapshot>(
        // build snapshot using users collection
        stream: events.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading");
          }
          if (snapshot.hasData) {
            // checkParticipate();
            return SingleChildScrollView(
                padding: const EdgeInsets.only(top: 70),
                child: Column(children: [
                  const SizedBox(
                    height: 50,
                  ),
                  for (int i = 0; i < snapshot.data!.docs.length; i++)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    // user avatar
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 24.0,
                                          backgroundImage: NetworkImage(snapshot
                                              .data!.docs[i]['userImage']),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ],
                                    ),
                                    // user name :
                                    Container(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, left: 10),
                                      child: Text(
                                        snapshot.data!.docs[i]['username'],
                                      ),
                                    ),
                                    // plus button to delete and update
                                    Container(
                                      margin: const EdgeInsets.only(left: 220),
                                      child: IconButton(
                                        icon: const Icon(Icons.delete_outlined),
                                        color: Colors.black45,
                                        iconSize: 30.0,
                                        onPressed: () async {
                                         
                                          await checkuser(snapshot.data!.docs[i]
                                              ['username']);
                                          if (checkUser == true) {
                                            return await snapshot
                                                .data!.docs[i].reference
                                                .delete();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                //  post image
                                SingleChildScrollView(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 250,
                                    color: Colors.transparent,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EventDetails()),
                                          );
                                        },
                                        child: GridTile(
                                          footer: Container(
                                            padding: const EdgeInsets.all(8),
                                            color:
                                                Colors.blue.withOpacity(.5),
                                            child: Text(
                                              snapshot.data!.docs[i]
                                                  ['eventName'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                          child: Image.network(
                                            snapshot.data!.docs[i]['imgUrl'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                 // Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       //  like button
                                    //       ElevatedButton(
                                    //         child: LikeButton(
                                    //           isLiked: likesCheck,
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment.start,
                                    //           likeCount: snapshot.data!
                                    //               .docs[i]["eventLikes"].length,
                                    //           circleColor: const CircleColor(
                                    //               start: Color(0xff00ddff),
                                    //               end: Color(0xff00ddff)),
                                    //           bubblesColor: const BubblesColor(
                                    //             dotPrimaryColor:
                                    //                 Color(0xff33b5e5),
                                    //             dotSecondaryColor:
                                    //                 Color(0xff0099cc),
                                    //           ),
                                    //           // check if the user is already liked the event
                                    //         ),
                                    //         // update likes
                                    //         onPressed: () async {
                                    //           var arr = [];
                                    //           // check if it's the same user
                                    //           bool checked = true;
                                    //           for (var k = 0;
                                    //               k <
                                    //                   snapshot
                                    //                       .data!
                                    //                       .docs[i]["eventLikes"]
                                    //                       .length;
                                    //               k++) {
                                    //             arr.add(snapshot.data!.docs[i]
                                    //                 ["eventLikes"][k]);
                                    //             // check if it's the same user
                                    //             print(snapshot.data!.docs[i]
                                    //                     ["eventLikes"][k] ==
                                    //                 snapshot.data!.docs[i]
                                    //                     ['username']);
                                    //             if (snapshot.data!.docs[i]
                                    //                     ["eventLikes"][k] ==
                                    //                 snapshot.data!.docs[i]
                                    //                     ['username']) {
                                    //               checked = false;
                                    //             }
                                    //           }
                                    //           // if it's not the same user add like
                                    //           if (checked == true) {
                                    //             arr.add(snapshot.data!.docs[i]
                                    //                 ['username']);
                                    //           }

                                    //           await snapshot
                                    //               .data!.docs[i].reference
                                    //               .update({"eventLikes": arr});
                                    //         },
                                    //       ),

                                    //     ])
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ]),
                        ),
                      ],
                    )
                ]));
          }
          return const Text("none");
        });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
          centerTitle: true,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [HexColor('#675975'), HexColor('#7b94c4')]),
          ),
        ),
      ),

      body: eventList(),

      // navbar bottom
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
                  Icons.event_outlined,
                  Icons.shopping_bag,
                  Icons.image_rounded,
                  Icons.post_add_rounded
                ],
                backgroundColorMiddleIcon: const Color.fromARGB(255, 56, 3, 33),
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

      backgroundColor: const Color.fromARGB(240, 255, 255, 255),
    );
  }
}

class EventTile extends StatelessWidget {
  // const EventTile({Key? key}) : super(key: key);

  String id;
  final dynamic eventName;
  final dynamic place;
  final dynamic imgUrl;
  final dynamic username;
  EventTile({
    Key? key,
    this.id = '',
    required this.eventName,
    required this.place,
    required this.imgUrl,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      // margin: const EdgeInsets.only(bottom: 16),

      height: 190,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imgUrl,
              width: 170,
              height: 170,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 170,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(150, 20, 00, 140),
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      eventName,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ])),
          // Container(
          //   margin: const EdgeInsets.fromLTRB(190, 30, 00, 10),
          //   width: MediaQuery.of(context).size.width,
          //   child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget>[
          //         Text(
          //           place,
          //           style: const TextStyle(
          //               fontSize: 17,
          //               fontWeight: FontWeight.w400,
          //               color: Colors.white),
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //       ]),
          // ),
          //  Container(
          //   margin: const EdgeInsets.fromLTRB(190, 30, 00, 10),
          //   width: MediaQuery.of(context).size.width,
          //   child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget>[
          //         Text(
          //           username,
          //           style: const TextStyle(
          //               fontSize: 17,
          //               fontWeight: FontWeight.w400,
          //               color: Colors.white),
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //       ]),
          // ),
        ],
      ),
    );
  }
}

// get the data event from cloud firestore
// QuerySnapshot? eventsSnapshot;

// Widget eventsList() {
//   return SingleChildScrollView(
// child:Container(
// decoration: const BoxDecoration(
//   borderRadius: BorderRadius.only(
//     topRight: Radius.circular(60),
//   ),
//   color: Colors.white,
//   boxShadow: [
//     BoxShadow(
//       blurRadius: 15,
//       offset: Offset(1, 1),
//       color: Color.fromARGB(75, 198, 202, 218),
//     )
//   ],
// ),
// ),
//     child: Container(
//       child: eventsSnapshot != null
//           ? Column(
//               children: <Widget>[
//                 ListView.builder(
//                     padding:
//                         const EdgeInsets.only(top: 70, left: 20, right: 20),
//                     itemCount: eventsSnapshot?.docs.length,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return EventsTile(
//                         //  info: eventsSnapshot?.docs[index]['info'],
//                         eventName: eventsSnapshot?.docs[index]['eventName'],
//                         place: eventsSnapshot?.docs[index]['place'],
//                         time: eventsSnapshot?.docs[index]['time'],

//                         imgUrl: eventsSnapshot?.docs[index]['imgUrl'],
//                       );
//                     })
//               ],
//             )
//           : Container(
//               alignment: Alignment.center,
//               child: const CircularProgressIndicator(),
//             ),
//     ),
//   );
// }

// @override
// void initState() {
//   super.initState();
//   crudMethods.getData().then((result) => {eventsSnapshot = result});
// }

//create appBar and button to redirect from kampy event widget to create event widget
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
// appBar: PreferredSize(
//   preferredSize: const Size.fromHeight(180),
//   child: AppBar(
//     centerTitle: true,
//     flexibleSpace: ClipRRect(
//       // borderRadius: const BorderRadius.only(
//       //     bottomRight: Radius.circular(60),
//       //     bottomLeft: Radius.circular(0)),
//       child: Container(
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage(
//                       "images/88257fc06f6e674a8ffc2a39bd3de33a.gif"),
//                   fit: BoxFit.fill))),
//     ),
//     // title: Row(
//     //   mainAxisAlignment: MainAxisAlignment.center,
//     //   children: const [
//     //     Text("Kampy", style: TextStyle(fontSize: 22)),
//     //     Text("Events", style: TextStyle(fontSize: 22, color: Colors.orange))
//     //   ],
//     // ),
//     backgroundColor: Colors.transparent,
//     elevation: 0.0,
//   ),
// ),

// navbar bottom
// backgroundColor: Colors.white,
// bottomNavigationBar: Builder(
//     builder: (context) => AnimatedBottomBar(
//           defaultIconColor: Colors.black,
//           activatedIconColor: const Color.fromARGB(255, 56, 3, 33),
//           background: Colors.white,
//           buttonsIcons: const [
//             Icons.sunny_snowing,
//             Icons.explore_sharp,
//             Icons.messenger_outlined,
//             Icons.person
//           ],
//           buttonsHiddenIcons: const [
//             Icons.campaign_rounded,
//             Icons.shopping_bag,
//             Icons.image_rounded,
//             Icons.post_add_rounded
//           ],
//           backgroundColorMiddleIcon: const Color.fromARGB(255, 56, 3, 33),
//           onTapButton: (i) {
//             setState(() {
//               index = i;
//             });
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => _views[i]),
//             );
//           },
//           // navigate between pages
//           onTapButtonHidden: (i) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => _pages[i]),
//             );
//           },
//         )),

//       body: eventsList(),

//       // backgroundColor: HexColor("#332052"),
// floatingActionButton: Container(
//   padding: const EdgeInsets.symmetric(horizontal: 10),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: <Widget>[
//       FloatingActionButton(
//         // this hero tag for the navbar
//         heroTag: "navbar",
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const CreateEvent()));
//         },
//         backgroundColor: const Color.fromARGB(255, 34, 3, 39),
//         child: const Icon(Icons.add),

//       ),
//     ],
//   ),
// ),
// );
//   }
// }

// class EventsTile extends StatelessWidget {
// // const   EventsTile({Key? key}) : super(key: key);
//   String id;
//   final dynamic imgUrl;
//   final dynamic eventName;
//   final dynamic place;
//   final dynamic time;
//   // final dynamic info;
//   bool _isFavorited = true;
//   int _favoriteCount = 41;

//   EventsTile({
//     Key? key,
//     this.id = '',
//     required this.imgUrl,
//     required this.eventName,
//     required this.place,
//     required this.time,
//     // required this.info,
//   }) : super(key: key);
// //show the data event
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 50),
//       height: 150,
//       child: Stack(
//         children: <Widget>[
//           ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: SizedBox.fromSize(

//                   child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext context) =>
//                             const EventDetails()),
//                   );
//                 },
//                 child: Image.network(
//                   imgUrl,
//                   width: MediaQuery.of(context).size.width,
//                   fit: BoxFit.cover,
//                 ),
//               ))),
//           Container(
//             height: 150,
//             decoration: BoxDecoration(
//                 color: Colors.black45.withOpacity(0.3),
//                 borderRadius: BorderRadius.circular(8)),
// child: Container(
//   child: ElevatedButton(
//     child: const Text('Open Details'),
//     onPressed: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const EventDetails()),
//       );
//     },
//   ),
// ),
// ),
// show details button
// Container(
//   margin: const EdgeInsets.only(top: 80, left: 120),
//   child: ElevatedButton(
//     style: ElevatedButton.styleFrom(primary: Colors.transparent),
//     child: const Text('Open Details'),
//     onPressed: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const EventDetails()),
//       );
//     },
//   ),
// ),
// Rating icon
// Row(
//   mainAxisSize: MainAxisSize.min,
//   children: [
//     Container(
//       padding: const EdgeInsets.symmetric(vertical: 155),
//       child: IconButton(
//         padding: const EdgeInsets.all(0),
//         alignment: Alignment.centerRight,
//         icon: (_isFavorited
//             ? const Icon(Icons.star)
//             : const Icon(Icons.star_border)),
//         color: Color.fromARGB(255, 230, 211, 43),
//         onPressed: () {},
//       ),
//     ),
//     // Container(
//     // margin: const EdgeInsets.only(top: 150),
//     //   child: SizedBox(
//     //     child: Text('$_favoriteCount',
//     //         style:
//     //             const TextStyle(fontSize: 17, color: Colors.black)),
//     //   ),
//     // ),
//   ],
// ),
// Container(
// width: MediaQuery.of(context).size.width,
// child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: <Widget>[
//     Text(
//       eventName,
//       style: const TextStyle(
//           fontSize: 25,
//           fontWeight: FontWeight.w500,
//           color: Colors.white),
//     ),
// const SizedBox(
//   height: 4,
// ),
// Text(

//   place,
//   style: const TextStyle(
//       fontSize: 17,
//       fontWeight: FontWeight.w400,
//       color: Colors.white),
// ),
// const SizedBox(
//   height: 4,
// ),
// Text(
//   time,
//   style: const TextStyle(
//       fontSize: 17,
//       fontWeight: FontWeight.w400,
//       color: Colors.white),
// ),
// const SizedBox(
//   height: 4,
// ),
// Text(
//   info,
//   style: const TextStyle(
//       fontSize: 17,
//       fontWeight: FontWeight.w400,
//       color: Colors.white),
// ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
