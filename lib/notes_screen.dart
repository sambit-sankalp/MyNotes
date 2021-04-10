import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_note/write_note.dart';
import 'edit_note.dart';
import 'favorite_notes.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final databaseData = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: databaseData.collection('mynotes').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditNote(
                                  noteEdit: snapshot.data.docs[index],
                                )),
                      );
                    },
                    child: Container(
                      child: Wrap(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  snapshot.data.docs[index]["Title"],
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  snapshot.data.docs[index]["Type"],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFF00),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WriteNote()),
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('My Notes'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Favourites'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavouriteNotes()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
