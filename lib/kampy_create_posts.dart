import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'dart:io';


class CreateBlog extends StatefulWidget {
  CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  File? _image;
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Post"),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Column(
            children: [
              Center(
              child: Container(
                height: MediaQuery.of(context).size.height* .2,
                width: MediaQuery.of(context).size.width*1,
                child: _image !=null ? ClipRRect(
                  child: Image.file(
                    _image!.absolute,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                ):Container(
                   decoration: BoxDecoration(
                    color: Color.fromARGB(255, 148, 148, 148),
                    borderRadius: BorderRadius.circular(10)
                   ),
                   width: 100,
                   height: 100,
                   child: const Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                   ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Form(
              child:Column(
                children: [
                  //title
                  TextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    decoration:const InputDecoration(
                      labelText:"Title",
                      hintText: "Enter post title",
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                      labelStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                  )
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //description
                  TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    minLines: 1,
                    maxLines: 20,
                    decoration:const InputDecoration(
                      labelText:"Description",
                      hintText: "Enter post description",
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                      labelStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                  )
                  ),SizedBox(
                    height: 30,
                  ),
                   ElevatedButton(
                    child: const Text('Upload'),
                    onPressed: () {

                    },)
                ]
                ) ,
              )
            ],
          ),
        ),
      ),
    );
  }
}



// class CreateBlog extends StatefulWidget {
//   const CreateBlog({Key? key}) : super(key: key);

//   @override
//   _CreateBlogState createState() => _CreateBlogState();
// }

// class _CreateBlogState extends State<CreateBlog> {
//   File? _image;
//   String desc="";
//   File ?selectedImage;
//   bool _isLoading= false;
//   CrudMethods crudMethods= new CrudMethods();

//   final _picker = ImagePicker();
//   // Implementing the image picker
//   Future<void> _openImagePicker() async {
//     final XFile? pickedImage =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _image = File(pickedImage.path);
//       });
//     }
//   }
  
//   // uploadBlog() async{
//   //   if(selectedImage!= null){
//   //     setState(() {
//   //       _isLoading=true;
//   //     });
//   //     StorageReference firebaseStorageRef=FirebaseStorage.instance
//   //     .ref()
//   //     .child('blogImages')
//   //     .child("${randomAlphaNumeric(9)}.jpg");
//   //     final StorageUploadTask task=firebaseStorageRef.putFile(selectedImage);

//   //     var downloadUrl = await(await task.onComplete).ref.getDownLoadURL();
//   //     print("this is url $downloadUrl")
//   //   }else{

//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         title: Row(
//           mainAxisAlignment:MainAxisAlignment.center,
//           children: const <Widget>[
//            Text(
//             "Kampy",
//             style: TextStyle(
//               fontSize: 23,color: Colors.blue,
//             ),
//           ),
//           Text("Posts", style: TextStyle(
//             fontSize: 23,color:Color.fromARGB(255, 0, 0, 0)
//           ),)
//         ]),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         actions:<Widget>[
//           GestureDetector(
//             onTap: () {
//               // uploadBlog();
//             },
//             child:Container(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Icon(Icons.file_upload),
//           )
//           )
//         ],
//       ),
//         body: _isLoading? SingleChildScrollView():SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(35),
//             child: Column(children: [

//               //adding pics
              
//               Center(
//                 child: ElevatedButton(
//                   child: Icon(Icons.add_a_photo),
//                   onPressed: _openImagePicker,
//                 ),
//               ),
//               const SizedBox(height: 35),
//               Container(
//                 alignment: Alignment.center,
//                 width: double.infinity,
//                 height: 200,
//                 color: Colors.grey[300],
//                 child: _image != null
//                     ? Image.file(_image!, fit: BoxFit.cover)
//                     : const Text('Please select an image'),
//               ),  SizedBox(height: 8,),

//               //input of description

//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(children:<Widget> [
//                   TextField(
//                     decoration: InputDecoration(hintText: "description"),
//                     onChanged: ((val) {
//                       desc=val;
//                     }),
//                   ),
//                 ]),
//               )
              
//             ]),
//           ),
          
          
//         ));
//   }
// }
