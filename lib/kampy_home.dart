import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Home extends StatefulWidget {


  const Home({Key? key}) : super(key: key);

 



  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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