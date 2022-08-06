// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:io';
class ActiveChats extends StatelessWidget {
  final  photoUrl;

  const ActiveChats({key, required, required this.photoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25, left: 5),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: CircleAvatar(
                      radius: 50,
                      child: Image.network(photoUrl),
                    ),
                  ),
                )
            ],
          )),
    );
  }
}
