import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/kampy_event.dart';
import 'package:flutter_application_1/create_event.dart';

class EventDetails extends StatefulWidget {
  final String? events;

  const EventDetails({super.key, this.events});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
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
                                      padding: const EdgeInsets.only(
                                          bottom: 5, left: 10),
                                      child: Text(
                                        snapshot.data!.docs[i]['place'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,)
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, left: 10),
                                      child: Text(
                                        snapshot.data!.docs[i]['description'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,)
                                      ),
                                    ),
                                  ],
                                ),

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
