import 'package:flutter/material.dart';
import 'package:flutter_application_1/kampy_welcome.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        children: <Widget>[
          Container(
              
            decoration: const BoxDecoration(
              image:  DecorationImage(
              image:  AssetImage("images/background889.jpg"),
             fit: BoxFit.fill,
           )),
          ),
      
      
       SingleChildScrollView(
        
            
               

        
child: Stack(
        children:<Widget> [
         
    // log in up 
            Container(

                        decoration: BoxDecoration(
                        color: const Color.fromARGB(0, 224, 224, 228),
                        borderRadius: BorderRadius.circular(120),
                     
                      ),
              margin:  const EdgeInsets.only(left: 20,right: 20,top: 20),
             

     
// child log in
              child:Column(
                //  crossAxisAlignment: CrossAxisAlignment.start,

                children:  [
                  // sign up title
                  Container(
                    margin: const EdgeInsets.only(top:70,left: 100 ),
        // padding: const EdgeInsets.only(left: 100  ),
           child: Row( 
            children: const  <Widget> [
            Text( 
           "Welcome",
            style: TextStyle(
              color: Color.fromARGB(255, 245, 240, 240),
               fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
             
            
          ),
        
          
            ],
       
          )
        
          
          ),
                   
                    const SizedBox(  height: 10,),
         
         
            //  Button here
          
           



            





             
                ],
              ),
            ),
       
  
       
       
        ],),),],
        
    
 
               
                
                 
    )  
    );
  }
}