import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/create_event.dart';
import 'package:flutter_application_1/services/crud.dart';
import 'package:path/path.dart';
import 'package:hexcolor/hexcolor.dart';

class KampyEvent extends StatefulWidget {
  const KampyEvent({Key? key}) : super(key: key);

  @override
  State<KampyEvent> createState() => _KampyEventState();
}

class _KampyEventState extends State<KampyEvent> {
  CrudMethods crudMethods = CrudMethods();

// get the data event from cloud firestore
  QuerySnapshot? eventsSnapshot;

  Widget eventsList() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            offset: Offset(1, 1),
            color: Color.fromARGB(75, 198, 202, 218),
          )
        ],
      ),
      child: SingleChildScrollView(
        child: eventsSnapshot != null
            ? Column(
                children: <Widget>[
                  ListView.builder(
                      padding:
                          const EdgeInsets.only(top: 70, left: 20, right: 20),
                      itemCount: eventsSnapshot?.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return EventsTile(
                          //  info: eventsSnapshot?.docs[index]['info'],
                          eventName: eventsSnapshot?.docs[index]['eventName'],
                          place: eventsSnapshot?.docs[index]['place'],
                          time: eventsSnapshot?.docs[index]['time'],
                         
                          imgUrl: eventsSnapshot?.docs[index]['imgUrl'],
                        );
                      })
                ],
              )
            : Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    crudMethods.getData().then((result) => {eventsSnapshot = result});
  }
//create appBar and button to redirect from kampy event widget to create event widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: ClipRRect(
            // borderRadius: const BorderRadius.only(
            //     bottomRight: Radius.circular(60),
            //     bottomLeft: Radius.circular(0)),
            child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "images/88257fc06f6e674a8ffc2a39bd3de33a.gif"),
                        fit: BoxFit.fill))),
          ),
          // title: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: const [
          //     Text("Kampy", style: TextStyle(fontSize: 22)),
          //     Text("Events", style: TextStyle(fontSize: 22, color: Colors.orange))
          //   ],
          // ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
      body: eventsList(),
      backgroundColor: HexColor("#332052"),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateEvent()));
              },
              backgroundColor: const Color.fromARGB(255, 34, 3, 39),
              child: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

class EventsTile extends StatelessWidget {
// const   EventsTile({Key? key}) : super(key: key);
  String id;
  final dynamic imgUrl;
  final dynamic eventName;
  final dynamic place;
  final dynamic time;
  // final dynamic info;

  EventsTile({
    Key? key,
    this.id = '',
    required this.imgUrl,
    required this.eventName,
    required this.place,
    required this.time,
    // required this.info,
  }) : super(key: key);
//show the data event
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              )),
          Container(
            height: 150,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  eventName,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  place,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                // const SizedBox(
                //   height: 4,
                // ),
                // Text(
                //   time,
                //   style: const TextStyle(
                //       fontSize: 17,
                //       fontWeight: FontWeight.w400,
                //       color: Colors.white),
                // ),
                // const SizedBox(
                //   height: 4,
                // ),
                // Text(
                //   info,
                //   style: const TextStyle(
                //       fontSize: 17,
                //       fontWeight: FontWeight.w400,
                //       color: Colors.white),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
