import 'package:flutter/material.dart';
import 'package:flutter_application_1/kampy_login.dart';
import 'kampy_signup.dart';

class Home extends StatefulWidget {
const Home({Key? key}) : super(key: key);

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

            Container(

                        decoration: BoxDecoration(
                        color: const Color.fromARGB(0, 224, 224, 228),
                        borderRadius: BorderRadius.circular(120),
                     
                      ),
              margin:  const EdgeInsets.only(left: 20,right: 20,top:0 ),
             
              child:Column(
                           children:  [
                  // welcoming text
                  Center(
          child :Container( 
            margin: const EdgeInsets.only(top:80),
            child: Column( 
           
            children:   <Widget> [
        // kampy logo
          Container(
              height: 50,
              width: 200,
            decoration: const  BoxDecoration(
              image:  DecorationImage(
              image:  AssetImage("images/version44.png"),
             fit: BoxFit.fill,
           )),
          ),
        
          
            ],
       
          )),
        
          
          ),

            //  Button create account
const SizedBox(height: 100),

TextButton(
   
  style: TextButton.styleFrom(
   minimumSize: const Size(250,50),
    primary: const Color.fromARGB(255, 253, 253, 252),
    backgroundColor: const Color.fromARGB(93, 232, 237, 241),
                     
  ),
  onPressed: () {
      Navigator.push(
              context,
         MaterialPageRoute(builder: (context) => const SignUp()),
                );
   },
  child: const Text('Create account',style: TextStyle(fontSize: 15)),
),
// button log in
const SizedBox(height: 10),
TextButton(
  
  style: TextButton.styleFrom(
       minimumSize: const Size(250,50),
    primary: const Color.fromARGB(255, 255, 255, 254),
    backgroundColor: const Color.fromARGB(93, 255, 255, 255),
  ),
  onPressed: () { 
      Navigator.push(
              context,
         MaterialPageRoute(builder: (context) => const LogIn()),
                );
  },
  child: const Text('Log In',style: TextStyle(fontSize: 15),),
)




             
                ],
              ),
            ),
       
  
       
       
        ],),),],
        
    
 
               
                
                 
    )  
    );
  }
}