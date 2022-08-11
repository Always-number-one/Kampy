import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import './services/crud_shop.dart';

// import 'package:flutter_application_1/services/crud.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:random_string/random_string.dart';


import 'package:flutter/widgets.dart';
// hex color
import 'package:hexcolor/hexcolor.dart';

// firebase auth
import 'package:firebase_auth/firebase_auth.dart';
// firestore
import 'package:cloud_firestore/cloud_firestore.dart';






class CreateShop extends StatefulWidget {
  const CreateShop({Key? key}) : super(key: key);

  @override
  State<CreateShop> createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  final controller =TextEditingController();
// authonticaion
final FirebaseAuth auth = FirebaseAuth.instance;

  String? title,description,price,phoneN,userName,userImage;

  File? _photo;
  bool _isLoading=false;
  final ImagePicker _picker=ImagePicker();

  CrudMethodS crudMethodS=  CrudMethodS();
  //pick image from galleryimage 
  Future imgFromGallery() async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile!= null){
        _photo=File(pickedFile.path);
      }
    });
  }

  //uploading data
  uploadShop()async{
    // get current user connected
     final User? user = auth.currentUser;
  final uid = user?.uid;
   //  create firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // grab the collection
    CollectionReference users = firestore.collection('users');

    if(_photo !=null){
      setState(() {
        _isLoading=true;
      });
      FirebaseStorage storage=FirebaseStorage.instance;
      Reference ref=storage
      .ref()
      .child("shopImages")
      .child("${randomAlphaNumeric(9)}.jpg}");
      UploadTask uploadTask=ref.putFile(_photo!);

        // get docs from user reference 
        QuerySnapshot querySnapshot = await users.get();
     
       for (var i=0; i <querySnapshot.docs.length; i++){
        if (querySnapshot.docs[i]['uid']==uid){
         userName= querySnapshot.docs[i]['name'];
        userImage=querySnapshot.docs[i]['photoUrl'];
          
        
       }
          }
      var downloadUrl = await(await uploadTask).ref.getDownloadURL();
      print("this is url $downloadUrl");

      Map<String,dynamic> shopMap={
        "title":title??"",
        "description":description??"",
        "price":price??"",
        "phoneN":phoneN??"",
        "imgUrl":downloadUrl,
         "userName":userName??"",
         "userImage":userImage??"",
      };
      crudMethodS.addData(shopMap).then((result){
        Navigator.pop(context);
      });
    }else{}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
          centerTitle: true,
          flexibleSpace:   Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [HexColor('#675975'), HexColor('#7b94c4')]),
          ),
        ),
              title: const Text("Add to Shop"),
 
          elevation: 0.0,
          actions:<Widget> [
            GestureDetector(
              onTap: (){
                uploadShop();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.file_upload_rounded),
              ),
            )
          ],
    ),
    body: 
    
    
    _isLoading
    ?Container(
        decoration:  const BoxDecoration(
              image:  DecorationImage(
              image:  AssetImage("images/background889.jpg"),
             fit: BoxFit.fill,
           )),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    )
    :SingleChildScrollView( 
      
      child :Container(
      height: MediaQuery.of(context).size.height,
      decoration:  const BoxDecoration(
              image:  DecorationImage(
              image:  AssetImage("images/background889.jpg"),
             fit: BoxFit.fill,
           )),
    
        child: Column(
        children: <Widget>[
          const SizedBox(
            height: 250,
          ),
          GestureDetector(
            onTap: (){
              imgFromGallery();
            },
            child: _photo != null
            ?Container(
              margin: 
              const EdgeInsets.symmetric(horizontal: 15),
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(borderRadius: BorderRadius.circular(8),
              child: Image.file(
                _photo!,
                fit:BoxFit.cover,
              ),
              ),
            )
            :Container(
              margin: 
              const EdgeInsets.symmetric(horizontal: 15),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              width: MediaQuery.of(context).size.width,
              child: const Icon(
                Icons.add_a_photo,
                color: Colors.black,
              ),
            )
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8.0),
            child:Column(
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(hintText: "Name"),
                  onChanged: (val){
                    title=val;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "Description"),
                  onChanged: (val){
                    description=val;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "Price"),
                  onChanged: (val){
                    price=val;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "Phone Number"),
                  onChanged: (val){
                    phoneN=val;
                  },
                ),
              ],
            )
          ),
           
        ],),

    ), )     
    );
  }
}







