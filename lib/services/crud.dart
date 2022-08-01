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
}