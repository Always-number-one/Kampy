import 'dart:ffi';
import 'auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_controller.dart';
import 'package:flutter_application_1/kampy_signup.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class Welcome extends StatefulWidget {
String email;
 Welcome({Key? key,required this.email}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
  
}

class _WelcomeState extends State<Welcome> {
  
  @override
  
  Widget build(BuildContext context) {
   
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;



    return Scaffold(
        backgroundColor: Colors.transparent, 
     
      body:
      Stack(
        children: <Widget>[
          Container(
              
            decoration: const BoxDecoration(
              image:  DecorationImage(
              image:  AssetImage("images/background5.jpg"),
             fit: BoxFit.fill,
           )),
          ),
      
      
       SingleChildScrollView(
        
            
               

        
child: Stack(
        children:<Widget> [
         
    // sign up container
            Container(
                        decoration: BoxDecoration(
                        color:const  Color.fromARGB(0, 224, 224, 228),
                        borderRadius: BorderRadius.circular(120),
                     
                      ),
              margin:  const EdgeInsets.only(left: 20,right: 20,top: 70),
             

             width: w,
// text
              child:Column(
                //  crossAxisAlignment: CrossAxisAlignment.start,

                children:  [
                  // sign up title
   
                   
                 
         
         
             
            //  second input
 Padding(    
  padding: EdgeInsets.only(bottom: 20,top: 20,),
child:Container(

height: 200,
    child: CircleAvatar(
  
      radius: 70.0,
      backgroundColor: Color.fromARGB(0, 255, 255, 255),
      child: ClipOval(
        child: (widget.email=="")
        ? Image.asset('images/profile1.jpg',    height: 100,)
        : Image.file(File(widget.email),    height: 100,),
      ),
    ),
  


          ),) ,
 // button container
GestureDetector(
onTap: (){
  AuthController.instance.logOut();
},


               child:  Container(
                
          margin:  const EdgeInsets.only(left: 20,right: 20,bottom: 20),

            width: 150,
            height: 60,
            
           decoration: const BoxDecoration(
                borderRadius:   BorderRadius.only(
               bottomLeft:  Radius.circular(700.0),
                bottomRight:  Radius.circular(700.0),
                topLeft:  Radius.circular(700.0),
                topRight:  Radius.circular(700.0),
              ),

           color: Color.fromARGB(255, 33, 1, 34),
            
              
          ), child: const Center(
          child : Text(
            "Log out",
                    textAlign: TextAlign.center,
                       style:  TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      
                       )
                       ),),
          ),)
          // sign up 
        
 
   





             
                ],
              ),
            ),
       
  
       
       
        ],),),],
        
    
 
               
                
                 
    )           
    );
  }
}