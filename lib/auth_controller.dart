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
    Get.offAll(()=>  LogIn());
  }else if(user.displayName==null){
       await  Get.offAll(()=> Welcome(email:""));

  }
  else{
   await  Get.offAll(()=> Welcome(email: user.displayName!));

}
}
 register(String email, password,name) async {

  try{

    
 UserCredential res = await auth.createUserWithEmailAndPassword(email: email, password: password);
User? user =res.user;
  user?.updateDisplayName(name);

    return _user(user);

  } catch(e){
    
     Get.snackbar("error in creating user:", e.toString(),
  snackPosition: SnackPosition.BOTTOM,
  
        );
    
    

  }
}

void login(String email, password) async {

  try{
   await auth.signInWithEmailAndPassword(email: email, password: password);
    Get.offAll(()=> Welcome(email: email));

  } catch(e){


    
     Get.snackbar("error in access user:", e.toString(),
  snackPosition: SnackPosition.BOTTOM
 
        );
    
    

  }
  
}

void logOut() async{
 await auth.signOut();
}

}