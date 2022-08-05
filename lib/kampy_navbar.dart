// import 'package:flutter/material.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// // import 'package:navbar_google/widgets.dart';

// class NavBar extends StatefulWidget {
//   const NavBar({Key? key}) : super(key: key);

//   @override
//   _NavBarState createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   PageController pageController = PageController(initialPage: 0);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(0),
//           child: Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                       spreadRadius: -10,
//                       blurRadius: 60,
//                       color: Colors.black.withOpacity(.4),
//                       offset: const Offset(0, 25))
//                 ]),
//             child: GNav(
//               activeColor:const Color.fromARGB(255, 59, 7, 65), // unselected icon color

//               curve: Curves.fastOutSlowIn,
//               duration: const Duration(milliseconds: 600),
//               //Adding buttons 
//               tabs: const [
//                 GButton(
//                   gap: 10,
//                   icon: LineIcons.home,
//                   iconColor: Colors.black,
//                   iconActiveColor: Color.fromARGB(255, 47, 2, 38),
//                   text: "Home",
//                 ),
//                 GButton(
//                   gap: 10,
//                   icon: Icons.add_circle_outline,
//                   iconColor: Colors.black,
//                   iconActiveColor: Color.fromARGB(255, 41, 2, 35),
//                   text: "Add",
//                 ),
//                 GButton(
//                   gap: 10,
//                   icon: Icons.messenger_outline_rounded,
//                   iconColor: Colors.black,
//                   iconActiveColor: Color.fromARGB(255, 36, 2, 29),
//                   text: "messages",
//                 ),
//                 GButton(
//                   gap: 10,
//                   icon: Icons.account_circle_outlined,
//                   iconColor: Colors.black,
//                   iconActiveColor: Color.fromARGB(255, 46, 4, 46),
//                   text: "Profile",
                 
           
//                 ),
//               ],
// // To change padge according to selection
//               onTabChange: (index) {
//                 pageController.animateToPage(index,
//                     duration: const Duration(milliseconds: 600),
//                     curve: Curves.fastOutSlowIn);
//               },
//             ),
//           ),
//         ),
//       ),
//       body: PageView(
//         controller: pageController,
//         //Physics define the nature of pageview 
//         physics: const NeverScrollableScrollPhysics(),
//         //Items arranged according to Gnav Button
//         // children: [home(),game(),balance(),rules()],
//       ),
//     );
//   }
// }

















import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navbar_animated.dart';


import 'kampy_posts.dart';
import 'kampy_event.dart';
import 'kampy_login.dart';
import 'kampy_signup.dart';
import 'package:get/get.dart';

import 'kampy_welcome.dart';
import 'chat/chat_main.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
  //   runApp(NavBar());
  // });
}

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
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
 KampyEvent(),Posts(),Welcome(),Chat()
  ];
// plus button array of pages
  final List<Widget>   _views = [
 KampyEvent(),Posts(),Chat(),Welcome()
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
              print(i);
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

  Future<void> _alertExample(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
       
        return AlertDialog(
          title: const Text('Alert example'),
          content: Container(child: Text(message)),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}