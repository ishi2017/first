import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String msg;
  final bool isMe;
  final String username;
  const MessageBubble({
    Key key,
    this.msg,
    this.isMe,
    this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 200,
          decoration: BoxDecoration(
            color: isMe ? Colors.grey : Colors.lightBlue,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12.0),
              topRight: const Radius.circular(12.0),
              bottomLeft: isMe
                  ? const Radius.circular(12.0)
                  : const Radius.circular(0.0),
              bottomRight: !isMe
                  ? const Radius.circular(12.0)
                  : const Radius.circular(0.0),
            ),
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          margin: const EdgeInsets.all(1.0),
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  username,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      color: Colors.yellow, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(color: Colors.black),
              Text(
                msg,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
