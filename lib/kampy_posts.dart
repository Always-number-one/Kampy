import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/kampy_create_posts.dart';
import 'package:path/path.dart';

//crud method
import './services/crud_posts.dart';
//import create blogs
import 'kampy_create_posts.dart';

class Posts extends StatefulWidget {
  Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  //crud method
  CrudMethodsP crudMethodsP = CrudMethodsP();
  QuerySnapshot? postsSnapshot;

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
        ?Column(
          children: <Widget>[
            ListView.builder(
              padding: const EdgeInsets.only(top: 30,left:20,right: 20),
              itemCount: postsSnapshot?.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return PostsTitle(
                  localisation:postsSnapshot?.docs[index]['localisation'],
                  description:postsSnapshot?.docs[index]['description'],
                  imgUrl:postsSnapshot?.docs[index]['imgUrl'],
                );
              }),
          ]
        )
        :Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        )
        ),
    );
  }

  @override
  void initState(){
    super.initState();
    crudMethodsP.getData().then((result)=>{postsSnapshot=result});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
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
        body: postsList(),
        backgroundColor: Color.fromARGB(212, 74, 12, 87),
        floatingActionButton: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(onPressed:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> CreateBlog())
                );
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
  final dynamic localisation ;
  final dynamic description;
  final dynamic imgUrl;
  PostsTitle({
     Key? key,
    this.id='',
    required this.localisation,
    required this.description,
    required this.imgUrl,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imgUrl,
              width: MediaQuery.of(context).size.width,
              fit:BoxFit.cover,
            ),
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8)),
          ),
          Container(
            child: Column(
              children: <Widget>[Text(localisation),Text(description)],
            ),
          )
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
