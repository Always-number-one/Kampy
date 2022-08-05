import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './services/crud_posts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:random_string/random_string.dart';




class CreatePost extends StatefulWidget {
  CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final controller =TextEditingController();

  String? localisation,description;

  File? _photo;
  bool _isLoading=false;
  final ImagePicker _picker=ImagePicker();

  CrudMethodsP crudMethodsP= new CrudMethodsP();
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
        "localisation":localisation??"",
        "description":description??"",
        "imgUrl":downloadUrl
      };
      crudMethodsP.addData(postMap).then((result){
        Navigator.pop(context);
      });
    }else{}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
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
              Text(" Post",
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
    )),
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
                  decoration: const InputDecoration(hintText: "Localisation"),
                  onChanged: (val){
                    localisation=val;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "Description"),
                  onChanged: (val){
                    description=val;
                  },
                ),
              ],
            )
          )
        ],),
    ),
          backgroundColor: const Color.fromARGB(255, 42, 8, 48),
    );
  }
}






// class PostService {
//   final _firestore = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;

//   createPost(title,url) async {
//     var name  =  _auth.currentUser!.displayName;
//     var image  = _auth.currentUser!.photoURL;
//     var id = DateTime.now();
//    Post post = Post(_auth.currentUser!.displayName, _auth.currentUser!..photoURL, title, url);
//     try{
//       await _firestore.collection('Posts').doc(id.toString()).set({
//         'uploader' : name,
//         'uploaderImage' : image,
//         'title' : title,
//         'photo' : url,
//       });

//     }catch(e){
//       Fluttertoast.showToast(msg: e.toString());
//       print(e);
//     }
//   }
// }

// class Post {
//   final uploader;
//   final uploaderImage;
//   final title;
//   final photo;
//   Post(this.uploader, this.uploaderImage, this.title, this.photo);
// }

// class CreateBlog extends StatefulWidget {
//   CreateBlog({Key? key}) : super(key: key);

//   @override
//   State<CreateBlog> createState() => _CreateBlogState();
// }

// class _CreateBlogState extends State<CreateBlog> {
  

//   bool showSpinner = false;
//   final postRef = FirebaseDatabase.instance.ref().child('Posts');
//   firebase_storage.FirebaseStorage storage =firebase_storage.FirebaseStorage.instance;

//    FirebaseAuth _auth = FirebaseAuth.instance;

//   File? _image;
//   final picker = ImagePicker();

//   TextEditingController localisationController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   //pick image from the gallery
//   Future getImageGallery() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print("no image selected");
//       }
//     });
//   }

// //pick image from the camera
//   Future getCameraImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print("no image selected");
//       }
//     });
//   }

//   void dialog(context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0)),
//             content: Container(
//               height: 120,
//               child: Column(children: [
//                 //camera
//                 InkWell(
//                   onTap: () {
//                     getCameraImage();
//                     Navigator.pop(context);
//                   },
//                   child: const ListTile(
//                     leading: Icon(Icons.camera),
//                     title: Text('Camera'),
//                   ),
//                 ),
//                 //galerie
//                 InkWell(
//                   onTap: () {
//                     getImageGallery();
//                     Navigator.pop(context);
//                   },
//                   child: const ListTile(
//                     leading: Icon(Icons.photo_library),
//                     title: Text('Gallery'),
//                   ),
//                 ),
//               ]),
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ModalProgressHUD(
//       inAsyncCall: showSpinner,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Upload Post"),
          
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//             child: Column(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     dialog(context);
//                   },
//                   child: Center(
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * .2,
//                       width: MediaQuery.of(context).size.width * 1,
//                       child: _image != null
//                           ? ClipRRect(
//                               child: Image.file(
//                                 _image!.absolute,
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.fitHeight,
//                               ),
//                             )
//                           : Container(
//                               decoration: BoxDecoration(
//                                   color: Color.fromARGB(255, 148, 148, 148),
//                                   borderRadius: BorderRadius.circular(10)),
//                               width: 100,
//                               height: 100,
//                               child: const Icon(
//                                 Icons.camera_alt,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Form(
//                   child: Column(children: [
//                     //place
//                     TextFormField(
//                         controller: localisationController,
//                         keyboardType: TextInputType.text,
//                         decoration: const InputDecoration(
//                           labelText: "Localisation",
//                           hintText: "Enter post localisation",
//                           border: OutlineInputBorder(),
//                           hintStyle: TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.normal),
//                           labelStyle: TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.normal),
//                         )),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     //description
//                     TextFormField(
//                         controller: descriptionController,
//                         keyboardType: TextInputType.text,
//                         minLines: 1,
//                         maxLines: 8,
//                         decoration: const InputDecoration(
//                           labelText: "Description",
//                           hintText: "Enter post description",
//                           border: OutlineInputBorder(),
//                           hintStyle: TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.normal),
//                           labelStyle: TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.normal),
//                         )),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     ElevatedButton(
//                       child: const Text('Upload'),
//                       onPressed: () async {
//                         setState(() {
//                           showSpinner = true;
//                         });

//                         try {
//                           int date = DateTime.now().microsecondsSinceEpoch;
//                           firebase_storage.Reference ref = firebase_storage
//                               .FirebaseStorage.instance
//                               .ref('kampytest$date');
//                           UploadTask uploadTask = ref.putFile(_image!.absolute);
//                           await Future.value(uploadTask);
//                           var newUrl = await ref.getDownloadURL();

//                           final User? user = _auth.currentUser;

//                           postRef
//                               .child('Post List')
//                               .child(date.toString())
//                               .set({
//                             'pId': date.toString(),
//                             'pImage': newUrl.toString(),
//                             'pTime': date.toString(),
//                             'pLocalisation': localisationController.text.toString(),
//                             'pDescription':
//                                 descriptionController.text.toString(),
//                             'uEmail': user!.email.toString(),
//                             'uid': user.uid.toString(),
//                           }).then((value) {
//                             toastMessage("Post Published");
//                             setState(() {
//                               showSpinner = false;
//                             });
//                           }).onError((error, stackTrace) {
//                             toastMessage(error.toString());
//                             setState(() {
//                               showSpinner = false;
//                             });
//                           });
//                         } catch (e) {
//                           setState(() {
//                             showSpinner = false;
//                           });
//                           toastMessage(e.toString());
//                         }
//                       },
//                     )
//                   ]),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// void toastMessage(String message) {
//   Fluttertoast.showToast(
//       msg: "This is Center Short Toast",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.white,
//       textColor: Colors.black,
//       fontSize: 16.0);
// }