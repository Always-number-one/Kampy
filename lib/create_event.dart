import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  // firebase_storage.FirebaseStorage storage =
  //     firebase_storage.FirebaseStorage.instance;

  late String eventName, meetingAt, place;
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  CrudMethods crudMethods = new CrudMethods();
  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Future imgFromCamera() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.camera);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _photo = File(pickedFile.path);
  //       uploadFile();
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  // Future uploadFile() async {
  //   if (_photo == null) return;
  //   final fileName = basename(_photo!.path);
  //   final destination = 'files/$fileName';

  //   try {
  //     final ref = firebase_storage.FirebaseStorage.instance
  //         .ref(destination)
  //         .child('file/');
  //     await ref.putFile(_photo!);
  //   } catch (e) {
  //     print('error occured');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: ClipRRect(
            // borderRadius: const BorderRadius.only(
            //     bottomRight: Radius.circular(60),
            //     bottomLeft: Radius.circular(60)),
            child: Container(
                decoration: const BoxDecoration(
              color: Color.fromARGB(255, 42, 8, 48),
            )),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Add", style: TextStyle(fontSize: 22)),
              Text(" Event",
                  style: TextStyle(
                      fontSize: 22, color: Color.fromARGB(255, 0, 255, 0)))
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.file_upload))
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  imgFromGallery();
                },
                child: _photo != null
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _photo!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        width: MediaQuery.of(context).size.width,
                        child: const Icon(
                          Icons.add_a_photo,
                          color: Colors.black45,
                        ),
                      )),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(hintText: "Event Name"),
                    onChanged: (val) {
                      eventName = val;
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Meeting At"),
                    onChanged: (val) {
                      eventName = val;
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Place"),
                    onChanged: (val) {
                      eventName = val;
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 42, 8, 48),
    );
  }
}

//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: new Wrap(
//               children: <Widget>[
//                 new ListTile(
//                     leading: const Icon(Icons.photo_library),
//                     title: const Text('Gallery'),
//                     onTap: () {
//                       imgFromGallery();
//                       Navigator.of(context).pop();
//                     }),
//                 new ListTile(
//                   leading: const Icon(Icons.photo_camera),
//                   title: const Text('Camera'),
//                   onTap: () {
//                     imgFromCamera();
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }
