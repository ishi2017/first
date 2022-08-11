import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../messages/message.dart';
import '../messages/send_msg.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void _initNotifications() async {
    final notifications = FirebaseMessaging.instance;
    final settings = await notifications.requestPermission();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      return;
    }

    FirebaseMessaging.onMessage.listen((msg) {
      print("onMessage: $msg");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      print("onMessageOpenedApp: $msg");
    });
  }

  @override
  void initState() {
    super.initState();

    _initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chitchat'),
        actions: [
          DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'logout',
                  child: Text('logout'),
                )
              ],
              onChanged: (selectedItem) {
                if (selectedItem == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.min,
        children: [Message(), NewMessage()],
      ),
    );
  }
}
