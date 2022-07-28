import 'package:flutter/material.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
    
        primarySwatch: Colors.pink,
      ),
      
      home: const Kampy(),
    );
  }
}




// sameh part start here
// read data test 
class Kampy extends StatefulWidget {


  const Kampy({Key? key}) : super(key: key);

 



  @override
  State<Kampy> createState() => _KampyState();
}

class _KampyState extends State<Kampy> {
    // connect data base 'firebase'
  final CollectionReference _campers =
  FirebaseFirestore.instance.collection('campers');

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: StreamBuilder(
        stream: _campers.snapshots(),//build connection
        //streamsnaphot it contains all the data
        builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,//number of rows
              itemBuilder: (context,index){
                final DocumentSnapshot documentSnapshot=
                streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(documentSnapshot['price'].toString()),
                  ),
                );
              },
            ); //list view builder
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },

      ),
    );
  }
}


// read data test end
// sameh part end here







// bader part start here
class Events extends StatefulWidget {
  Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
// bader part end here






// moez part start here
class Chat extends StatefulWidget {
  Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
// moez part end here






// omar part start here
class Posts extends StatefulWidget {
  Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
// omar part end here