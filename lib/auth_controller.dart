import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'kampy_login.dart';
import 'kampy_welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthController extends  GetxController {

  // when yoyu want to access tap: AuthController.instance....
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
    print("log in page");
    Get.offAll(()=>  LogIn());
  }
  else{
    Get.offAll(()=> Welcome(email: user.email!));

}
}
void register(String email, password) async {

  try{
   await auth.createUserWithEmailAndPassword(email: email, password: password);

  } catch(e){
    print(e.toString());
     Get.snackbar("title", "message",
  snackPosition: SnackPosition.BOTTOM,
  titleText: const Text("account creation failed",
  style:  TextStyle(
  color:Colors.white,),
 
   
      ), messageText:const Text("account creation failed",
  style:  TextStyle(
  color:Colors.white,),)
        );
    
    

  }
}

void login(String email, password) async {

  try{
   await auth.signInWithEmailAndPassword(email: email, password: password);
    Get.offAll(()=> Welcome(email: email));
  } catch(e){
    print(e.toString());

    
    

  }
  
}

void logOut() async{
 await auth.signOut();
}

}