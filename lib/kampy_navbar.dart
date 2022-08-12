
import 'package:flutter/material.dart';

import 'navbar_animated.dart';


import 'kampy_posts.dart';
import 'kampy_event.dart';


import 'kampy_welcome.dart';
import 'chat/chat_main.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
  //   runApp(NavBar());
  // });
}

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

//   final List<Widget>   _views = [
//  Container( child:const Center(child:   Text("weather", style: TextStyle(color: Color.fromARGB(255, 56, 3, 33), fontWeight: FontWeight.bold)))),
//     Container(child: const Center(child: Text("map", style: TextStyle(color: Color.fromARGB(255, 56, 3, 33), fontWeight: FontWeight.bold)))),
//     Container(child: const Center(child: Text("messages", style: TextStyle(color: Color.fromARGB(255, 56, 3, 33), fontWeight: FontWeight.bold)))),
//     Container(child: const Center(child: Text("profile", style: TextStyle(color: Color.fromARGB(255, 56, 3, 33), fontWeight: FontWeight.bold))))
//   ];
 final List<Widget>   _pages = [
const  KampyEvent(),const Posts(),Welcome(),const Chat()
  ];
// plus button array of pages
  final List<Widget>   _views = [
 const KampyEvent(),const Posts(),const Chat(),Welcome()
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      bottomNavigationBar:  Builder(builder: (context) =>
        AnimatedBottomBar(
            defaultIconColor: Colors.black,
            activatedIconColor: const Color.fromARGB(255, 56, 3, 33),
            background: Colors.white,
            buttonsIcons:const  [Icons.sunny_snowing, Icons.explore_sharp, Icons.messenger_outlined, Icons.person],
            buttonsHiddenIcons:const  [Icons.campaign_rounded, Icons.shopping_bag, Icons.image_rounded ,Icons.post_add_rounded],
            backgroundColorMiddleIcon: const Color.fromARGB(255, 56, 3, 33),
            onTapButton: (i){
              setState(() {
                index = i;
              });
              Navigator.push(
              context,
         MaterialPageRoute(builder: (context) => _views[i]),
                );
            },
            // navigate between pages
            onTapButtonHidden: (i){
    
              // _alertExample("You touched at button of index $i");
               Navigator.push(
              context,
         MaterialPageRoute(builder: (context) => _pages[i]),
                );
            },
          )
        )
      
    );
  }

}