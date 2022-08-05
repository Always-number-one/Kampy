import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethodsP{
  Future<void> addData(postData)async{
    FirebaseFirestore.instance
    .collection("posts")
    .add(postData)
    .catchError((e){
      print(e);
    });
  }
getData()async{
  return await FirebaseFirestore.instance.collection("posts").get();
}
}
