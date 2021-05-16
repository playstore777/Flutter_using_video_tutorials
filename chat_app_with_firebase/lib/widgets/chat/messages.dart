import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_bubble.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return (user ==
            null) // here Author(Max) Used a FutureBuilder, because it was a future back then, but now, it is no longer, so we directly write it as a normal function.
        ? Center(
            child: CircularProgressIndicator(),
          )
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .orderBy(
                  // because the data was not sorted, instead it was jumbled!
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data.docs;
              return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  chatDocs[index]['text'],
                  chatDocs[index]['username'],
                  chatDocs[index]['image'],
                  chatDocs[index]['userId'] == user.uid,
                  key: ValueKey(
                    FirebaseFirestore.instance.collection('chat').doc().id,
                  ),
                ),
              );
            },
          );
  }
}
