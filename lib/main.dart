 import 'package:flutter/material.dart';
 import 'kampy_user.dart';
 import 'kampy_event.dart';
 import 'kampy_chat.dart';
 import 'kampy_posts.dart';
 import 'kampy_home.dart';
 import 'kampy_home.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

 // call firebase
 import 'package:firebase_core/firebase_core.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';

 void main() async {
   // call firebase
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   // 
   runApp(const MyApp());
 }

 class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);


   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: 'Flutter Demo',
       theme: ThemeData.dark(),
      
       home: Posts(),
     );
   }
 }






// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       // Hide the debug banner
//       debugShowCheckedModeBanner: false,
//       title: 'Kindacode.com',
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   File? _image;

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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Kindacode.com'),
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(35),
//             child: Column(children: [
//               Center(
//                 child: ElevatedButton(
//                   child: const Text('Select An Image'),
//                   onPressed: _openImagePicker,
//                 ),
//               ),
//               const SizedBox(height: 35),
//               Container(
//                 alignment: Alignment.center,
//                 width: double.infinity,
//                 height: 300,
//                 color: Colors.grey[300],
//                 child: _image != null
//                     ? Image.file(_image!, fit: BoxFit.cover)
//                     : const Text('Please select an image'),
//               )
//             ]),
//           ),
//         ));
//   }
// }