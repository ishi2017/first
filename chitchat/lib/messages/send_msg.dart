import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredValue = '';
  var _controller = TextEditingController();
  void _sendMsg() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final username =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredValue,
      'createdAt': Timestamp.now(),
      'userID': user.uid,
      'userName': username['username']
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              style: const TextStyle(
                  fontFamily: 'MonoSpace',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Send messages...',
              ),
              onChanged: (value) {
                setState(() {
                  _enteredValue = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredValue.trim().isEmpty ? null : _sendMsg,
            icon: const Icon(
              Icons.send,
            ),
          )
        ],
      ),
    );
  }
}
