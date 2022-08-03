import 'package:cloud_firestore/cloud_firestore.dart';


import '../page/chat_page.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class ChatHeaderWidget extends StatelessWidget {
  final List<User>  users;

  const ChatHeaderWidget({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: const Text(
                'ChatsApp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final user = users [index];
                  if (index == 0) {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: const CircleAvatar(
                        radius: 24,
                        child: Icon(Icons.search),
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(user: users[index]),
                          ));
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(user.urlAvatar),
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      );
}
