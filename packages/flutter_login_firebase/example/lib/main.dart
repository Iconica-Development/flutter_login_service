// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_example/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_firebase/flutter_login_firebase.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter login Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _service = FirebaseLoginService(
    auth: FirebaseAuth.instance,
  );
  final _formKey = GlobalKey<FormState>();
  var email = '';
  var password = '';

  Future<void> _login() async {
    var form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      await _service.loginWithEmailAndPassword(
        email,
        password,
        context,
        onMFA: (e) {},
      );
    }
  }

  Future<void> _forgotPassword() async {
    var form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      await _service.loginWithEmailAndPassword(email, password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextFormField(
                onSaved: (val) {
                  email = val ?? '';
                },
              ),
              TextFormField(
                onSaved: (val) {
                  password = val ?? '';
                },
              ),
              TextButton(
                onPressed: _forgotPassword,
                child: const Text(
                  'request forgot password!',
                ),
              ),
              ElevatedButton(
                onPressed: _login,
                child: const Text('login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
