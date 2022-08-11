import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String msg;
  final bool isMe;
  final String username;
  final String img;

  const MessageBubble({
    Key key,
    this.msg,
    this.isMe,
    this.username,
    this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 160,
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
              margin: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 5.0,
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
        ),
        Positioned(
          top: -20,
          left: isMe ? null : 140,
          right: isMe ? 140 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(img),
            radius: 30,
          ),
        )
      ],
      clipBehavior: Clip.none,
    );
  }
}
