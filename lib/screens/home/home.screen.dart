import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflowapp/widgets/main.bottom.navigation.bar.dart';
import 'package:fireflowapp/widgets/user.ready.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        title: const Text('Home'),
      ),
      bottomNavigationBar: UserReady(
        builder: (user) => MainBottomNavigationBar(user: user),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (user != null) ...[
                Text('User: ${user!.email}'),
                StreamBuilder(
                    stream: FirebaseDatabase.instance
                        .ref('users/${user!.uid}')
                        .onValue,
                    builder: (_, snapshot) {
                      final value = snapshot.data?.snapshot.value as Map?;
                      if (value == null) return const SizedBox.shrink();

                      log('value; $value');
                      return Column(
                        children: [
                          Text('Display name: ${value['displayName']}'),
                          Text('School name: ${value['school']}'),
                        ],
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.push('/profile'),
                      child: const Text('Profile'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
