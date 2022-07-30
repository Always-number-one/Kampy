import 'package:flutter/material.dart';

class KampyEvent extends StatefulWidget {
  const KampyEvent({Key? key}) : super(key: key);

  @override
  State<KampyEvent> createState() => _KampyEventState();
}

class _KampyEventState extends State<KampyEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Kampy", style: TextStyle(fontSize: 22)),
            Text("Events", style: TextStyle(fontSize: 22, color: Colors.orange))
          ],
        ),
         backgroundColor:const Color.fromARGB(255, 77, 95, 255),
      ),
    );
  }
}
