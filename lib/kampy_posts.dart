import 'package:flutter/material.dart';
import 'package:flutter_application_1/kampy_create_posts.dart';

//import create blogs
import 'kampy_create_posts.dart';

class Posts extends StatefulWidget {
  Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: const <Widget>[
           Text(
            "Kampy",
            style: TextStyle(
              fontSize: 23,color: Colors.blue,
            ),
          ),
          Text("Posts", style: TextStyle(
            fontSize: 23,color:Color.fromARGB(255, 255, 255, 255),
          ),)
        ]),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body:Container(),
      floatingActionButton: Container(
        padding:EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.center,
        children: <Widget>[
        FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBlog()
            ),);
          },
          child: Icon(Icons.add),
        )
      ]
        ),
        ),
    );
  }
}
