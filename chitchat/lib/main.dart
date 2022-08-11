import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../screen/chat.dart';
import '../screen/auth.dart';

Future<void> _onBackgroundMessage(RemoteMessage msg) async {
  await Firebase.initializeApp();

  print("onBackgroundMessage: ${msg}");
  print("onBackgroundMessage.data: ${msg.data}");
  print("onBackgroundMessage.notification.title: ${msg.notification?.title}");
  print("onBackgroundMessage.notification.body: ${msg.notification?.body}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.

  void _userInfo(final snapshot) async {
    final username = await FirebaseFirestore.instance
        .collection('user')
        .doc(snapshot.data.uid)
        .get();
    print(username['username']);

    //return username['username'];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChitChat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            )),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            //_userInfo(snapshot);
            return const ChatScreen();
          } else {
            return const AuthScreen();
          }
        }),
      ),
    );
  }
}
