import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(eventData) async {
    FirebaseFirestore.instance
        .collection("events")
        .add(eventData)
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance.collection("events").get();
  }

  Future<void> editEvent(data , String? id) async {
    await FirebaseFirestore.instance
        .collection("events")
        .doc(id)
        .update(data)
        .catchError((e)=>{
          print(e)
        });
  }
}
