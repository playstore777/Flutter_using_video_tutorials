import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart'; // for FutureBuilder(commented below!)

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String username;
  final String userImage;
  final Key key;
  MessageBubble(
    this.message,
    this.username,
    this.userImage,
    this.isMe, {
    this.key,
  });
  @override
  Widget build(BuildContext context) {
    print('key: $key');
    return Stack(
      children: [
        Row(
          // is also used here for flutter to use given width, which was ignored without row in a listview!
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width:
                  140, // this will be ignored as it is in the ListView. So, we use Row Widget!
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // FutureBuilder(
                  //     // this is one way of fetching userName!(but this has a big flaw)
                  //     future: FirebaseFirestore
                  //         .instance // that is, it will request for username, everytime,
                  //         .collection(
                  //             'users') // it gets a new message, like requesting this will reduce performance!
                  //         .doc(userId)
                  //         .get(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.waiting) {
                  //         return Text('Loading...');
                  //       }
                  //       return Text(
                  //         snapshot.data['username'].toString(),
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       );
                  //     }),

                  Text(
                    username,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Divider(
                  //   thickness: 1,
                  //   color: isMe ? Colors.black : Colors.white,
                  // ),
                  Text(
                    message,
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                  // Divider(
                  //   thickness: 1,
                  //   color: isMe ? Colors.black : Colors.white,
                  // ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: !isMe ? null : 120,
          left: isMe ? null : 120,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              userImage,
            ),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
