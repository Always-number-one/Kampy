// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// hex color
import 'package:hexcolor/hexcolor.dart';

import 'chat_home_page.dart';
// 
class ChatPage extends StatefulWidget {


String? from , to ,msgId,userphoto,username;
  ChatPage({Key? key,required this.from ,this.to,this.msgId,this.userphoto,this.username}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
    var arrMessages=[{"from":1,"message":"hello"},{"from":2,"message":"hi"},{"from":2,"message":"hi"},{"from":1,"message":"yoo"},{"from":2,"message":"how are  you doing"},{"from":1,"message":"i'm fine thanks what about you how is it going so far"},{"from":2,"message":"me too fine thanks what about you how is it going so far"}];

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [HexColor('#675975'), HexColor('#7b94c4')]),
          ),
        ),
        title: Row(children: [
          IconButton(onPressed: ()=>{
            Navigator.push( context,
                                MaterialPageRoute(
                                    builder: (context) => ChatHome())
                                    )
                                
          }, icon:Icon(Icons.arrow_back)
          ),
              ClipRRect(
                borderRadius: BorderRadius.circular(45),
                child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(widget.userphoto.toString()),
                          ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  widget.username.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
      
      ),
      // body
      body: ListView(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
        children: [
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
         for (var conv=0;conv<arrMessages.length; conv++)
         Column(       
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
     arrMessages[conv]["from"]==1? 
      Padding(
        padding: EdgeInsets.only(right: 80,top: 20),
      
         
          child:Container(
            padding:  EdgeInsets.all(15),
           decoration: BoxDecoration(
            color:  Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
           
            child: 
                
                 Text(arrMessages[conv]["message"].toString(),
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),),
          ) ,
    
        ):
      Container(
        alignment:Alignment.centerRight ,
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 100),
            child:Container(
          
              padding:  EdgeInsets.all(15),
              decoration: BoxDecoration(
            color:  Color.fromARGB(255, 138, 91, 227),
            borderRadius: BorderRadius.circular(20),
          ),
              child:Text(arrMessages[conv]["message"].toString(),
              style: TextStyle(fontSize:  17,color: Colors.white,fontWeight: FontWeight.w500,),)
            ) ,
        
          ),
      ),


      ],      
   )]),
        ],
      ),
      // botttom chat
      bottomSheet:Container(
      height: 65,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 10,
          offset: Offset(0, 3),
        )
      ]),
      // ignore: prefer_const_literals_to_create_immutables
      child: Row(children: [
        
       
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Container(
            alignment: Alignment.centerRight,
            width: 250,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Type Something",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () => {print('pressed')},
          padding: EdgeInsets.only(right: 10),
          icon: Icon(
            Icons.send,
            color: Color.fromARGB(255, 148, 98, 195),
            size: 30,
          ),
        )
      ]),
    ),
    );
  }
}
