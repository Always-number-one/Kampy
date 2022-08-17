
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_controller.dart';
import 'package:flutter_application_1/kampy_signup.dart';
class LogIn extends StatefulWidget {
 const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
  
}

class _LogInState extends State<LogIn> {
     // decalare email and password
   final TextEditingController emailController =TextEditingController();
    final TextEditingController passwordController =TextEditingController();
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
             

             width: w,
// child log in
              child:Column(

                children:  [
                  // sign up title
                  Container(
                    margin: const EdgeInsets.only(top:80,left:70 ),
        // padding: const EdgeInsets.only(left: 100  ),
           child: Row( 
            children:   <Widget> [
          //   Text( 
          //  "Kampy",
          //   style: TextStyle(
          //     color: Color.fromARGB(255, 245, 240, 240),
          //      fontWeight: FontWeight.bold,
          //     fontSize: 50,
          //   ),
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
       
          )
        
          
          ),
                   
                    const SizedBox(  height: 200,),
         
         
             
            //  first input
             
            Container(
             height: 50,
                   width: 230,
              margin:   const EdgeInsets.only(top:50,right:20,left:20),
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
                     controller: emailController,
                      decoration: InputDecoration(   
                           hintText: "Email",  
                       prefixIcon:const Icon(Icons.email,color: Color.fromARGB(255, 2, 2, 41),) ,         
               
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
            height: 50,
                   width: 230,
              margin:   const EdgeInsets.only(top:20,right:20,left:20,bottom: 10),
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
                     controller: passwordController,
                     obscureText: true,
                      decoration: InputDecoration(  
                           hintText: "Password",      
                        prefixIcon:const Icon(Icons.password,color:Color.fromARGB(255, 2, 2, 41)) ,         
            
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
           

 // button container
GestureDetector(
  onTap: (){
    AuthController.instance.login(emailController.text.trim(), passwordController.text.trim());
  },
                 child:Container(
          margin:  const EdgeInsets.only(left: 20,right: 20,bottom: 20),

             width: 170,
            height: 50,
            
          decoration: const BoxDecoration(
                borderRadius:   BorderRadius.only(
               bottomLeft:  Radius.circular(500.0),
                bottomRight:  Radius.circular(300.0),
                topLeft:  Radius.circular(400.0),
                topRight:  Radius.circular(400.0),
              ),

          color: Color.fromARGB(64, 2, 2, 41),
            
              
          ), child: const Center(
          child : Text(
            "Log In",
                    textAlign: TextAlign.center,
                       style:  TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      
                       )
                       ),),
          ),),
          // sign up 
            GestureDetector(
 
     child: Container(

        padding: const EdgeInsets.only(left: 30,bottom: 40,top: 110),
           child: Row( 
            children:const <Widget> [
            Text( 
           "Don't have an account?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ), 
            
          ),
              Text( 
        
           " Sign Up",
            style:  TextStyle(
              color: Colors.amber,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              
            ), 
            
            
          ),
          
            ],
       
          )
        
          
          )
,onTap: () { 
          Navigator.push(
              context,
         MaterialPageRoute(builder: (context) => const SignUp()),
                );
              },),
            




             
                ],
              ),
            ),
       
  
       
       
        ],),),],
        
    
 
               
                
                 
    )           
    );
  }
}