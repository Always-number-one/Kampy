import 'package:flutter/material.dart';
import 'package:flutter_application_1/kampy_event.dart';

class Kampy extends StatefulWidget {
  const Kampy({Key? key}) : super(key: key);

  @override
  State<Kampy> createState() => _KampyState();
}

class _KampyState extends State<Kampy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const KampyEvent()));
        },
        backgroundColor: Colors.purple,
        shape:const BeveledRectangleBorder(
            
        ),
        child: Column(
                   children: const <Widget>[
                    Icon(Icons.event),
                    Text("Events"),
                    
                  ],
               ),
      ),
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(250.0),
      //   child: AppBar(
      //     centerTitle: true,
      //     flexibleSpace: ClipRRect(
      //       borderRadius: const BorderRadius.only(
      //           bottomRight: Radius.circular(60),
      //           bottomLeft: Radius.circular(60)),
      //       child: Container(
      //           decoration: const BoxDecoration(
      //               image: DecorationImage(
      //                   image: AssetImage("images/c.jpg"), fit: BoxFit.fill))),
      //     ),
      //     title: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: const [
      //         Text("Kampy", style: TextStyle(fontSize: 22)),
      //         Text("Home", style: TextStyle(fontSize: 22, color: Colors.orange))
      //       ],
      //     ),
      //     backgroundColor: Colors.transparent,
      //     elevation: 0.0,
      //   ),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        // floatingActionButton: Container(
        //   margin: const EdgeInsets.fromLTRB(30, 70, 200, 200),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       FloatingActionButton(
        //         onPressed: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const KampyEvent()));
        //         },
        //         child: Column(
        //           children: const <Widget>[
        //             Icon(Icons.event),
        //             Text("Events"),
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
