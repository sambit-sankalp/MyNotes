import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class WriteNote extends StatefulWidget {
  @override
  _WriteNoteState createState() => _WriteNoteState();
}

class _WriteNoteState extends State<WriteNote> {
  TextEditingController title = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController body = TextEditingController();

  final writtenData = FirebaseFirestore.instance;

  @override
  void deactivate() {
    if(title!=null && type!=null && body!=null)
      {
        writtenData.collection('mynotes').add({
          'Title': title.text,
          'Type': type.text,
          'Description': body.text
        });
      }
    super.deactivate();
  }

  @override
  void dispose() {
    if(title!=null && type!=null && body!=null)
    {
      writtenData.collection('mynotes').add({
        'Title': title.text,
        'Type': type.text,
        'Description': body.text
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {
                writtenData.collection('mynotes').add({
                  'Title': title.text,
                  'Type': type.text,
                  'Description': body.text
                }).whenComplete(() => Navigator.pop(context));
              },
              child: Text('Save'))
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
