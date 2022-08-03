import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatter Box'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('floating action button');
        },
        child: const Icon(Icons.chat_bubble),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          NavigationDestination(icon: Icon(Icons.shop), label: 'Shop'),
          NavigationDestination(icon: Icon(Icons.event), label: 'Events'),
          NavigationDestination(icon: Icon(Icons.chat_bubble), label: 'Chat')
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
      body: Column(children: [
        Image.asset(
          'images/background3.png',
          scale: 2,
        ),
        Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(10.0),
            color: Colors.pink,
            width: double.infinity,
            child: const Center(
              child: Text('this is a chat app',
                  style: TextStyle(color: Colors.white)),
            )),
        ElevatedButton(
          onPressed: () {
            debugPrint("Elevated Button");
          },
          child: const Text('Elevated Button'),
        ),
        OutlinedButton(
          onPressed: () {
            debugPrint('Outlined Button');
          },
          child: const Text('Outlined Button'),
        ),
        TextButton(
            onPressed: () {
              debugPrint('Text Button');
            },
            child: const Text('Text Button'))
      ]),
    );
  }
}

