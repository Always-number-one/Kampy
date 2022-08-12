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
import './services/crud_posts.dart';
// hex color
import 'package:hexcolor/hexcolor.dart';

// firebase auth
import 'package:firebase_auth/firebase_auth.dart';
// firestore
import 'package:cloud_firestore/cloud_firestore.dart';




class CreateShop extends StatefulWidget {
  CreateShop({Key? key}) : super(key: key);

  @override
  State<CreateShop> createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  final controller =TextEditingController();

  String? title,description,price,phoneN;

  File? _photo;
  bool _isLoading=false;
  final ImagePicker _picker=ImagePicker();

  CrudMethodS crudMethodS= new CrudMethodS();
  //pick image from galleryimage 
  Future imgFromGallery() async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile!= null){
        _photo=File(pickedFile.path);
      }else{
        print("No image selected,sorry");
      }
    });
  }

  //uploading data
  uploadPost()async{
    if(_photo !=null){
      setState(() {
        _isLoading=true;
      });
      FirebaseStorage _storage=FirebaseStorage.instance;
      Reference ref=_storage
      .ref()
      .child("postImages")
      .child("${randomAlphaNumeric(9)}.jpg}");
      UploadTask uploadTask=ref.putFile(_photo!);


      var downloadUrl = await(await uploadTask).ref.getDownloadURL();
      print("this is url $downloadUrl");

      Map<String,dynamic> postMap={
        "title":title??"",
        "description":description??"",
        "phoneN":phoneN??"",
        "price":price??"",
        "imgUrl":downloadUrl
      };
      crudMethodS.addData(postMap).then((result){
        Navigator.pop(context);
      });
    }else{}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
          child: SingleChildScrollView(
        child: AppBar(
          centerTitle: true,
          flexibleSpace: ClipRRect(
            child: Container(
                decoration: const BoxDecoration(
              color: Color.fromARGB(255, 42, 8, 48),
            )),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Add", style: TextStyle(fontSize: 22)),
              Text(" to Shop",
                  style: TextStyle(
                      fontSize: 22, color: Color.fromARGB(255, 255, 255, 255)))
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions:<Widget> [
            GestureDetector(
              onTap: (){
                uploadPost();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.file_upload_rounded),
              ),
            )
          ],
    ))),
    body: _isLoading
    ?Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    )
    :Container(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
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
                  decoration: const InputDecoration(hintText: "Title"),
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
                  },),
                      TextField(
                  decoration: const InputDecoration(hintText: "Phone Number"),
                  onChanged: (val){
                    phoneN=val;
                  },)
              ],
            )
          )
        ],),
    ),
          backgroundColor: const Color.fromARGB(255, 42, 8, 48),
    );
  }
}


