import 'dart:ffi';
import 'auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_controller.dart';
import 'package:flutter_application_1/kampy_signup.dart';
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
                        color: Color.fromARGB(0, 224, 224, 228),
                        borderRadius: BorderRadius.circular(120),
                     
                      ),
              margin:  const EdgeInsets.only(left: 20,right: 20,top: 70),
             

             width: w,
// text
              child:Column(
                //  crossAxisAlignment: CrossAxisAlignment.start,

                children:  [
                  // sign up title
                  Container(
        padding: const EdgeInsets.only(left: 130 ),
           child: Row( 
            children:  <Widget> [
            Text( 
          'email: ${widget.email}' ,
            style: const TextStyle(
              color: Color.fromARGB(255, 14, 14, 14),
               fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
             
            
          )
          
            ],
       
          )
        
          
          ),
                   
                    const SizedBox(  height: 10,),
         
         
             
            //  second input
         

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