// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// hex color
import 'package:hexcolor/hexcolor.dart';

import 'chat_home_page.dart';
// firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatPage extends StatefulWidget {


String? from , to ,msgId,userphoto,username;
  ChatPage({Key? key,required this.from ,this.to,this.msgId,this.userphoto,this.username}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // get message input
     final TextEditingController msgInput =TextEditingController();
  // create firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // get the collection
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  
  // authonticaion
  final FirebaseAuth auth = FirebaseAuth.instance;

    var arrMessages=[{"from":1,"message":"hello"},{"from":2,"message":"hi"},{"from":2,"message":"hi"},{"from":1,"message":"yoo"},{"from":2,"message":"how are  you doing"},{"from":1,"message":"i'm fine thanks what about you how is it going so far"},{"from":2,"message":"me too fine thanks what about you how is it going so far"}];
 messages(){
   final User? user = auth.currentUser;
    final uid = user?.uid;
 return StreamBuilder<QuerySnapshot>(
  
        // build dnapshot using users collection
        stream: chats.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)  {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading");
          }
          if (snapshot.hasData) {
           
            for (var i=0;i<snapshot.data!.docs.length;i++) {
              // get the id message 
            if (snapshot.data!.docs[i].reference.id==widget.msgId){
              return   ListView(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
        children: [
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
         for (var conv=0;conv<snapshot.data!.docs[i]['conversation'].length; conv++)
         Column(       
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if fromid is the same current user connected uid
   snapshot.data!.docs[i]['conversation'][conv]["toId"]==uid? 
      Padding(
        padding: EdgeInsets.only(right: 80,top: 20),
      
         
          child:Container(
            padding:  EdgeInsets.all(15),
           decoration: BoxDecoration(
            color:  Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
           
            child: 
                
                 Text(snapshot.data!.docs[i]['conversation'][conv]["message"].toString(),
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
            color:  Color.fromARGB(255, 96, 63, 156),
            borderRadius: BorderRadius.circular(20),
          ),
              child:Text(snapshot.data!.docs[i]['conversation'][conv]["message"].toString(),
              style: TextStyle(fontSize:  16,color: Colors.white,fontWeight: FontWeight.w500,),)
            ) ,
        
          ),
      ),


      ],      
   )]),
   
        ],



        
      );}
      
   
      }
         return Text("doesn't much with msg id ");
          } 
          return Text ("try again");
 }

 );
 }


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
      body: messages(),
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
            width: 220,
            child: TextFormField(
              controller: msgInput,
              decoration: InputDecoration(

                hintText: "Type Something",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () async {
                // get current user connected

            QuerySnapshot snapshotmsg =await chats.get();
               for (var i=0;i<snapshotmsg.docs.length;i++) {
              // get the id message 
            if (snapshotmsg.docs[i].reference.id==widget.msgId){
                  var arr=snapshotmsg.docs[i]['conversation'];
                  arr.add({'fromId':widget.from,"message":msgInput.text,"toId":widget.to});
                  await snapshotmsg.docs[i].reference.update({
                     'conversation':arr,
                  });
                  break;
            }
            }
            print("send");
            },
        
         child :Icon(
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
