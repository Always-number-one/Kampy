import 'package:flutter/material.dart';
import 'User.dart';
import 'Events.dart';
import 'Chat.dart';
import 'Posts.dart';
import 'Home.dart';
import 'Home.dart';

// call firebase
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // call firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
    
        primarySwatch: Colors.pink,
      ),
      
      home: const User(),
    );
  }
}


