// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';


class ChatSample extends StatefulWidget {
  const ChatSample({Key? key}) : super(key: key);
  
  @override
  State<ChatSample> createState() => _ChatSampleState();
}

class _ChatSampleState extends State<ChatSample> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(right: 80),
        child: ClipPath(
          clipper:UpperNipMessageClipper(MessageType.receive),
          child:Container(
            padding:  EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFE1E1E2),
            ),
            child: Text("recieved Message",
            style: TextStyle(fontSize: 16),),
          ) ,
        ),
        ),
      Container(
        alignment:Alignment.centerRight   ,
        child: Padding(padding: EdgeInsets.only(top: 20, left: 200),
          child: ClipPath(
            clipper:UpperNipMessageClipper(MessageType.send),
            child:Container(
              padding:  EdgeInsets.only(left: 20,top:10,bottom: 25,right: 20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 57, 1, 59), 
               
              ),
              child: Text("Send Message",
              style: TextStyle(fontSize:  16,color: Colors.white),),
            ) ,
          ),
          ),
      ),


      ],      
    );
  }
}