import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/kampy_event.dart';
import 'package:flutter_application_1/create_event.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventDetails extends StatefulWidget {
  final String? events;

  const EventDetails({super.key, this.events});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  int count = 0;
  bool? participiteCheck;
  bool? checkUser;

//  final FirebaseAuth auth = FirebaseAuth.instance;
//   checkuser(name) async {
// // get current user connected
//     final User? user = auth.currentUser;
//     final uid = user?.uid;
//     //  create firestore instance
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     // grab the collection
//     CollectionReference users = firestore.collection('users');
//     // get docs from user reference
//     QuerySnapshot querySnapshot = await users.get();

//     for (var i = 0; i < querySnapshot.docs.length; i++) {
//       if (querySnapshot.docs[i]['name'] == name) {
//         return true;
//       }
//       return false;
//     }
//   }

//   checkParticipate() async {
//     // get current user connected
//     final User? user = auth.currentUser;
//     final uid = user?.uid;
//     //  create firestore instance
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     // grab the collection users
//     CollectionReference users = firestore.collection('users');
//     // get docs from user reference users
//     QuerySnapshot querySnapshot = await users.get();
//     // grab the collection events
//     CollectionReference events = firestore.collection('events');
//     // get docs from user reference events
//     QuerySnapshot querySnapshotEvents = await events.get();
//     for (var i = 0; i < querySnapshot.docs.length; i++) {
//       if (querySnapshot.docs[i]['uid'] == uid) {
//         for (var j = 0; j < querySnapshotEvents.docs.length; j++) {
//           for (var k = 0;
//               k < querySnapshotEvents.docs[j]['eventUsersList'].length;
//               k++) {
//             if (querySnapshotEvents.docs[j]['eventUsersList'][k] ==
//                 querySnapshot.docs[i]['name']) {
//               participiteCheck = true;

//               break;
//             }
//           }
//         }
//         participiteCheck = false;
//         break;
//       }
//     }
//   }

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
            return SingleChildScrollView(
                padding: const EdgeInsets.only(top: 70),
                child: Column(children: [
                  // const Text(
                  //   "KAMPY EVENTS",
                  //   style: TextStyle(
                  //     fontSize: 30,
                  //     fontFamily: 'MuseoModerno',
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
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
                                const SizedBox(
                                  height: 10,
                                ),
                                //  post image
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  color: Colors.transparent,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: InkWell(
                                      onTap: () {},
                                      child: GridTile(
                                        footer: Container(
                                          padding: const EdgeInsets.all(8),
                                          color: Colors.blue.withOpacity(.5),
                                          child: Text(
                                            snapshot.data!.docs[i]['eventName'],
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
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      padding: const EdgeInsets.only(
                                        bottom: 5,
                                      ),
                                      child:
                                          Text(snapshot.data!.docs[i]['place'],
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              )),
                                    ),
                                  ],
                                ),
                                SingleChildScrollView(
                                  child: Column(
                                    // padding: const EdgeInsets.only(
                                    //     bottom: 5, left: 10),
                                    children: [
                                      Text(
                                          snapshot.data!.docs[i]['description'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Participate :", style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 2, 14, 24)),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      color:
                                          const Color.fromARGB(255, 5, 14, 29),
                                      onPressed: () {
                                        setState(() {
                                          count != 0 ? count-- : count;
                                        });
                                      },
                                    ),
                                   Text(
                                      "$count /10",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.person_add),
                                      onPressed: ()  {
                                        setState(() {
                                           count++;
                                           
                                        });
                                      },
                                    )
                                  ],
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kampy Details"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 2, 2, 41),
      ),
      body: eventList(),
    );
  }
}
