import 'dart:io';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';




class PostService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  createPost(title,url) async {
    var name  =  _auth.currentUser!.displayName;
    var image  = _auth.currentUser!.photoURL;
    var id = DateTime.now();
   Post post = Post(_auth.currentUser!.displayName, _auth.currentUser!..photoURL, title, url);
    try{
      await _firestore.collection('Posts').doc(id.toString()).set({
        'uploader' : name,
        'uploaderImage' : image,
        'title' : title,
        'photo' : url,
      });

    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }
}

class Post {
  final uploader;
  final uploaderImage;
  final title;
  final photo;
  Post(this.uploader, this.uploaderImage, this.title, this.photo);
}

class CreateBlog extends StatefulWidget {
  CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  

  bool showSpinner = false;
  final postRef = FirebaseDatabase.instance.ref().child('Posts');
  firebase_storage.FirebaseStorage storage =firebase_storage.FirebaseStorage.instance;

   FirebaseAuth _auth = FirebaseAuth.instance;

  File? _image;
  final picker = ImagePicker();

  TextEditingController localisationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //pick image from the gallery
  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("no image selected");
      }
    });
  }

//pick image from the camera
  Future getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("no image selected");
      }
    });
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Container(
              height: 120,
              child: Column(children: [
                //camera
                InkWell(
                  onTap: () {
                    getCameraImage();
                    Navigator.pop(context);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Camera'),
                  ),
                ),
                //galerie
                InkWell(
                  onTap: () {
                    getImageGallery();
                    Navigator.pop(context);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Gallery'),
                  ),
                ),
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Upload Post"),
          
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    dialog(context);
                  },
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width * 1,
                      child: _image != null
                          ? ClipRRect(
                              child: Image.file(
                                _image!.absolute,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 148, 148, 148),
                                  borderRadius: BorderRadius.circular(10)),
                              width: 100,
                              height: 100,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  child: Column(children: [
                    //place
                    TextFormField(
                        controller: localisationController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Localisation",
                          hintText: "Enter post localisation",
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    //description
                    TextFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 8,
                        decoration: const InputDecoration(
                          labelText: "Description",
                          hintText: "Enter post description",
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      child: const Text('Upload'),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });

                        try {
                          int date = DateTime.now().microsecondsSinceEpoch;
                          firebase_storage.Reference ref = firebase_storage
                              .FirebaseStorage.instance
                              .ref('kampytest$date');
                          UploadTask uploadTask = ref.putFile(_image!.absolute);
                          await Future.value(uploadTask);
                          var newUrl = await ref.getDownloadURL();

                          final User? user = _auth.currentUser;

                          postRef
                              .child('Post List')
                              .child(date.toString())
                              .set({
                            'pId': date.toString(),
                            'pImage': newUrl.toString(),
                            'pTime': date.toString(),
                            'pLocalisation': localisationController.text.toString(),
                            'pDescription':
                                descriptionController.text.toString(),
                            'uEmail': user!.email.toString(),
                            'uid': user.uid.toString(),
                          }).then((value) {
                            toastMessage("Post Published");
                            setState(() {
                              showSpinner = false;
                            });
                          }).onError((error, stackTrace) {
                            toastMessage(error.toString());
                            setState(() {
                              showSpinner = false;
                            });
                          });
                        } catch (e) {
                          setState(() {
                            showSpinner = false;
                          });
                          toastMessage(e.toString());
                        }
                      },
                    )
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: "This is Center Short Toast",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0);
}