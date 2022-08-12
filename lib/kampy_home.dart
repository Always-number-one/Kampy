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

            Container(

                        decoration: BoxDecoration(
                        color: const Color.fromARGB(0, 224, 224, 228),
                        borderRadius: BorderRadius.circular(120),
                     
                      ),
              margin:  const EdgeInsets.only(left: 20,right: 20,top: 20),
             
              child:Column(
                           children:  [
                  // welcoming text
                  Center(
          child :Container( 
            margin: const EdgeInsets.only(top:220),
            child: Column( 
           
            children: const  <Widget> [
            Text( 
           "Welcome",
            style: TextStyle(
              color: Color.fromARGB(255, 245, 240, 240),
               fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
             
            
          ),
         
          Text( 
           "To Kampy",
            style: TextStyle(
              color: Color.fromARGB(255, 245, 240, 240),
               fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
             
            
          ),
          
        
          
            ],
       
          )),
        
          
          ),
                   
                    const SizedBox(  height: 10,),
         
         
            //  Button here
const SizedBox(height: 50),

TextButton(
  
  style: TextButton.styleFrom(
   
    primary: const Color.fromARGB(255, 231, 232, 232),
    backgroundColor: Colors.blue,
  ),
  onPressed: () { },
  child: const Text('Create account'),
),
TextButton(
  style: TextButton.styleFrom(
    primary: const Color.fromARGB(255, 6, 30, 87),
    backgroundColor: Colors.white,
  ),
  onPressed: () { },
  child: const Text('Log In'),
)




             
                ],
              ),
            ),
       
  
       
       
        ],),),],
        
    
 
               
                
                 
    )  
    );
  }
}