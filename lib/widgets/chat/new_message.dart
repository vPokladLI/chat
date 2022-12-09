import 'package:flutter/material.dart';
import '../../services/firebase_service.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final db = DataBase();
  final messageController = TextEditingController();
  var _enteredMessage = '';
  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();
    await db.addMessage(_enteredMessage);
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: messageController,
            onChanged: ((value) {
              setState(() {
                _enteredMessage = value;
              });
            }),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  messageController.clear();
                  setState(() {
                    _enteredMessage = '';
                  });
                },
              ),
              label: Text('Send a message'),
            ),
          )),
          IconButton(
            onPressed: _enteredMessage.isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
    );
  }
}
