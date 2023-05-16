import 'dart:developer';
import 'package:fireflowapp/widgets/main.bottom.navigation.bar.dart';
import 'package:fireflowapp/widgets/user.ready.dart';
// import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final displayName = TextEditingController();
  final school = TextEditingController();
  FirebaseDatabase database = FirebaseDatabase.instance;

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text('Profile', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),
              Text('email: ${FirebaseAuth.instance.currentUser?.email}'),
              const SizedBox(height: 24),
              FutureBuilder(
                  future: FirebaseDatabase.instance.ref('users/$uid').once(),
                  builder: (BuildContext context, snapshot) {
                    final value = snapshot.data?.snapshot.value as Map?;
                    if (value == null) return const SizedBox.shrink();
                    displayName.text = value['displayName'];
                    school.text = value['school'];
                    return Column(
                      children: [
                        TextField(
                          controller: displayName,
                          decoration:
                              const InputDecoration(labelText: 'Display Name'),
                        ),
                        TextField(
                          controller: school,
                          decoration:
                              const InputDecoration(labelText: 'Scchool Name'),
                        ),
                      ],
                    );
                  }),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await database.ref('users/$uid').set({
                      "displayName": displayName.text,
                      'school': school.text,
                    });
                    log('re----- await done...');
                  } catch (e) {
                    log('---> error');
                    log(e.toString());
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: UserReady(
        builder: (user) => MainBottomNavigationBar(user: user),
      ),
    );
  }
}
