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



 
 
  

  // authonticaion
  final FirebaseAuth auth = FirebaseAuth.instance;
  // navbar
  final List<Widget> _pages = [const KampyEvent(), Shops(),const  Posts(),const CreatePost()];
// plus button array of pages
  final List<Widget> _views = [  MapKampy(), MapKampy(),const  Chat(), Welcome()];
  int index = 0;
  // chek user delete and likes
  bool? userCheck;
 bool checkEmoji=false;
  

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
              
                padding: const EdgeInsets.only(top:30),
                child: Column(children: [
                  
                  for (int i = 0; i < snapshot.data!.docs.length; i++)
                    Container(
                    
                      child:Column(
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
                                          bottom: 5, left: 30),
                                      child: Text(
                                        snapshot.data!.docs[i]['userName'],
                                      ),
                                      
                                    ),
                                    // button to delete
                                    Container(
                                      margin: const EdgeInsets.only(left: 200),
                                      child: IconButton(
                                        icon: const Icon(Icons.remove),
                                        color: const Color.fromARGB(139, 8, 6, 6),
                                        iconSize: 30.0,
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
                                // description
                                  Container(
                                      margin: const EdgeInsets.only(left:20,bottom: 10),
                                   child:  Text(snapshot.data!.docs[i]
                                              ['description'].toString()),
                                          ),
                                //  post image
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
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
                                           
                                              ),
                                        ]),
                                      ),
                                    ),
                                   const SizedBox(height: 13),
                                  
                                 
                                 Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                                       children: [
                                        // emoji button
                                       
 
             checkEmoji!=false ? 
          
      //all emojis 
      // first emoji 
                Container(
      width: 230,
      height: 40, 
       decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: Colors.white,),
               child :Row(
            children: <Widget> [
                 const  SizedBox(width:10,),
           GestureDetector(
             child :Image.asset('images/love1.png',height: 30,width:30,),
            

              onTap: () async{ 
                checkEmoji= false;
                  
                 final User? user = auth.currentUser;
    final id = user?.uid;
    //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection
    CollectionReference users = firestore.collection('users');
    // get docs from user reference
    QuerySnapshot querySnapshot = await users.get();
         for (var s = 0; s < querySnapshot.docs.length; s++) {
      if (querySnapshot.docs[s]['uid'] == id) {

        if(querySnapshot.docs[s]['likes'].length>0){
      for (var j=0;j<querySnapshot.docs[s]['likes'].length;j++){
        print(querySnapshot.docs[s]["likes"][j]);
        if(snapshot.data!.docs[i].reference.id==querySnapshot.docs[s]["likes"][j]){
         var counter = snapshot.data!.docs[i]["likesCount"];
         counter--;
          await snapshot.data!.docs[i].reference.update({
                          "likesCount": counter ??0,
                         });
          var arr=querySnapshot.docs[s]["likes"];
          arr.removeAt(j);
         
         print("heryou are");
       return   await querySnapshot.docs[s].reference.update({
                          "likes": arr
                         });
        }
      }
       var count = snapshot.data!.docs[i]["likesCount"];
         count++;

          await snapshot.data!.docs[i].reference.update({
                          "likesCount": count
                         });
          var arr=querySnapshot.docs[s]["likes"];
          arr.add(snapshot.data!.docs[i].reference.id);
        return  await querySnapshot.docs[s].reference.update({
                          "likes":arr ??[]});
                          
      }else{
        var count = snapshot.data!.docs[i]["likesCount"];
         count++;

          await snapshot.data!.docs[i].reference.update({
                          "likesCount": count
                         });
          var arr=querySnapshot.docs[s]["likes"];
          arr.add(snapshot.data!.docs[i].reference.id);
        return  await querySnapshot.docs[s].reference.update({
                          "likes":arr ??[]});
                     
                          
      }
         
      
      }else{
        print("no user matched");
      }
    }





               
          
              }
           ),
        
           const SizedBox(width: 5,),
            Text( snapshot.data!.docs[i]["likesCount"].toString()),


              //  second emoji
              GestureDetector(
             child :Image.asset('images/like1.png',height: 30,width:30,),
            
              onTap: ()async { 
                checkEmoji= false;
                  
                 final User? user = auth.currentUser;
    final id = user?.uid;
    //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection
    CollectionReference users = firestore.collection('users');
    // get docs from user reference
    QuerySnapshot querySnapshot = await users.get();
         for (var s = 0; s < querySnapshot.docs.length; s++) {
      if (querySnapshot.docs[s]['uid'] == id) {

        if(querySnapshot.docs[s]['owl'].length>0){
      for (var j=0;j<querySnapshot.docs[s]['owl'].length;j++){
        print(querySnapshot.docs[s]["owl"][j]);
        if(snapshot.data!.docs[i].reference.id==querySnapshot.docs[s]["owl"][j]){
         var counter = snapshot.data!.docs[i]["owlscount"];
         counter--;
          await snapshot.data!.docs[i].reference.update({
                          "owlscount": counter ??0,
                         });
          var arr=querySnapshot.docs[s]["owl"];
          arr.removeAt(j);
         
         print("heryou are");
       return   await querySnapshot.docs[s].reference.update({
                          "owl": arr
                         });
        }
      }
       var count = snapshot.data!.docs[i]["owlscount"];
         count++;

          await snapshot.data!.docs[i].reference.update({
                          "owlscount": count
                         });
          var arr=querySnapshot.docs[s]["owl"];
          arr.add(snapshot.data!.docs[i].reference.id);
        return  await querySnapshot.docs[s].reference.update({
                          "owl":arr ??[]});
                          
      }else{
        var count = snapshot.data!.docs[i]["owlscount"];
         count++;

          await snapshot.data!.docs[i].reference.update({
                          "owlscount": count
                         });
          var arr=querySnapshot.docs[s]["owl"];
          arr.add(snapshot.data!.docs[i].reference.id);
        return  await querySnapshot.docs[s].reference.update({
                          "owl":arr ??[]});
                     
                          
      }
         
      
      }else{
        print("no user matched");
      }
    }

              }
           ),

          const  SizedBox(width: 5,),
            Text( snapshot.data!.docs[i]["owlscount"].toString()),
             //  third emoji
             const  SizedBox(width: 5,),
           
              GestureDetector(
             child :Image.asset('images/sm.png',height: 30,width:30,),
            
              onTap: () async { 
     checkEmoji= false;
                  
                 final User? user = auth.currentUser;
    final id = user?.uid;
    //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection
    CollectionReference users = firestore.collection('users');
    // get docs from user reference
    QuerySnapshot querySnapshot = await users.get();
         for (var s = 0; s < querySnapshot.docs.length; s++) {
      if (querySnapshot.docs[s]['uid'] == id) {

        if(querySnapshot.docs[s]['dog'].length>0){
      for (var j=0;j<querySnapshot.docs[s]['dog'].length;j++){
        print(querySnapshot.docs[s]["dog"][j]);
        if(snapshot.data!.docs[i].reference.id==querySnapshot.docs[s]["dog"][j]){
         var counter = snapshot.data!.docs[i]["dogscount"];
         counter--;
          await snapshot.data!.docs[i].reference.update({
                          "dogscount": counter ??0,
                         });
          var arr=querySnapshot.docs[s]["dog"];
          arr.removeAt(j);
         
         print("heryou are");
       return   await querySnapshot.docs[s].reference.update({
                          "dog": arr
                         });
        }
      }
       var count = snapshot.data!.docs[i]["dogscount"];
         count++;

          await snapshot.data!.docs[i].reference.update({
                          "dogscount": count
                         });
          var arr=querySnapshot.docs[s]["dog"];
          arr.add(snapshot.data!.docs[i].reference.id);
        return  await querySnapshot.docs[s].reference.update({
                          "dog":arr ??[]});
                          
      }else{
        var count = snapshot.data!.docs[i]["dogscount"];
         count++;

          await snapshot.data!.docs[i].reference.update({
                          "dogscount": count
                         });
          var arr=querySnapshot.docs[s]["dog"];
          arr.add(snapshot.data!.docs[i].reference.id);
        return  await querySnapshot.docs[s].reference.update({
                          "dog":arr ??[]});
                     
                          
      }
         
      
      }else{
        print("no user matched");
      }
    }
              }
           ),
           const  SizedBox(width: 5,),
           
                  Text( snapshot.data!.docs[i]["dogscount"].toString()),
              GestureDetector(
             child :Image.asset('images/cool1.png',height: 30,width:30,),
            
              onTap: () async { 
                      checkEmoji= false;
                  
                 final User? user = auth.currentUser;
    final id = user?.uid;
    //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection
    CollectionReference users = firestore.collection('users');
    // get docs from user reference
    QuerySnapshot querySnapshot = await users.get();
         for (var s = 0; s < querySnapshot.docs.length; s++) {
      if (querySnapshot.docs[s]['uid'] == id) {

        if(querySnapshot.docs[s]['tent'].length>0){
      for (var j=0;j<querySnapshot.docs[s]['tent'].length;j++){
        print(querySnapshot.docs[s]["tent"][j]);
        if(snapshot.data!.docs[i].reference.id==querySnapshot.docs[s]["tent"][j]){
         var counter = snapshot.data!.docs[i]["tentscount"];
         counter--;
          await snapshot.data!.docs[i].reference.update({
                          "tentscount": counter ??0,
                         });
          var arr=querySnapshot.docs[s]["tent"];
          arr.removeAt(j);
         
         print("heryou are");
       return   await querySnapshot.docs[s].reference.update({
                          "tent": arr
                         });
        }
      }
       var count = snapshot.data!.docs[i]["tentscount"];
         count++;

          await snapshot.data!.docs[i].reference.update({
                          "tentscount": count
                         });
          var arr=querySnapshot.docs[s]["tent"];
          arr.add(snapshot.data!.docs[i].reference.id);
        return  await querySnapshot.docs[s].reference.update({
                          "tent":arr ??[]});
                          
      }else{
        var count = snapshot.data!.docs[i]["tentscount"];
         count++;

          await snapshot.data!.docs[i].reference.update({
                          "tentscount": count
                         });
          var arr=querySnapshot.docs[s]["tent"];
          arr.add(snapshot.data!.docs[i].reference.id);
        return  await querySnapshot.docs[s].reference.update({
                          "tent":arr ??[]});
                     
                          
      }
         
      
      }else{
        print("no user matched");
      }
    }
              }
           ),
          const  SizedBox(width: 5,),
            Text( snapshot.data!.docs[i]["tentscount"].toString()),
            ],

           
       
          )
        
         
          ):
             

               Row(
            children: <Widget> [
                 const  SizedBox(width:10,),
           GestureDetector(
             child :Image.asset('images/like1.png',height: 30,width:30,),
            
              onTap: () { 
                
         setState(() {

           checkEmoji= true;
           
         });
        
              }
           ),
            Text((snapshot.data!.docs[i]["likesCount"]+snapshot.data!.docs[i]["owlscount"]+snapshot.data!.docs[i]["dogscount"]+snapshot.data!.docs[i]["tentscount"]).toString()),
        
                 ]  ),
        // emoji2

    //         Row(
    //                              mainAxisAlignment: MainAxisAlignment.start,
    //                             children: [
    //                   // like button posts
    //                 GestureDetector(
    //                     child: Image.asset('images/like1.png',width: 35,height: 35),
    //               onTap: ()async{
                  
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
    //       Text( snapshot.data!.docs[i]["likesCount"].toString(),style:const TextStyle(fontSize:15),),
    //                             ]),

                               Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset('images/map.png',width: 35,height: 35),
                      
                               Text(
                                snapshot.data!.docs[i]['localisation'],style:const TextStyle(fontSize:15,fontWeight: FontWeight.w500)
                                      ),],)
                               ] )

                               ] ),
                               
                              ),
                             const  SizedBox(height: 20),
                            //  const Divider(
                            //               color: Color.fromARGB(35, 80, 77, 77), //color of divider
                            //               height: 3, //height spacing of divider
                            //               thickness:
                            //                   4, //thickness of divier line
                            //               indent:
                            //                   15, //spacing at the start of divider
                            //               endIndent:
                            //                   15, //spacing at the end of divider
                            //             ),
                                         const SizedBox(
                                  height: 20,
                                ),
                        
                      ],
                    ),
                    // end container
                     
                ),
                  
                ]));
                
          }
          return const Text("none");
        });
  }

 
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
                backgroundColorMiddleIcon: HexColor('#7b94c4'),
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



