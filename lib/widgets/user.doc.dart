import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:fireflowapp/widgets/user.ready.dart';
import 'package:flutter/material.dart';

/// Builder widget that returns a `/users/<uid>` document data object when the user is logged in to Firebase.
class UserDoc extends StatelessWidget {
  const UserDoc({super.key, required this.builder});
  final Widget Function(Map<String, dynamic>?) builder;

  @override
  Widget build(BuildContext context) {
    return UserReady(builder: (user) {
      if (user == null) {
        return const SizedBox.shrink();
      }

      return StreamBuilder(
        stream: FirebaseDatabase.instance.ref('users/${user.uid}').onValue,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }

          final docSnapshot = snapshot.data?.snapshot;
          if (docSnapshot == null ||
              !docSnapshot.exists ||
              docSnapshot.value == null) {
            log('Oops! user document not found.');
            return builder(null);
          }

          final value = Map<String, dynamic>.from(
              docSnapshot.value as Map<dynamic, dynamic>);

          value['email'] = user.email;
          value['uid'] = user.uid;

          return builder(value);
        },
      );
    });
  }
}
