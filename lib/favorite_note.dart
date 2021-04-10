import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteEditNote extends StatefulWidget {
  final DocumentSnapshot noteEdit;
  FavoriteEditNote({this.noteEdit});

  @override
  _FavoriteEditNoteState createState() => _FavoriteEditNoteState();
}

class _FavoriteEditNoteState extends State<FavoriteEditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController body = TextEditingController();

  final favoriteData = FirebaseFirestore.instance;
  bool isFavorite = false;

  @override
  void initState() {
    title = TextEditingController(text: widget.noteEdit['Title']);
    type = TextEditingController(text: widget.noteEdit['Type']);
    body = TextEditingController(text: widget.noteEdit['Description']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {
                widget.noteEdit.reference
                    .delete()
                    .whenComplete(() => Navigator.pop(context));
              },
              child: Text('Remove')),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: title,
                decoration: InputDecoration(hintText: 'Title'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: type,
                decoration: InputDecoration(hintText: 'Type'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: body,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(hintText: 'Body'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
