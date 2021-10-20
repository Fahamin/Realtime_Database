import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/screen/showList.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'CustomListItem.dart';

class ListAlien extends StatefulWidget {
  const ListAlien({Key? key}) : super(key: key);

  @override
  _ListAlienState createState() => _ListAlienState();
}

class _ListAlienState extends State<ListAlien> {
  final databaseRef = FirebaseDatabase.instance.reference().child("angle");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "Firebase",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: FirebaseAnimatedList(
        scrollDirection: Axis.vertical,
        query: databaseRef,
        itemBuilder: (context, DataSnapshot spons, Animation<double> animation,
            int index) {
         /* return ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text(spons.value['l']),
            trailing: getNetworkImage(spons.value['l']),
          );*/

          return NewsTile(
            imgUrl:spons.value['l'],
            title: spons.value['l'],
            desc: "good boy",
            content: "here is content",
            posturl: "not all all",
          );
          //here is custom layout design
          /*return  CustomListItem(

            user: 'Flutter',
            viewCount: 999000,
            thumbnail: Container(
              child: getNetworkImage(spons.value['l']),
            ),
            title: spons.value['l'],
          );*/
        },
      ),
    );
  }




}
