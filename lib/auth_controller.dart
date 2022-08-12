
// import firestore 
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/kampy_posts.dart';

import 'package:flutter_application_1/kampy_event.dart';

import 'package:get/get.dart';
import 'chat/chat_main.dart';
import 'kampy_login.dart';
import 'kampy_welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:io';



//flutter toast
import 'package:fluttertoast/fluttertoast.dart';
//firebase storage
import 'package:firebase_storage/firebase_storage.dart';
//image picker
import 'package:image_picker/image_picker.dart';








// import 'kampy_navbar.dart';





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
  }
  else{

   await  Get.offAll(()=> Posts());

}
}
 register(String email, password,name ,image) async {

  try{

    
 UserCredential res = await auth.createUserWithEmailAndPassword(email: email, password: password);
User? user =res.user;


  // await FirebaseStorage.instance.ref().putData(image);
// save image in the storage
final saveStorage = await FirebaseStorage.instance.ref().child(name).putFile(File(image));
  //  save the link of the storage image in firestore
    final String downloadUrl = await saveStorage.ref.getDownloadURL();
    print(downloadUrl);
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
    "email":email,
    "uid":user.uid,
    "name":name,
    "photoUrl":downloadUrl,
    "eventName":" ",
  });

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



///

 static Future updateProfile({name ,context,image}) async {
    final _auth = FirebaseAuth.instance;

    try {
      await _auth.currentUser!.updateDisplayName(name);
      await _auth.currentUser!.updatePhotoURL(image);

    //Navigator.push(context, MaterialPageRoute(builder: (context) =>Posts()));

     Navigator.push(context, MaterialPageRoute(builder: (context) =>KampyEvent()));

    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }

  static Future uploadPick() async {
    final _storage = FirebaseStorage.instance;
    var url;
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      await _storage.ref(image!.name).putFile(File(image.path)).then((p0) {
        url = p0.ref.getDownloadURL();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }

    return url;
  }


}




