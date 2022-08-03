import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/create_event.dart';
import 'package:flutter_application_1/services/crud.dart';
import 'package:path/path.dart';

class KampyEvent extends StatefulWidget {
  const KampyEvent({Key? key}) : super(key: key);

  @override
  State<KampyEvent> createState() => _KampyEventState();
}

class _KampyEventState extends State<KampyEvent> {
  CrudMethods crudMethods = CrudMethods();

  QuerySnapshot? eventsSnapshot;

  Widget eventsList() {
    return Container(
      child: eventsSnapshot != null
          ? Container(
              child: ListView.builder(
                  itemCount: eventsSnapshot?.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return EventsTile(
                        eventName: eventsSnapshot?.docs[index]['eventName'],
                        place: eventsSnapshot?.docs[index]['place'],
                        time: eventsSnapshot?.docs[index]['time'],
                        imgUrl: eventsSnapshot?.docs[index]['imgUrl']);
                  }))
          : Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    crudMethods.getData().then((result) => {eventsSnapshot = result});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: ClipRRect(
            // borderRadius: const BorderRadius.only(
            //     bottomRight: Radius.circular(60),
            //     bottomLeft: Radius.circular(60)),
            child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/fire.png"),
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

  final dynamic imgUrl;
  final dynamic eventName;
  final dynamic place;
  final dynamic time;

  const EventsTile(
      {Key? key,
      required this.imgUrl,
      required this.eventName,
      required this.time,
      required this.place})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      // height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imgUrl)),
          Container(
            height: 150,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8)),
          ),
          Container(
            child: Column(
              children: <Widget>[Text(eventName), Text(place), Text(time)],
            ),
          )
        ],
      ),
    );
  }
}
