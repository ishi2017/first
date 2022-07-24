import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (cntx, snap) => Scaffold(
        appBar: AppBar(
          title: const Text('Chitchat'),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.all(8),
            child: const Text('This works'),
          ),
        ),
        floatingActionButton: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('chats/kumPdJau69q1WorEv56y/message')
                .snapshots()
                .listen((data) {
              data.docs.forEach((msg) {
                print(msg['text']);
              });
            });
          },
        ),
      ),
    );
  }
}
