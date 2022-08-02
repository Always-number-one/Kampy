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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Search',
      style: optionStyle,
    ),
    Text(
      'Index 2: Add',
      style: optionStyle,
    ),
    Text(
      'Index 3: c',
      style: optionStyle,
    ),
     Text(
      'Index 4: profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

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
            bottomNavigationBar: BottomNavigationBar(
              currentIndex:currentIndex,
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
        currentIndex: currentIndex,
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}
