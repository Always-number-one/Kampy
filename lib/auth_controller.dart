import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'kampy_login.dart';
import 'kampy_home.dart';
class AuthController extends GetxController {
  // when yoyu want to access tap: AuthController.instance....
static AuthController instance = Get.find();
// the bellow line will include user information
late Rx<User?> _user;
// auth will allow us to access to alot of properties from firebase
FirebaseAuth auth = FirebaseAuth.instance;

@override 
void onInit(){
  super.onInit(); 
  _user= Rx<User?>(auth.currentUser);
  // whenever things change in the user the above _user the app will be notified 
  _user.bindStream(auth.userChanges());
  ever(_user,_initialScreen);
}

_initialScreen(User? user){
  if (user==null ){
    print("log in page");
    Get.offAll(()=>LogIn());
  }
  else{
    Get.offAll(()=>Kampy());

}

}

void register (String email,password){
  try{
      auth.createUserWithEmailAndPassword(email: email, password: password);

  }catch(e){
    Get.snackbar(("About User"), "User message",
    snackPosition:  SnackPosition.BOTTOM,
     titleText: const Text(
      "Account Creation Failed",
      style: TextStyle(
        color:Colors.white,
      ),
     ),
     messageText: Text(
      e.toString(),
      style: const TextStyle(
        color: Colors.white,
      ),
      
     )
    );
  }
}
}