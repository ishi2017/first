import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../messages/msg_bubble.dart';

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
                    child: MessageBubble(
                      username: document[index]['userName'],
                      msg: document[index]['text'],
                      isMe: document[index]['userID'] ==
                          FirebaseAuth.instance.currentUser.uid,
                      key: ValueKey(
                        document[index].id,
                      ),
                      img: document[index]['user_img'],
                    ),
                  );
                }),
          );
        });
  }
}
