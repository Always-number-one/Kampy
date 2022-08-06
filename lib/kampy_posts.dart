import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/kampy_create_posts.dart';
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
  //crud method
  CrudMethodsP crudMethodsP = CrudMethodsP();
  QuerySnapshot? postsSnapshot;
//navbar
  final List<Widget>   _pages = [
 Posts(),Posts(),Posts(),Posts()
  ];
// plus button array of pages
  final List<Widget>   _views = [
 Posts(),Posts(),Posts(),Posts()
  ];
  int index = 0;
  
  Widget postsList() {
    return Container(
      
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60),
          topLeft: Radius.circular(60),
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
          child: postsSnapshot != null
              ? Column(children: <Widget>[
                  ListView.builder(
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 20),
                      itemCount: postsSnapshot?.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return PostsTitle(
                          localisation: postsSnapshot?.docs[index]
                              ['localisation'],
                          description: postsSnapshot?.docs[index]
                              ['description'],
                          imgUrl: postsSnapshot?.docs[index]['imgUrl'],
                        );
                      }),
                ])
              : Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )),
    );
  }

  @override
  void initState() {
    super.initState();
    crudMethodsP.getData().then((result) => {postsSnapshot = result});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: ClipRRect(
            child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "images/88257fc06f6e674a8ffc2a39bd3de33a.gif"),
                        fit: BoxFit.fill))),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),


      body: postsList() ,
      // navbar bottom
        // bottomNavigationBar:  Builder(builder: (context) =>
        // AnimatedBottomBar(
        //     defaultIconColor: Colors.black,
        //     activatedIconColor: const Color.fromARGB(255, 56, 3, 33),
        //     background: Colors.white,
        //     buttonsIcons:const  [Icons.sunny_snowing, Icons.explore_sharp, Icons.messenger_outlined, Icons.person],
        //     buttonsHiddenIcons:const  [Icons.campaign_rounded, Icons.shopping_bag, Icons.image_rounded ,Icons.post_add_rounded],
        //     backgroundColorMiddleIcon: const Color.fromARGB(255, 56, 3, 33),
        //     onTapButton: (i){
        //       setState(() {
        //         index = i;
        //       });
        //       Navigator.push(
        //       context,
        //  MaterialPageRoute(builder: (context) => _views[i]),
        //         );
        //     },
        //     // navigate between pages
        //     onTapButtonHidden: (i){
        //        Navigator.push(
        //       context,
        //  MaterialPageRoute(builder: (context) => _pages[i]),
        //         );
        //     },
        //   )
        // ),
// navbar bottom ends here
      backgroundColor: Color.fromARGB(240, 255, 255, 255),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreatePost()));
              },
              backgroundColor: const Color.fromARGB(255, 34, 3, 39),
              child: const Icon(Icons.add),
            )
          ],
        ),
      ),
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
      margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
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
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(190, 0, 00, 45),
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
                      
                ),])),
                Container(
            margin: EdgeInsets.fromLTRB(190, 0, 00, 45),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget> [
                Text(description,
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
