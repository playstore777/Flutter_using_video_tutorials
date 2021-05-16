import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance
        .currentUser; // for Max(author) it is a future function, but now it no longer returns Future!
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get(); // we use this to store userName(a better Approach)
    print('userData[image] : ${userData["image_url"]}');
    await FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp // not flutter class, instead a Cloud_Firestore class
          .now(), // Since the data isn't sorted well, so I tried to google this, and found the only way to sort!
      'image': userData['image_url'],
      'userId': user.uid,
      'username': userData['username'],
    });
    _enteredMessage =
        ''; // Only because my mouse does a double click, even though I click it for once!
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Send a message...',
              ),
              onChanged: (value) {
                if (value.isEmpty) return;
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
