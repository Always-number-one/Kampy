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
int currentIndex=0;
// final screens=[

//   // CreateBlog(),

// ];

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
              image: AssetImage('images/88257fc06f6e674a8ffc2a39bd3de33a.gif'),
              fit:BoxFit.fill
            )
          )
        ),),
      ),),
      body:Container(),
      // screens[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor:Colors.grey.shade400,
              unselectedItemColor: Colors.black,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              currentIndex:currentIndex,
              onTap:(index)=>setState(() => currentIndex=index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
                       backgroundColor: Color.fromARGB(255, 79, 36, 90),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Serach',
                        backgroundColor: Color.fromARGB(255, 79, 36, 90),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add post',
                       backgroundColor: Color.fromARGB(255, 79, 36, 90),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'x',
                       backgroundColor: Color.fromARGB(255, 79, 36, 90),
          ),
             BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: Color.fromARGB(255, 79, 36, 90),
            
          ),
        ],
      ),
    );
  }
}
