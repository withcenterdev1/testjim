import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflowapp/widgets/main.bottom.navigation.bar.dart';
import 'package:fireflowapp/widgets/user.ready.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:go_router/go_router.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({
    super.key,
  });

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  User? user;
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        log('User is signed in!');
      }
      setState(() {
        this.user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      bottomNavigationBar: UserReady(
        builder: (user) => MainBottomNavigationBar(user: user),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Message 1'),
              Text('Message 2'),
            ],
          ),
        ),
      ),
    );
  }
}
