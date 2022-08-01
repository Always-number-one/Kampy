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
      appBar:PreferredSize(
        preferredSize:const Size.fromHeight(200),
      child: AppBar(
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBlog()));

            },
            child: Icon(Icons.add)
            ),
          SizedBox(width: 22,)
        ],
        flexibleSpace: ClipRRect(
          child:Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/appbar.png'),
              fit:BoxFit.fill
            )
          )
        ),),
      ),),
      body:Container(),
    );
  }
}
