import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chitchat'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/kumPdJau69q1WorEv56y/message')
            .snapshots(),
        builder: (cntx, AsyncSnapshot<QuerySnapshot> streamSnapShot) {
          final data = streamSnapShot.data?.docs;
          print(streamSnapShot.data);
          if (streamSnapShot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: data != null ? streamSnapShot.data?.docs.length : 0,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(8),
                child: Text(streamSnapShot.data?.docs[index]['text']),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/kumPdJau69q1WorEv56y/message')
              .add({
            'text': 'This is added dynamically',
          });
        },
      ),
    );
  }
}
