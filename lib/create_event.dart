import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late String eventName, meetingAt, place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: ClipRRect(
            // borderRadius: const BorderRadius.only(
            //     bottomRight: Radius.circular(60),
            //     bottomLeft: Radius.circular(60)),
            child: Container(
                decoration: const BoxDecoration(
              color: Color.fromARGB(255, 42, 8, 48),
            )),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Add", style: TextStyle(fontSize: 22)),
              Text(" Event",
                  style: TextStyle(
                      fontSize: 22, color: Color.fromARGB(255, 0, 255, 0)))
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.file_upload))
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              width: MediaQuery.of(context).size.width,
              child: const Icon(Icons.add_a_photo),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children:  <Widget>[
                  TextField(
                    decoration: const InputDecoration(hintText: "Event Name"),
                    onChanged: (val) {
                      eventName = val;
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Meeting At"),
                    onChanged: (val) {
                      eventName = val;
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Place"),
                    onChanged: (val) {
                      eventName = val;
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 42, 8, 48),
    );
  }
}
