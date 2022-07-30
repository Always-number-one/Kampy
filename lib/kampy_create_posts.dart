import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// class CreateBlog extends StatefulWidget {
//   CreateBlog({Key? key}) : super(key: key);

//   @override
//   State<CreateBlog> createState() => _CreateBlogState();
// }


// class _CreateBlogState extends State<CreateBlog> {

// String desc="";

// // CrudMethods crudMethods= new CrudMethods();



//  final ImagePicker _picker = ImagePicker();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
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
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Icon(Icons.file_upload)
//           )
//         ],
//       ),
//       body: Container(
//         child: Column(children:<Widget> [
//           SizedBox(height: 10,),
//           Container(
//           margin: EdgeInsets.symmetric(horizontal:16),  
//           height: 150,
//           decoration: BoxDecoration(
//             color: Colors.white,borderRadius:BorderRadius.circular(6)
//           ),
//           width: MediaQuery.of(context).size.width,
//           child: Icon(Icons.add_a_photo,color: Colors.black45,),
//           ),
//           SizedBox(height: 8,),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 16),
//             child: Column(children:<Widget> [
//               TextField(
//                 decoration:InputDecoration(hintText: "description"),
//                 onChanged: (val){
//                   desc=val;
//                 },
//               )
//             ]),
//           )
//         ],),
//       ),
//     );
//   }
// }
class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  File? _image;

  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kindacode.com'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(children: [
              Center(
                child: ElevatedButton(
                  child: const Text('Select An Image'),
                  onPressed: _openImagePicker,
                ),
              ),
              const SizedBox(height: 35),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 300,
                color: Colors.grey[300],
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : const Text('Please select an image'),
              )
            ]),
          ),
        ));
  }
}