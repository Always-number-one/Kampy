import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethodS{
  Future<void> addData(shopData)async{
    FirebaseFirestore.instance
    .collection("shops")
    .add(shopData)
    .catchError((e){
      print(e);
    });
  }
getData()async{
  return await FirebaseFirestore.instance.collection("shops").get();
}
}
