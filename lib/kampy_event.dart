import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/create_event.dart';
import 'package:flutter_application_1/services/crud.dart';
import 'package:path/path.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_application_1/event_details.dart';

// navbar
import 'navbar_animated.dart';
import 'kampy_posts.dart';
import 'kampy_event.dart';
import 'chat/chat_main.dart';
import 'kampy_welcome.dart';

class KampyEvent extends StatefulWidget {
  const KampyEvent({Key? key}) : super(key: key);

  @override
  State<KampyEvent> createState() => _KampyEventState();
}

class _KampyEventState extends State<KampyEvent> {
  // navbar
  final List<Widget> _pages = [KampyEvent(), Posts(), Welcome(), Chat()];
// plus button array of pages
  final List<Widget> _views = [KampyEvent(), Posts(), Chat(), Welcome()];
  int index = 0;

  CrudMethods crudMethods = CrudMethods();

// get the data event from cloud firestore
  QuerySnapshot? eventsSnapshot;

  Widget eventsList() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            offset: Offset(1, 1),
            color: Color.fromARGB(75, 198, 202, 218),
          )
        ],
      ),
      child: SingleChildScrollView(
        child: eventsSnapshot != null
            ? Column(
                children: <Widget>[
                  ListView.builder(
                      padding:
                          const EdgeInsets.only(top: 70, left: 20, right: 20),
                      itemCount: eventsSnapshot?.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return EventsTile(
                          //  info: eventsSnapshot?.docs[index]['info'],
                          eventName: eventsSnapshot?.docs[index]['eventName'],
                          place: eventsSnapshot?.docs[index]['place'],
                          time: eventsSnapshot?.docs[index]['time'],

                          imgUrl: eventsSnapshot?.docs[index]['imgUrl'],
                        );
                      })
                ],
              )
            : Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    crudMethods.getData().then((result) => {eventsSnapshot = result});
  }

//create appBar and button to redirect from kampy event widget to create event widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      body: eventsList(),

      // backgroundColor: HexColor("#332052"),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              // this hero tag for the navbar
              heroTag: "navbar",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateEvent()));
              },
              backgroundColor: const Color.fromARGB(255, 34, 3, 39),
              child: const Icon(Icons.add),
              
            ),
          ],
        ),
      ),
    );
  }
}

class EventsTile extends StatelessWidget {
// const   EventsTile({Key? key}) : super(key: key);
  String id;
  final dynamic imgUrl;
  final dynamic eventName;
  final dynamic place;
  final dynamic time;
  // final dynamic info;
  bool _isFavorited = true;
  int _favoriteCount = 41;

  EventsTile({
    Key? key,
    this.id = '',
    required this.imgUrl,
    required this.eventName,
    required this.place,
    required this.time,
    // required this.info,
  }) : super(key: key);
//show the data event
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox.fromSize(
              
                  child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const EventDetails()),
                  );
                },
                child: Image.network(
                  imgUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ))),
          Container(
            height: 150,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8)),
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
          ),
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 155),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.centerRight,
                  icon: (_isFavorited
                      ? const Icon(Icons.star)
                      : const Icon(Icons.star_border)),
                  color: Color.fromARGB(255, 230, 211, 43),
                  onPressed: () {},
                ),
              ),
              // Container(
              // margin: const EdgeInsets.only(top: 150),
              //   child: SizedBox(
              //     child: Text('$_favoriteCount',
              //         style:
              //             const TextStyle(fontSize: 17, color: Colors.black)),
              //   ),
              // ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  eventName,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
