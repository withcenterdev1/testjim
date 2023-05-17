import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Builder widget that calls a callback only if the user is logged out. (not logged in)
class UserLogout extends StatelessWidget {
  const UserLogout({super.key, required this.builder});

  final Widget Function() builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }

        User? user = snapshot.data;
        if (user == null) {
          return builder();
        }
        {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
