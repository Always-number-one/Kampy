import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'events/add_event.dart';
import 'events/comment_event.dart';
// import 'package:untitled/pages/profile.dart';
import 'auth_controller.dart';

class KampyEvent extends StatefulWidget {
  const KampyEvent({Key? key}) : super(key: key);

  @override
  State<KampyEvent> createState() => _KampyEventState();
}

class _KampyEventState extends State<KampyEvent> {
  final controller = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var image =
      'https://i.ytimg.com/vi/KzUmQbgz7hs/maxresdefault.jpg';
  bool visibility = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 195, 58, 219),
          body: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'MyEvent',
                              style: GoogleFonts.ubuntu(
                                  color: const Color.fromARGB(255, 62, 10, 122),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            // IconButton(onPressed: (){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
                            // }, icon: const Icon(Icons.person,color: Colors.blueAccent,))
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 50,
                                child: TextField(
                                  onSubmitted: (s) {
                                    EventService().createEvent(s, image);
                                  },
                                  controller: controller,
                                  decoration: InputDecoration(
                                      prefix: CircleAvatar(
                                          backgroundImage: NetworkImage(image)),
                                      hintText: 'Whats In Your Mind...',
                                      suffix: IconButton(
                                        icon: const Icon(Icons.attachment),
                                        onPressed: () async {
                                          setState(() {
                                            visibility = true;
                                          });
                                          var i = await uploadPick();
                                          setState(() {
                                            image = i;
                                            visibility = false;
                                          });
                                        },
                                      ),
                                      hintStyle:
                                          GoogleFonts.alice(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 175,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Card(
                                      child: Container(
                                        // decoration: BoxDecoration(
                                        //     color: Colors.black45,
                                        //     image: DecorationImage(
                                        //         image: NetworkImage(_auth
                                        //             .currentUser!.photoURL
                                        //             .toString()),
                                        //         fit: BoxFit.fill)),
                                        height: 175,
                                        width: 125,
                                        child: Center(
                                            child: InkWell(
                                          onTap: () {},
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.black45,
                                            child: Icon(Icons.add),
                                          ),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'New Event',
                                    style: GoogleFonts.alice(
                                        color: const Color.fromARGB(
                                            255, 62, 10, 122),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              StreamBuilder(
                                  stream: _firestore
                                      .collection('Events')
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    List<EventsCard> cards = [];
                                    int likes = 0;
                                    if (snapshot.hasData) {
                                      for (var element in snapshot.data!.docs) {
                                        var response = _firestore
                                            .collection('Events')
                                            .doc(element.id)
                                            .collection('Likes')
                                            .get()
                                            .then((value) {
                                          setState(() {
                                            likes++;
                                          });
                                        });
                                        cards.add(EventsCard(
                                          title: element['title'],
                                          uploader: element['uploader'],
                                          uploaderImage:
                                              element['uploaderImage'],
                                          photo: element['photo'],
                                          eventid: element.id,
                                          likes: likes.toString(),
                                        ));
                                      }
                                    }

                                    return snapshot.hasData != true
                                        ? Container()
                                        : Column(
                                            children: cards.reversed.toList(),
                                          );
                                  })
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Visibility(
                  visible: visibility,
                  child: const CircularProgressIndicator(
                    color: Color.fromARGB(255, 62, 10, 122),
                  ),
                ),
              )
            ],
          )),
    );
  }

  uploadPick() async {
    await FirebaseAuth.instance.signInAnonymously();
    final _storage = FirebaseStorage.instance;
    var url;
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      await _storage.ref(image!.name).putFile(File(image.path)).then((p0) {
        url = p0.ref.getDownloadURL();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }

    return url;
  }
}

class StoryCard extends StatelessWidget {
  const StoryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 175,
        width: 125,
        color: Colors.grey,
      ),
    );
  }
}

class EventsCard extends StatefulWidget {
  final eventid;
  final title;
  final uploader;
  String uploaderImage;
  final photo;
  final likes;
  final comments;

  EventsCard({
    Key? key,
    required this.title,
    required this.uploader,
    required this.uploaderImage,
    required this.photo,
    this.eventid,
    this.likes,
    this.comments,
  }) : super(key: key);

  @override
  State<EventsCard> createState() => _EventsCardState();
}

class _EventsCardState extends State<EventsCard> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool like = false;

  @override
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(widget.uploaderImage),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text('Code Addict',
                    style: GoogleFonts.alice(color: const Color.fromARGB(255, 55, 16, 87)))
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 2,
            ),
            Text(
              widget.title,
              style: GoogleFonts.alice(),
              textAlign: TextAlign.left,
            ),
            Image.network(widget.photo),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StreamBuilder(
                    stream: _firestore
                        .collection('Events')
                        .doc(widget.eventid)
                        .collection('Likes')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return MaterialButton(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                            ),
                            snapshot.hasData
                                ? Text(snapshot.data!.docs.length.toString())
                                : Container(),
                          ],
                        ),
                        onPressed: () async {
                          var name = _auth.currentUser!.displayName;
                          if (like == false) {
                            setState(() {
                              like = true;
                            });
                            var response = await _firestore
                                .collection('Events')
                                .doc(widget.eventid)
                                .collection('Likes')
                                .doc(name)
                                .set({'name': name});
                          } else {
                            setState(() {
                              like = false;
                            });
                            var response = await _firestore
                                .collection('Events')
                                .doc(widget.eventid)
                                .collection('Likes')
                                .doc(name)
                                .delete();
                          }
                        },
                      );
                    }),
                StreamBuilder(
                    stream: _firestore
                        .collection('Events')
                        .doc(widget.eventid)
                        .collection('Comments')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return MaterialButton(
                        child: Column(
                          children: [
                            const Icon(Icons.comment),
                            snapshot.hasData
                                ? Text(snapshot.data!.docs.length.toString())
                                : Container()
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Comments(
                                        eventid: widget.eventid,
                                      )));
                        },
                      );
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
