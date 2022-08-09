import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message extends StatelessWidget {
  const Message({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final document = snapShot.data.docs;

          return Expanded(
            child: ListView.builder(
                reverse: true,
                itemCount: document.length,
                itemBuilder: (cntx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      document[index]['text'],
                      style: const TextStyle(
                          fontFamily: 'MonoSpace',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }),
          );
        });
  }
}
