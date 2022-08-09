import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_application_1/kampy_create_posts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

//crud method
import './services/crud_posts.dart';
//import create blogs
import 'kampy_create_posts.dart';

// hex color
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// navbar
import 'package:flutter/services.dart';
import 'navbar_animated.dart';
import 'kampy_posts.dart';
import 'kampy_event.dart';
import 'kampy_login.dart';
import 'kampy_signup.dart';
import 'package:get/get.dart';
import 'chat/chat_main.dart';
import './kampy_welcome.dart';

class Posts extends StatefulWidget {
  Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  // navbar
  final List<Widget> _pages = [KampyEvent(), Posts(), Welcome(), CreatePost()];
// plus button array of pages
  final List<Widget> _views = [KampyEvent(), Posts(), Chat(), Welcome()];
  int index = 0;

  postsList() {
    //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection
    CollectionReference posts = firestore.collection('posts');
    return StreamBuilder<QuerySnapshot>(
        // build dnapshot using users collection
        stream: posts.snapshots(),
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
                  const Text(
                    "KAMPY",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'MuseoModerno',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                                    CircleAvatar(
                                      radius: 24.0,
                                      backgroundImage: NetworkImage(
                                          snapshot.data!.docs[i]['imgUrl']),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    // user name :
                                    Container(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, left: 10),
                                      child: const Text(
                                        "sameh",
                                      ),
                                    ),
                                    // plus button to delete and update
                                    Container(
                                      margin: const EdgeInsets.only(left: 240),
                                      child: const Icon(
                                          Icons.control_point_rounded),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                //  post image
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: GestureDetector(
                                        child: Column(children: [
                                          Container(
                                              height: 300,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: NetworkImage(
                                                  snapshot.data!.docs[i]
                                                      ['imgUrl'],
                                                ),
                                                fit: BoxFit.fill,
                                              )),
                                              //change photo arrows :
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: const Icon(Icons
                                                        .arrow_back_ios_new_outlined),
                                                    color: const Color.fromARGB(
                                                        138, 255, 255, 255),
                                                    iconSize: 36.0,
                                                    //  next photo
                                                    onPressed: () {},
                                                  ),
                                                  const SizedBox(width: 265),
                                                  IconButton(
                                                    icon: const Icon(Icons
                                                        .arrow_forward_ios_rounded),
                                                    color: const Color.fromARGB(
                                                        138, 255, 255, 255),
                                                    iconSize: 36.0,
                                                    // previous photo
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              )),
                                        ]),
                                      ),
                                    )),

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
      body: postsList(),
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

      backgroundColor: const Color.fromARGB(240, 255, 255, 255),
    );
  }
}

class PostsTitle extends StatelessWidget {
  // const PostsTitle({Key? key}) : super(key: key);

  String id;
  final dynamic localisation;
  final dynamic description;
  final dynamic imgUrl;
  PostsTitle({
    Key? key,
    this.id = '',
    required this.localisation,
    required this.description,
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
                      localisation,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ])),
          Container(
            margin: EdgeInsets.fromLTRB(190, 30, 00, 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    description,
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

// class Posts extends StatefulWidget {
//   Posts({Key? key}) : super(key: key);

//   @override
//   State<Posts> createState() => _PostsState();
// }

// class _PostsState extends State<Posts> {
// int currentIndex=0;
// // final screens=[

// //   // CreateBlog(),

// // ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:PreferredSize(
//         preferredSize:const Size.fromHeight(200),
//       child: AppBar(
//         centerTitle: true,
//         actions: [
//           InkWell(
//             onTap: () {
//                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBlog()));

//             },
//             child: Icon(Icons.add)
//             ),
//           SizedBox(width: 22,)
//         ],
//         flexibleSpace: ClipRRect(
//           child:Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('images/88257fc06f6e674a8ffc2a39bd3de33a.gif'),
//               fit:BoxFit.fill
//             )
//           )
//         ),),
//       ),),
//       body:Container(),
//       // screens[currentIndex],
//             bottomNavigationBar: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               backgroundColor:Colors.grey.shade400,
//               unselectedItemColor: Colors.black,
//               showSelectedLabels: true,
//               showUnselectedLabels: false,
//               currentIndex:currentIndex,
//               onTap:(index)=>setState(() => currentIndex=index),
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//                        backgroundColor: Color.fromARGB(255, 79, 36, 90),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Serach',
//                         backgroundColor: Color.fromARGB(255, 79, 36, 90),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Add post',
//                        backgroundColor: Color.fromARGB(255, 79, 36, 90),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.save),
//             label: 'x',
//                        backgroundColor: Color.fromARGB(255, 79, 36, 90),
//           ),
//              BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: 'Profile',
//             backgroundColor: Color.fromARGB(255, 79, 36, 90),

//           ),
//         ],
//       ),
//     );
//   }
// }
