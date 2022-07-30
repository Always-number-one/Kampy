import 'dart:ffi';

import 'package:flutter/material.dart';
class LogIn extends StatefulWidget {
 const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
  
}

class _LogInState extends State<LogIn> {
  
  @override
  
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;



    return Scaffold(
        backgroundColor:const Color.fromARGB(255, 248, 244, 244),
      body:SingleChildScrollView(
child: Stack(
        children:<Widget> [
            Container(
     
            width: w,
            height: 400,
            
           decoration: const BoxDecoration(
                borderRadius:   BorderRadius.only(
               bottomLeft:  Radius.circular(700.0),
                bottomRight:  Radius.circular(700.0),
              ),

        image: DecorationImage(
          image: AssetImage(
              "images/background3.png"),
                  fit: BoxFit.cover,
                  
        
        )
              
              
          )
          ) , 
            Container(
              margin:  const EdgeInsets.only(left: 20,right: 20,top: 300),
              color:Color.fromARGB(108, 224, 224, 228),
             width: w,

              child:Column(
                //  crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Padding(
                  padding: EdgeInsets.all(15), //apply padding to all four sides
                
               child: Text("Sign Up",
                    textAlign: TextAlign.center,
                       style:  TextStyle(
                        fontSize: 50,
                      
                       )
                       ),
                       ),
                       const  Text("Sign into your account",
                       textAlign: TextAlign.left ,
                       style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(112, 19, 18, 18),
                       )
                       ),
                    const SizedBox(  height: 30,),
                    Row(
                      children:[
                        Expanded(child: Container(

                        ),),
                       
                      
                      ]
                    ),
                    // first input
               Container(
              margin:   const EdgeInsets.only(top:20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(151, 255, 255, 255),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                        BoxShadow(
                              blurRadius: 15,
                           offset: Offset(1, 1),
                              color: Color.fromARGB(75, 198, 202, 218),
                        )]
                      ),
                     child:TextField(
                     
                      decoration: InputDecoration(                  
                        focusedBorder: const OutlineInputBorder(
                     
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                        )
                       ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(

                          color: Color.fromARGB(255, 255, 255, 255),
                        )
                       ),
                       
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          
                        )
                      ),
                     )  
             ),
            //  second input
             
            Container(
              margin:   const EdgeInsets.only(top:20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(151, 255, 255, 255),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                        BoxShadow(
                              blurRadius: 15,
                           offset: Offset(1, 1),
                              color: Color.fromARGB(75, 198, 202, 218),
                        )]
                      ),
                     child:TextField(
                     
                      decoration: InputDecoration(                  
                        focusedBorder: const OutlineInputBorder(
                     
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                        )
                       ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(

                          color: Color.fromARGB(255, 255, 255, 255),
                        )
                       ),
                       
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          
                        )
                      ),
                     )  
             ),
            //  third input
           Container(
              margin:   const EdgeInsets.only(top:20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(151, 255, 255, 255),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                        BoxShadow(
                              blurRadius: 15,
                           offset: Offset(1, 1),
                              color: Color.fromARGB(75, 198, 202, 218),
                        )]
                      ),
                     child:TextField(
                     
                      decoration: InputDecoration(                  
                        focusedBorder: const OutlineInputBorder(
                     
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                        )
                       ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(

                          color: Color.fromARGB(255, 255, 255, 255),
                        )
                       ),
                       
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          
                        )
                      ),
                     )  
             ),
            // fourth container
                Container(
              margin:   const EdgeInsets.only(top:20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(151, 255, 255, 255),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                        BoxShadow(
                              blurRadius: 15,
                           offset: Offset(1, 1),
                              color: Color.fromARGB(75, 198, 202, 218),
                        )]
                      ),
                     child:TextField(
                     
                      decoration: InputDecoration(                  
                        focusedBorder: const OutlineInputBorder(
                     
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                        )
                       ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(

                          color: Color.fromARGB(255, 255, 255, 255),
                        )
                       ),
                       
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          
                        )
                      ),
                     )  
             ),
                ],
              ),
            ),
       
            // button container
          Container(
          margin:  const EdgeInsets.only(left: 90,right: 20,top:780,bottom: 50),

            width: 200,
            height: 70,
            
           decoration: const BoxDecoration(
                borderRadius:   BorderRadius.only(
               bottomLeft:  Radius.circular(700.0),
                bottomRight:  Radius.circular(700.0),
                topLeft:  Radius.circular(700.0),
                topRight:  Radius.circular(700.0),
              ),

           color: Color.fromARGB(255, 5, 43, 74),
            
              
          ), child: const Center(
          child : Text(
            "Sign Up",
                    textAlign: TextAlign.center,
                       style:  TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      
                       )
                       ),),
          )
       
       
        ],),),
        
    
 
               
                
                 
    );
  }
}