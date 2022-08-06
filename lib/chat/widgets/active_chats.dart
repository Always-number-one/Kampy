// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:io';

class ActiveChats extends StatelessWidget {
  final photos;

  const ActiveChats({key, required, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25, left: 5),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < photos.length; i++)
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
                      backgroundImage: NetworkImage(photos[i]['photoUrl']),
                    ),
                  ),
                )
            ],
          )),
    );
  }
}
