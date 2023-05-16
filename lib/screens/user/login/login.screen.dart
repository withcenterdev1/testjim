import 'package:flutter/material.dart';

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: email,
            decoration: const InputDecoration(hintText: 'Input Email'),
          ),
          TextField(
            controller: password,
            decoration: const InputDecoration(hintText: 'Input Password'),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    final credential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    log(credential.user.toString());
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      log('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      log('Wrong password provided for that user.');
                    } else {
                      log(e.code);
                      log(e.message.toString());
                    }
                  } catch (e) {
                    log(e.toString());
                  }
                  context.push('/profile');
                },
                child: const Text('Login'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    log(credential.user.toString());

                    context.push('/profile');
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      log('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      log('The account already exists for that email.');
                    }
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
