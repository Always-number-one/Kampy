import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

//crud method
import './services/crud_shop.dart';
//import create shops
import './kamp_create_shop.dart';

// hex color
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// navbar
import 'package:flutter/services.dart';
import 'navbar_animated.dart';
import 'kampy_posts.dart';
import 'kampy_shops.dart';
import 'kampy_event.dart';
import 'kampy_login.dart';
import 'kampy_signup.dart';
import 'package:get/get.dart';
import 'chat/chat_main.dart';
import './kampy_welcome.dart';
import './kamp_create_shop.dart';

class Shops extends StatefulWidget {
  Shops({Key? key}) : super(key: key);

  @override
  State<Shops> createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  // navbar

  final List<Widget> _pages = [Shops(), CreateShop(), Welcome(), CreateShop()];

// plus button array of pages
  final List<Widget> _views = [Shops(), Posts(), Chat(), Welcome()];
  int index = 0;

  shopsList() {
    //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection
    CollectionReference shops = firestore.collection('shops');
    return StreamBuilder<QuerySnapshot>(
        // build dnapshot using users collection
        stream: shops.snapshots(),
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
                  for (int i = 0; i < snapshot.data!.docs.length; i++)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    // user avatar
                                    const CircleAvatar(
                                      radius: 24.0,
                                      // backgroundImage: NetworkImage(
                                      //     snapshot.data!.docs[i]['imgUrl']),
                                      // backgroundColor: Colors.transparent,
                                    ),
                                    // user title :
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5.0,
                                          top: 25,
                                          bottom: 5),
                                      padding: const EdgeInsets.only(
                                          bottom: 5, left: 10),
                                      child: const Text(
                                        "sameh",
                                      ),
                                    ),
                                    //plus button to delete and update
                                    Container(
                                      margin: const EdgeInsets.only(left: 230),
                                      child: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 5,
                                ),
                                //  post image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    // height:
                                    //     MediaQuery.of(context).size.height *
                                    //         0.4,
                                    child: GestureDetector(
                                      child: Column(children: [
                                        
                                        // Container(
                                        //     decoration: const BoxDecoration(
                                        //       // color: Color.fromARGB(255, 248, 248, 248),
                                        //       borderRadius: BorderRadius.all(
                                        //         Radius.circular(8),
                                        //       ),
                                        //     ),
                                        //     height: 40,
                                        //     width: double.infinity,
                                        //     margin: const EdgeInsets.only(
                                        //         left: 5.0,
                                        //         right: 5.0,
                                        //         top: 00,
                                        //         bottom: 5),
                                        //     child: Row(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.center,
                                        //       // children: [
                                        //       //   Align(
                                        //       //       alignment:
                                        //       //           Alignment.center),
                                        //       //   Text(
                                        //       //       snapshot.data!.docs[i]
                                        //       //           ['title'],
                                        //       //       style: const TextStyle(
                                        //       //         fontWeight:
                                        //       //             FontWeight.bold,
                                        //       //         fontSize: 15,
                                        //       //       )),
                                        //       // ],
                                        //     )),
                                                
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 5),
                                          height: 190,
                                          width:
                                              MediaQuery.of(context).size.width,
                                              
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: NetworkImage(
                                              snapshot.data!.docs[i]['imgUrl'],
                                            ),
                                            fit: BoxFit.fill,
                                          )),
                                        ),
                                        const Padding(
                                          // ignore: unnecessary_const
                                          padding: const EdgeInsets.only(
                                              left: 18,
                                              top: 00,
                                              right: 18,
                                              bottom: 00),
                                        ),

                                            Container(
                                            decoration: const BoxDecoration(
                                              // color: Color.fromARGB(255, 228, 221, 221),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            height: 40,
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 5,
                                                bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                
                                              const  Align(
                                                    alignment:
                                                        Alignment.topLeft),
                                                const Text("Name ",
                                                    style: TextStyle(
                                                      backgroundColor: Color.fromARGB(255, 183, 180, 185),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    )),
                                                Text(": "+
                                                      snapshot.data!.docs[i]
                                                          ['title'],
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            )),
                                        const Divider(
                                          color: Color.fromARGB(
                                              255, 0, 0, 0), //color of divider
                                          height: 1, //height spacing of divider
                                          thickness:
                                              1, //thickness of divier line
                                          indent:
                                              15, //spacing at the start of divider
                                          endIndent:
                                              15, //spacing at the end of divider
                                        ),

                                        Container(
                                            decoration: const BoxDecoration(
                                              // color: Color.fromARGB(255, 228, 221, 221),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            height: 40,
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 5,
                                                bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                
                                              const  Align(
                                                    alignment:
                                                        Alignment.topLeft),
                                                const Text("Description ",
                                                    style: TextStyle(
                                                      backgroundColor: Color.fromARGB(255, 183, 180, 185),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    )),
                                                Text(": "+
                                                      snapshot.data!.docs[i]
                                                          ['description'],
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            )),
                                        const Divider(
                                          color: Color.fromARGB(
                                              255, 0, 0, 0), //color of divider
                                          height: 1, //height spacing of divider
                                          thickness:
                                              1, //thickness of divier line
                                          indent:
                                              15, //spacing at the start of divider
                                          endIndent:
                                              15, //spacing at the end of divider
                                        ),
                                        Container(
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              // color: Color.fromARGB(255, 228, 221, 221),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 5,
                                                bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Align(
                                                    alignment:
                                                        Alignment.topLeft),
                                                        const  Align(
                                                    alignment:
                                                        Alignment.topLeft),
                                                const Text("Price " ,
                                                    style: TextStyle(
                                                      backgroundColor: Color.fromARGB(255, 183, 180, 185),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    )),
                                                Text(": "+
                                                      snapshot.data!.docs[i]
                                                          ['price'] +
                                                      "DT",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )),
                                        const Divider(
                                          color: Color.fromARGB(
                                              255, 0, 0, 0), //color of divider
                                          height: 1, //height spacing of divider
                                          thickness:
                                              1, //thickness of divier line
                                          indent:
                                              15, //spacing at the start of divider
                                          endIndent:
                                              15, //spacing at the end of divider
                                        ),
                                        Container(
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 5,
                                                bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                               const Align(
                                                    alignment:
                                                        Alignment.topLeft),
                                                        const Text("P-Number ",
                                                    style: TextStyle(
                                              backgroundColor: Color.fromARGB(255, 183, 180, 185),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    )),
                                                Text(": "+
                                                      snapshot.data!.docs[i]
                                                          ['phoneN'],
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )),
                                          Container(
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              // color: Color.fromARGB(255, 228, 221, 221),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 5,
                                                bottom: 22
                                            )),
                                      ]),
                                    ),
                                  ),
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
// appp bar
      appBar: AppBar(
        title: const Text("Shops"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 20, 6, 29),
      ),
      body: shopsList(),

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
// navbar bottom ends here

      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    );
  }
}

class ShopsTitle extends StatelessWidget {
  // const ShopsTitle({Key? key}) : super(key: key);

  String id;
  final dynamic title;
  final dynamic description;
  final dynamic price;
  final dynamic phoneN;
  final dynamic imgUrl;
  ShopsTitle({
    Key? key,
    this.id = '',
    required this.title,
    required this.description,
    required this.price,
    required this.phoneN,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      // margin: const EdgeInsets.only(bottom: 16),

      height: 150,
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
              margin: const EdgeInsets.fromLTRB(20, 20, 10, 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    Text(
                      phoneN,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0)),
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
          //           title,
          //           style: const TextStyle(
          //               fontSize: 17,
          //               fontWeight: FontWeight.w400,
          //               color: Colors.white),
          //         ),
          //          Text(
          //           description,
          //           style: const TextStyle(
          //               fontSize: 17,
          //               fontWeight: FontWeight.w400,
          //               color: Colors.white),
          //         ),
          //          Text(
          //           price,
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
