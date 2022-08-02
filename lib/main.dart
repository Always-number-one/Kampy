import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_controller.dart';
import 'kampy_user.dart';
import 'kampy_event.dart';
import 'kampy_chat.dart';
import 'kampy_posts.dart';
import 'kampy_home.dart';
import 'kampy_home.dart';
import 'kampy_login.dart';
import 'kampy_signup.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'kampy_welcome.dart';

// call firebase
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // call firebase
 WidgetsFlutterBinding.ensureInitialized();
 
  await Firebase.initializeApp().then((value)=> Get.put(AuthController()));
  // 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
    
        primarySwatch: Colors.pink,
      ),
      
      home:  SignUp(),              
    );
  }
}