import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflowapp/widgets/user.doc.dart';
import 'package:flutter/material.dart';

/// Builder widget that returns a [User] object when the user is ready.
class UserLogin extends StatelessWidget {
  const UserLogin({super.key, required this.builder});

  final Widget Function(Map<String, dynamic>?) builder;

  @override
  Widget build(BuildContext context) => UserDoc(builder: builder);
}
