import 'package:flutter/material.dart';
import '../widgets/chat/message_bubble.dart';

import 'package:flutterfire_ui/firestore.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';

import '../screens/profile_screen.dart';

import '../widgets/chat/new_message.dart';
import '../widgets/app_drawer.dart';

class ChatScreen extends StatelessWidget {
  static const routName = '/chats';
  ChatScreen({super.key});

  final db = DataBase();
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat room'),
        actions: [
          DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(children: [
                      Text('Logout'),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.logout,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ]),
                  ),
                  value: 'logout',
                ),
                DropdownMenuItem(
                  child: Container(
                    child: Row(children: [
                      Text('Profile'),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.verified_user,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ]),
                  ),
                  value: 'profile',
                )
              ],
              onChanged: (itemValue) {
                switch (itemValue) {
                  case 'logout':
                    auth.signOut();

                    break;
                  case 'profile':
                    Navigator.of(context).pushNamed(ProfileScreen.routName);

                    break;
                  default:
                    null;
                }
              })
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: FirestoreListView(
                reverse: true,
                query: db.messages,
                itemBuilder: (context, doc) => messageBubble(
                    context: context,
                    message: doc['text'],
                    userId: doc['userId']),
              ),
            ),
          ),
          const NewMessage(),
        ],
      ),
    );
  }
}
