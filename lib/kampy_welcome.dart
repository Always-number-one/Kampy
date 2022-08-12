

import 'package:flutter_application_1/kampy_create_posts.dart';

import 'auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_controller.dart';

// hex color
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// firebase auth
import 'package:firebase_auth/firebase_auth.dart';

// navbar
import 'navbar_animated.dart';
import 'kampy_posts.dart';
import 'kampy_event.dart';
import 'chat/chat_main.dart';
import 'kampy_shops.dart' ;
import 'kamp_create_shop.dart';

import 'package:firebase_storage/firebase_storage.dart' as fStorage;






class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final List<Widget> _pages = [Shops(), Posts(), Welcome(), CreatePost()];

// plus button array of pages
  final List<Widget> _views = [Shops(), CreateShop(), Chat(), Welcome()];
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
        //appbar
         appBar: AppBar(
       title: const Text("Proflie"),
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
     
        // navbar bottom
        backgroundColor: Colors.white,
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
                    Icons.campaign_rounded,
                    Icons.shopping_bag,
                    Icons.image_rounded,
                    Icons.post_add_rounded
                  ],
                  backgroundColorMiddleIcon:
                      HexColor('#7b94c4'),
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
        body: SingleChildScrollView(
            child: Column(
          // background
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                //     image: DecorationImage(
                //   image: AssetImage("images/background5.jpg"),
                //   fit: BoxFit.fill,
                // )
              ),
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
                  }
                  if (snapshot.hasData) {
                    for (var i = 0; i < snapshot.data!.docs.length; i++) {
                      if (snapshot.data!.docs[i]['uid'] == uid) {
                        return Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          margin: const EdgeInsets.all(10),
                          child: Column(children: [

                            //the picture
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10, top: 50),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  minRadius: 90,
                                  maxRadius: 90,
                                  backgroundImage: NetworkImage(
                                    snapshot.data!.docs[i]['photoUrl']),
                                ),
                              ),
                            ),

                            //icon after the picture
                            const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.mode_outlined,
                              ),
                            ),

                            //profile photo text
                            const Padding(
                                padding: EdgeInsets.only(
                                    left: 15, bottom: 40, right: 20, top: 20),
                                child: Text("PROFILE PHOTO",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 34, 5, 61),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))),


                            //name
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, top: 10, right: 20, bottom: 00),
                              width: 400,
                              height: 74,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text:
                                                'NAME                                             \n\n',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19,
                                            )),
                                        TextSpan(
                                          text:
                                              "${snapshot.data!.docs[i]['name']}",
                                          style: const TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios),tooltip: 'Update the name',)
                                ],
                              ),
                            ),

                            //line between them
                            const Divider(
                              color: Color.fromARGB(
                                  255, 0, 0, 0), //color of divider
                              height: 1, //height spacing of divider
                              thickness: 1, //thickness of divier line
                              indent: 22, //spacing at the start of divider
                              endIndent: 22, //spacing at the end of divider
                            ),


                            //email
                            Container(
                                margin: const EdgeInsets.only(
                                  left: 20, top: 10, right: 20, bottom: 00),
                              width: 400,
                              height: 74,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text:
                                                'EMAIL                                             \n\n',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19,
                                            )),
                                        TextSpan(
                                            text:
                                                "${snapshot.data!.docs[i]['email']}",
                                            style: const TextStyle(
                                              fontSize: 19,
                                            )),
                                      ],
                                    ),
                                  ),
                                  IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios),tooltip: 'Update the email',)
                                ],
                              ),
                            ),

                            //line between them
                            const Divider(
                              color: Color.fromARGB(
                                  255, 0, 0, 0), //color of divider
                              height: 1, //height spacing of divider
                              thickness: 1, //thickness of divier line
                              indent: 22, //spacing at the start of divider
                              endIndent: 22, //spacing at the end of divider
                            ),


                            // country
                            Container(
                                margin: const EdgeInsets.only(
                                  left: 20, top: 10, right: 20, bottom: 00),
                              width: 400,
                              height: 74,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text.rich(
                                    TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                'COUNTRY                                       \n\n',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19,
                                            )),
                                        TextSpan(
                                            text: "Tunisia",
                                            // "${snapshot.data!.docs[i]['name']}",
                                            style: TextStyle(
                                              fontSize: 19,
                                            )),
                                      ],
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    setState(() {
                                      
                                    });
                                  }, icon: const Icon(Icons.arrow_forward_ios),tooltip: 'Update the country',)

                                ],
                              ),
                            ),
                          ]),
                        );
                      }
                    }
                    return const Text("there is no user");
                  } else {
                    return const Text("none");
                  }
                }),

            SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(0, 247, 247, 251),
                      borderRadius: BorderRadius.circular(120),
                    ),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                    width: w,
                    child: Column(
                      children: [
                        // button container
                        GestureDetector(
                          onTap: () {
                            AuthController.instance.logOut();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20, top: 500),
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
        )));
  }
}
