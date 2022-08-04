import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat/chat_main.dart';
import 'kampy_login.dart';
import 'kampy_welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'kampy_navbar.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthController extends  GetxController {

  // when you want to access tap: AuthController.instance....
 static AuthController instance = Get.find();
 FirebaseAuth auth = FirebaseAuth.instance;

// the bellow line will include user information
late Rx<User?> _user;
// auth will allow us to access to alot of properties from firebase


@override 
 void onReady() async {
    super.onReady();
  _user= Rx<User?>(auth.currentUser);
  // whenever things change in the user the above _user the app will be notified 
  _user.bindStream(auth.userChanges());
  ever(_user,_initialScreen);
}

_initialScreen(User? user)async {
   
  if (user==null){
    Get.offAll(()=>  LogIn());
  }else if(user.photoURL==null){

       await  Get.offAll(()=> Welcome(email:""));
//  await  Get.offAll(()=> NavBar());
  }
  else{
   await  Get.offAll(()=> Welcome( email: user.photoURL!));
//  await  Get.offAll(()=> NavBar());
}
}
 register(String email, password,name ,image) async {

  try{

    
 UserCredential res = await auth.createUserWithEmailAndPassword(email: email, password: password);
User? user =res.user;

  await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
    "email":email,
    "uid":user.uid,
    "name":name,
    "photoUrl":image,
  });
  // await FirebaseStorage.instance.ref().putData(image);

 await FirebaseStorage.instance.ref().child(name).putFile(File(image));
   
  await user.updatePhotoURL(image);
print(image);
print(user.photoURL);

    return _user(user);

  } catch(e){
    print(e);
    Get.snackbar(
              "error in creating user:", e.toString(),
               icon: const Icon(Icons.person, color: Color.fromARGB(255, 25, 1, 22)),
               snackPosition: SnackPosition.BOTTOM,
               backgroundColor:const  Color.fromARGB(255, 253, 255, 253),
               borderRadius: 20,
               margin:const  EdgeInsets.all(15),
               colorText: const Color.fromARGB(255, 5, 0, 0),
               duration: const Duration(seconds: 4),
               isDismissible: true,
               forwardAnimationCurve: Curves.easeOutBack,

               );
   
    

  }
}

void login(String email, password) async {

  try{
   await auth.signInWithEmailAndPassword(email: email, password: password);
   

  } catch(e){


     Get.snackbar(
              "error in creating user:", e.toString(),
               icon: const Icon(Icons.person, color: Color.fromARGB(255, 55, 4, 47)),
               snackPosition: SnackPosition.BOTTOM,
               backgroundColor: Colors.white,
               borderRadius: 20,
               margin:const  EdgeInsets.all(15),
               colorText: const Color.fromARGB(255, 6, 0, 0),
               duration: const Duration(seconds: 4),
               isDismissible: true,
               forwardAnimationCurve: Curves.easeOutBack,

               );
    

  }
  
}

void logOut() async{
 await auth.signOut();
}

}