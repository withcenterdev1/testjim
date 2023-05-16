import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Builder widget that returns a [User] object when the user is ready.
class UserReady extends StatelessWidget {
  const UserReady({super.key, required this.builder});

  final Widget Function(User?) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }

        return builder(snapshot.data);
      },
    );
  }
}
