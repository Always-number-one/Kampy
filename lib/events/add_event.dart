

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EventService{
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  createEvent(title,url) async {
    var name  =  _auth.currentUser!.displayName;
    var image  = _auth.currentUser!.photoURL;
    var id = DateTime.now();
   Event event = Event(_auth.currentUser!.displayName, _auth.currentUser!..photoURL, title, url);
    try{
      await _firestore.collection('Events').doc(id.toString()).set({
        'uploader' : name,
        'uploaderImage' : image,
        'title' : title,
        'photo' : url,
      });

    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }
}

class Event {
  final uploader;
  final uploaderImage;
  final title;
  final photo;
  Event(this.uploader, this.uploaderImage, this.title, this.photo);
}