import 'package:flutter/material.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    final fbm = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((event) {
      print('onMessage : $event');
    });
    FirebaseMessaging.onBackgroundMessage((message) {
      print('message from BG : $message');
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('onResume : $event');
    });
    // print('onResume : $onResume');
    fbm.requestPermission(); // this thing doesn't do anything for android, because it is only for IOS, helps in get permissions for receiving notif. on IOS!
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: <Widget>[
          DropdownButton(
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout')
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            // Expanded(
            //   child: NewMessage(),
            // ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
