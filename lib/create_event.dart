import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:random_string/random_string.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  // firebase_storage.FirebaseStorage storage =
  //     firebase_storage.FirebaseStorage.instance;
  final controller = TextEditingController();

  String? eventName, place, time;

  File? _photo;
  bool _isLoading = false;
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

  uploadEvent() async {
    if (_photo != null) {
      setState(() {
        _isLoading = true;
      });
      // await FirebaseAuth.instance.signInAnonymously();
      // uploading image to firebase storage
      FirebaseStorage _storage = FirebaseStorage.instance;
      Reference ref = _storage
          .ref()
          .child("eventImages")
          .child("${randomAlphaNumeric(9)}.jpg");
      UploadTask uploadTask = ref.putFile(_photo!);

      var downloadUrl = await (await uploadTask).ref.getDownloadURL();
      print("this is url $downloadUrl");
      // uploadTask.then((res) {
      //   res.ref.getDownloadURL();
      // });
      Map<String, dynamic> eventMap = {
        "imgUrl": downloadUrl,
        "eventName": eventName ?? "",
        "place": place ?? "",
        "time": time ?? ""
      };
      crudMethods.addData(eventMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

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
                      fontSize: 22, color: Colors.white))
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  uploadEvent();
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(Icons.file_upload)))
          ],
        ),
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : Container(
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration:
                              const InputDecoration(hintText: "Event Name"),
                          onChanged: (val) {
                            eventName = val;
                          },
                        ),
                        TextField(
                          decoration: const InputDecoration(hintText: "Place"),
                          onChanged: (val) {
                            place = val;
                          },
                        ),
                        TextField(
                          decoration: const InputDecoration(hintText: "Time"),
                          onChanged: (val) {
                            time = val;
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
