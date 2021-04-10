import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditNote extends StatefulWidget {
  final DocumentSnapshot noteEdit;
  EditNote({this.noteEdit});

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
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
                widget.noteEdit.reference.update({
                  'Title': title.text,
                  'Type': type.text,
                  'Description': body.text
                }).whenComplete(() => Navigator.pop(context));
              },
              child: Text('Save')),
          FlatButton(
              onPressed: () {
                widget.noteEdit.reference
                    .delete()
                    .whenComplete(() => Navigator.pop(context));
              },
              child: Text('Delete')),
          FlatButton(
              onPressed: () {
                if (isFavorite) {
                  widget.noteEdit.reference
                      .delete()
                      .whenComplete(() => Navigator.pop(context));
                } else {
                  isFavorite = true;
                  favoriteData.collection('favourites').add({
                    'Title': title.text,
                    'Type': type.text,
                    'Description': body.text
                  });
                }
              },
              child: Text('Fav it'))
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
