import 'package:flutter/material.dart';
import 'package:flutter_application_1/kampy_login.dart';
import 'kampy_signup.dart';

class Home extends StatefulWidget {
const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool checkAbout=false;
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
const SizedBox(height: 50),
checkAbout?
Column(
  children: [
    Container(
      height: 700,
   

      width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color:  Color.fromARGB(235, 255, 249, 249),
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(100.0),
          bottomRight: Radius.circular(20.0)),
            ),
      child:Column(children: [
        GestureDetector(
          onTap: (){
            setState(() {
              checkAbout=false;
            });
          },
        child:  Padding(
           padding: EdgeInsets.all(10),
      child: Text("About us",
        style: TextStyle(fontSize: 22,fontWeight:FontWeight.bold)),
       ),),
     const  Padding(  
       padding: EdgeInsets.all(40),  
       child:  Text( "With a selection of over 23,000 campsites across Europe, you will always find the perfect campsite for your vacation in the app. Detailed descriptions of the facilities, surroundings and activities, 222,000 photos, 190,000 camper reviews and 3,200 videos help you choosing your next camping destination. By caravan, motorhome, tent or in a rental accommodation at a campsite – the app shows campsites across Europe, with availability that you can even book online immediately.",
       style: TextStyle(fontSize: 17,fontWeight:FontWeight.normal),)
       
       ),
     const SizedBox(height: 50,),

      TextButton(
   
  style: TextButton.styleFrom(
   minimumSize: const Size(250,50),
    primary: const Color.fromARGB(255, 253, 253, 252),
    backgroundColor: Color.fromARGB(115, 15, 71, 117),
                     
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
    primary: const Color.fromARGB(255, 239, 239, 235),
    backgroundColor: const Color.fromARGB(170, 21, 71, 112),
  ),
  onPressed: () { 
      Navigator.push(
              context,
         MaterialPageRoute(builder: (context) => const LogIn()),
                );
  },
  child: const Text('Log In',style: TextStyle(fontSize: 15),),
)

      ],)
    ),
  



 
  ],
)  : Container(
  margin: const EdgeInsets.only(top:  500),
  child:TextButton(
   
  style: TextButton.styleFrom(
   minimumSize: const Size(250,50),
    primary: const Color.fromARGB(255, 253, 253, 252),
    backgroundColor: const Color.fromARGB(115, 15, 71, 117),
                     
  ),
  onPressed: () {
     setState(() {
       checkAbout=true;
     });
   },
  child: const Text('About us',style: TextStyle(fontSize: 20)),
),)

             
                ],
              ),
            ),
       
  
       
       
        ],),),],
        
    
 
               
                
                 
    )  
    );
  }
}