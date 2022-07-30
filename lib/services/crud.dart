import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference  = FirebaseFirestore.instance;

class CrudMethods{
  Future<void> addData(postData) async{

    FirebaseFirestore.instance.collection("posts").add(postData).catchError((e){
      print(e);
    });
  }
}