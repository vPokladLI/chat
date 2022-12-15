import 'dart:math';

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

enum AuthMode { signUp, login }

class AuthScreen extends StatelessWidget {
  static const routName = '/auth';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final deviceSize = media.size;
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 0.5),
                  Color.fromRGBO(255, 188, 117, 0.9)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1]),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: deviceSize.width,
              // height: deviceSize.height,
              child: const AuthCard(),
            ),
          ),
        )
      ]),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final Auth _auth = Auth();
  var _isLoading = false;
  var _passwordVisible = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  Map<String, String> _authData = {'email': '', 'password': '', 'name': ''};
  final _passwordController = TextEditingController();

  void _showDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Ok!'))
              ],
            ));
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    if (_authMode == AuthMode.login) {
      try {
        await _auth.loginWithEmailPassword(
            _authData['email']!, _authData['password']!);
      } catch (e) {
        _showDialog(e.toString());
      }

      setState(() {
        _isLoading = false;
      });
    }

// register
    else {
      try {
        await _auth.registerWithEmailPassword(
            _authData['email']!, _authData['password']!, _authData['name']!);
      } catch (e) {
        _showDialog(e.toString());
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
      child: Container(
        height: _authMode == AuthMode.login ? 300 : 480,
        // height: _heightAnimation.value.height,
        width: size.width * 0.75,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.login ? 300 : 480,
        ),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(label: Text('E-mail')),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'e-mail is not valid';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _authData['email'] = newValue!.trim();
                    },
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                      label: const Text('Password'),
                      suffixIcon: IconButton(
                        icon: Icon(_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Password length must be at least 6 characters';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _authData['password'] = newValue!.trim();
                    },
                  ),
                  Container(
                    constraints: BoxConstraints(
                        minHeight: _authMode == AuthMode.signUp ? 130 : 0,
                        maxHeight: _authMode == AuthMode.signUp ? 180 : 0),
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          obscureText: _passwordVisible,
                          enabled: _authMode == AuthMode.signUp,
                          decoration: InputDecoration(
                            label: const Text('Confirm password'),
                            suffixIcon: IconButton(
                              icon: Icon(_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: _authMode == AuthMode.signUp
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    return 'Passwords are not equal';
                                  }
                                  return null;
                                }
                              : null,
                          onEditingComplete: _submitForm,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          enabled: _authMode == AuthMode.signUp,
                          validator: _authMode == AuthMode.signUp
                              ? (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name!';
                                  }
                                  return null;
                                }
                              : null,
                          onSaved: (newValue) {
                            _authData['name'] = newValue!.trim();
                          },
                          decoration: InputDecoration(
                            label: const Text('Name'),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (_isLoading) const CircularProgressIndicator(),
                  if (!_isLoading)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15)),
                      onPressed: _submitForm,
                      child: Text(
                        _authMode == AuthMode.login ? 'Login' : 'Register',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  TextButton(
                      onPressed: _switchAuthMode,
                      child: Text(
                          _authMode == AuthMode.login
                              ? 'Don\'t have account? Register!'
                              : 'Already have account? Login!',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ))),
                ]),
          ),
        ),
      ),
    );
  }
}
