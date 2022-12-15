import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import '../services/auth_service.dart';
import '../services/firestore_service.dart';

import '../widgets/avatar_input.dart';

class ProfileScreen extends StatefulWidget {
  static const routName = '/profile';
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String userName;
  late String userAvatar;
  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final auth = Auth();
  var _isReadOnly = true;
  @override
  void initState() {
    // TODO: implement initState
    userName = auth.user!.displayName == ''
        ? 'User'
        : auth.user!.displayName as String;
    userAvatar = auth.user?.photoURL ??
        'https://firebasestorage.googleapis.com/v0/b/chat-715d6.appspot.com/o/user_img%2Favatar_placeholder.jpg?alt=media&token=824e372b-b52e-4522-9fdb-5e3127141fba';
    _nameController.text = userName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final ButtonStyle style =
        ElevatedButton.styleFrom(minimumSize: Size(200, 40));
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Profile'),
          actions: [
            TextButton.icon(
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onTertiary),
                onPressed: () {
                  auth.signOut();
                  Navigator.of(context).pushReplacementNamed('/');
                },
                label: Text('Logout'),
                icon: Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome back, $userName !',
                    style: TextStyle(color: color.onBackground),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ImageInput(() {}, userAvatar),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IntrinsicWidth(
                        child: TextField(
                          focusNode: _nameFocusNode,
                          controller: _nameController,
                          readOnly: _isReadOnly,
                          style: TextStyle(
                              color: color.onBackground, fontSize: 24),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 48),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (value) async {
                            await auth.updateName(value);
                            setState(() {
                              userName = value;
                            });
                          },
                        ),
                      ),
                      if (_isReadOnly)
                        IconButton(
                            color: color.inversePrimary,
                            onPressed: () {
                              setState(() {
                                _isReadOnly = false;
                                _nameFocusNode.requestFocus();
                              });
                            },
                            icon: Icon(Icons.edit)),
                      if (!_isReadOnly)
                        IconButton(
                            color: color.inversePrimary,
                            onPressed: () async {
                              await auth.updateName(_nameController.text);
                              setState(() {
                                userName = _nameController.text;
                                _isReadOnly = true;
                              });
                            },
                            icon: Icon(Icons.done))
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text('Save changes'),
                      style: style),
                  SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                    style: style,
                  ),
                ]),
          ),
        ));
  }
}
