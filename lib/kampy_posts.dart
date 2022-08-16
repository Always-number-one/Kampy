import 'package:flutter/material.dart';


import 'package:flutter_application_1/kampy_create_posts.dart';

import 'kampy_map.dart';
import 'kampy_event.dart';
//import create blogs
import 'kampy_create_posts.dart';

// hex color
import 'package:hexcolor/hexcolor.dart';
// firebase auth
import 'package:firebase_auth/firebase_auth.dart';
// firestore
import 'package:cloud_firestore/cloud_firestore.dart';

// navbar

import 'navbar_animated.dart';

import 'chat/chat_main.dart';
import './kampy_welcome.dart';
import 'kampy_shops.dart';
import 'auth_controller.dart';
// import emoji
import 'kampy_emoji.dart';


class Posts extends StatefulWidget {
 const  Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts>   with SingleTickerProviderStateMixin{
// Animation controller
  late AnimationController _animationController;

  // This is used to animate the icon of the main FAB
  late Animation<double> _buttonAnimatedIcon;

  // This is used for the child FABs
 late Animation<double> _translateButton;

  // This variable determnies whether the child FABs are visible or not
  bool _isExpanded = false;

  @override
  initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 60))
      ..addListener(() {
        setState(() {});
      });

    _buttonAnimatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: 100,
      end: -20,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  // dispose the animation controller
  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // This function is used to expand/collapse the children floating buttons
  // It will be called when the primary FAB (with menu icon) is pressed
  _toggle() {
    if (_isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    _isExpanded = !_isExpanded;
  }

  // authonticaion
  final FirebaseAuth auth = FirebaseAuth.instance;
  // navbar
  final List<Widget> _pages = [Shops(),const Posts(), Welcome(),const CreatePost()];
// plus button array of pages
  final List<Widget> _views = [ const Emoji(), MapKampy(),const  Chat(), Welcome()];
  int index = 0;
  // chek user delete and likes
  bool? userCheck;
  bool? likseCheck;
  

  // check user to delete post
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
  // check users who liked the post
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
     // grab the collection posts
    CollectionReference posts = firestore.collection('posts');
    // get docs from user reference posts
    QuerySnapshot querySnapshotPosts = await posts.get();
    String? name;
   for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i]['uid'] == uid) {
      name=querySnapshot.docs[i]['name'];
       for (var j = 0; j <querySnapshotPosts.docs.length;j++) {
        
        for(var k = 0; k <querySnapshotPosts.docs[j]['postLikes'].length; k++) {
         
        if (querySnapshotPosts.docs[j]['postLikes'][k]==name){
          
     
       return   likseCheck=false;
      
         
        }
        }
       }
        return likseCheck=true;
      }
    }
   
  }


  postsList()   {

 
 
      
                  
    //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection
    CollectionReference posts = firestore.collection('posts');
    return StreamBuilder<QuerySnapshot>(
        // build dnapshot using users collection
        stream: posts.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)  {
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
                                        snapshot.data!.docs[i]['userName'],
                                      ),
                                    ),
                                    // plus button to delete and update
                                    Container(
                                      margin: const EdgeInsets.only(left: 200),
                                      child: IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: const Color.fromARGB(
                                            251, 255, 255, 255),
                                        iconSize: 36.0,
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
                                //  post image
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: SizedBox(
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
                                              // child: Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment
                                              //           .spaceAround,
                                              //   children: <Widget>[
                                              //     // next photo
                                              //     IconButton(
                                              //       icon: const Icon(Icons
                                              //           .arrow_back_ios_new_outlined),
                                              //       color: const Color.fromARGB(
                                              //           138, 255, 255, 255),
                                              //       iconSize: 36.0,
                                              //       //  next photo
                                              //       onPressed: () {},
                                              //     ),
                                              //     const SizedBox(width: 265),
                                              //     // next photo
                                              //     IconButton(
                                              //       icon: const Icon(Icons
                                              //           .arrow_forward_ios_rounded),
                                              //       color: const Color.fromARGB(
                                              //           138, 255, 255, 255),
                                              //       iconSize: 36.0,
                                              //       // previous photo
                                              //       onPressed: () {},
                                              //     ),
                                              //   ],
                                              // )
                                              ),
                                        ]),
                                      ),
                                    )),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      
                                       children: [
                                               
                  
            
                        Row(
              
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [

          // Transform(
          
          //   transform: Matrix4.translationValues(
          //     0.0,
          //     _translateButton.value * 4,
          //     0.0,
          //   ),
          //   child: FloatingActionButton(
          //     backgroundColor: const Color.fromARGB(24, 252, 250, 250),
          //     onPressed: () {/* Do something */},
          //     child: const Icon(
          //       Icons.face_retouching_natural,
          //     ),
          //   ),
          // ),
          // Transform(
          //   transform: Matrix4.translationValues(
          //     0,
          //     _translateButton.value * 3,
          //     0,
          //   ),
          //   child: FloatingActionButton(
          //     backgroundColor: const Color.fromARGB(24, 252, 250, 250),
          //     onPressed: () {/* Do something */},
          //     child: const Icon(
          //       Icons.favorite
          //     ),
          //   ),
          // ),
          // Transform(
          //   transform: Matrix4.translationValues(
          //     0,
          //     _translateButton.value * 2,
          //     0,
          //   ),
          //   child: FloatingActionButton(
          //     backgroundColor: const Color.fromARGB(24, 252, 250, 250),
          //     onPressed: () {/* Do something */},
          //     child: const Icon(Icons.face_outlined,)
          //   ),
          // ),
          // // This is the primary FAB
          // FloatingActionButton(
          //  backgroundColor: Color.fromARGB(23, 94, 11, 77),
          //   onPressed: _toggle,
          //   child: AnimatedIcon(
          //      color:Colors.transparent,
          //     icon: AnimatedIcons.play_pause,
          //     progress: _buttonAnimatedIcon,
          //   ),
          // ),
        ],
      ),
         
          // SizedBox(width: 200,),
            Text( snapshot.data!.docs[i]["likesCount"].toString()),
                      // like button posts
    //                 IconButton(
    //                     icon:const Icon(Icons.favorite)
    //               ,onPressed: ()async{
                  
    //               // get current user connected
    // final User? user = auth.currentUser;
    // final id = user?.uid;
    // //  create firestore instance
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // // grab the collection
    // CollectionReference users = firestore.collection('users');
    // // get docs from user reference
    // QuerySnapshot querySnapshot = await users.get();
    //      for (var s = 0; s < querySnapshot.docs.length; s++) {
    //   if (querySnapshot.docs[s]['uid'] == id) {
    //     print(querySnapshot.docs[s]['name']);
    //     if(querySnapshot.docs[s]['likes'].length>0){
    //   for (var j=0;j<querySnapshot.docs[s]['likes'].length;j++){
    //     print(querySnapshot.docs[s]["likes"][j]);
    //     if(snapshot.data!.docs[i].reference.id==querySnapshot.docs[s]["likes"][j]){
    //      var counter = snapshot.data!.docs[i]["likesCount"];
    //      counter--;
    //       await snapshot.data!.docs[i].reference.update({
    //                       "likesCount": counter ??0,
    //                      });
    //       var arr=querySnapshot.docs[s]["likes"];
    //       arr.removeAt(j);
         
    //      print("heryou are");
    //    return   await querySnapshot.docs[s].reference.update({
    //                       "likes": arr
    //                      });
    //     }
    //   }
    //    var count = snapshot.data!.docs[i]["likesCount"];
    //      count++;

    //       await snapshot.data!.docs[i].reference.update({
    //                       "likesCount": count
    //                      });
    //       var arr=querySnapshot.docs[s]["likes"];
    //       arr.add(snapshot.data!.docs[i].reference.id);
    //     return  await querySnapshot.docs[s].reference.update({
    //                       "likes":arr ??[]});
    //   }else{
    //     var count = snapshot.data!.docs[i]["likesCount"];
    //      count++;

    //       await snapshot.data!.docs[i].reference.update({
    //                       "likesCount": count
    //                      });
    //       var arr=querySnapshot.docs[s]["likes"];
    //       arr.add(snapshot.data!.docs[i].reference.id);
    //     return  await querySnapshot.docs[s].reference.update({
    //                       "likes":arr ??[]});
    //   }
         
      
    //   }else{
    //     print("no user matched");
    //   }
    // }

            
    //       },),

          

        
         

           
          

    
      
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                   const  Icon(
                                    
                             Icons.place_sharp,
                         color: Color.fromARGB(255, 125, 2, 2),
                             size:20.0,
                                      ),
                               Text(
                                snapshot.data!.docs[i]['localisation']
                                      ),],)
                               ] )

                               ] ),
                               
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
        title: const Text("Posts"),
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
      body: postsList(), 

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
            margin: const EdgeInsets.fromLTRB(190, 30, 00, 10),
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

