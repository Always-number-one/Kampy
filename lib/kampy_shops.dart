import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'kampy_map.dart';

//crud method
import './services/crud_shop.dart';
//import create shops
import './kamp_create_shop.dart';

// hex color
import 'package:hexcolor/hexcolor.dart';

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

// like button
import 'package:like_button/like_button.dart';

// firebase auth
import 'package:firebase_auth/firebase_auth.dart';

// firestore
import 'package:cloud_firestore/cloud_firestore.dart';




class Shops extends StatefulWidget {
  Shops({Key? key}) : super(key: key);

  @override
  State<Shops> createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {


  // authonticaion
  final FirebaseAuth auth = FirebaseAuth.instance;
  // plus button array of pages
  final List<Widget> _pages = [KampyEvent(), Shops(), Posts(), CreateShop()];

// original navbar
  final List<Widget> _views = [KampyEvent(), MapKampy(), Chat(), Welcome()];
  int index = 0;
  // chek user delete and likes
  bool? userCheck;
  bool? likseCheck;

  // check user to delete shop
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
      if (querySnapshot.docs[i]['uid'] == uid) {
      
        if (querySnapshot.docs[i]['name'] == name) {
          userCheck = true;
          break;
        } else {
          userCheck = false;
          break;
        }
      }
    }
  }
  // check users who liked the shop
  checkLiked()async {
    // get current user connected
    final User? user = auth.currentUser;
    final uid = user?.uid;
    //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection users
    CollectionReference users = firestore.collection('users');
    // get docs from user reference users
    QuerySnapshot querySnapshot = await users.get();
     // grab the collection shops
    CollectionReference shops = firestore.collection('shops');
    // get docs from user reference shops
    QuerySnapshot querySnapshotShops = await shops.get();
   
  }


  shopsList()   {
                  
    //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection
    CollectionReference shops = firestore.collection('shops');
    return StreamBuilder<QuerySnapshot>(
        // build dnapshot using users collection
        stream: shops.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)  {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading");
          }
          if (snapshot.hasData) {
           checkLiked();
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
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    // user avatar
                                    CircleAvatar(
                                      radius: 24.0,
                                      backgroundImage: NetworkImage(
                                          snapshot.data!.docs[i]['userImage']),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    // user name :
                                    Container(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, left: 10),
                                      child: Text(
                                        snapshot.data!.docs[i]['userName'], style: TextStyle(
                                                      fontSize: 20,)
                                      ),
                                    ),
                                    // plus button to delete and update
                                    Container(
                                      margin: const EdgeInsets.only(left: 200),
                                      child: IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: Color.fromARGB(249, 255, 250, 250),
                                        iconSize: 29.0,
                                        onPressed: () async {
                                          // check if it's the same user
                                          await checkuser(snapshot.data!.docs[i]
                                              ['userName']);
                                          if (userCheck == true) {
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
                                //  shop image

                                              
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
                                                      // backgroundColor: Color.fromARGB(255, 183, 180, 185),
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
                                                      // backgroundColor: Color.fromARGB(255, 183, 180, 185),
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
                                                      // backgroundColor: Color.fromARGB(255, 183, 180, 185),
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
                                              // backgroundColor: Color.fromARGB(255, 183, 180, 185),
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
                                            )),] ),
                               
                              ),
                             const  SizedBox(height: 20),
                        
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
        title: const Text("Shop"),
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
      body: shopsList(), 

      // navbar bottom
      bottomNavigationBar: Builder(
          builder: (context) => AnimatedBottomBar(
                defaultIconColor: HexColor('#7b94c4'),
                activatedIconColor: HexColor('#675975'),
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
                backgroundColorMiddleIcon: HexColor('#675975'),
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
          Container(
            margin: const EdgeInsets.fromLTRB(190, 30, 00, 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  Text(
                    phoneN,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

