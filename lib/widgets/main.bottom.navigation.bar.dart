import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({super.key, this.currentIndex = 0, this.user});
  final int currentIndex;
  final User? user;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        if (user == null) ...const [
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Login'),
        ],
        if (user != null) ...const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ],
      onTap: (n) {
        if (n == 0) context.go('/');
        if (user == null) {
          if (n == 1) {
            context.go('/login');
          }
        } else {
          if (n == 1) {
            context.go('/profile');
          }
          if (n == 2) {
            context.go('/messages');
          }
          if (n == 3) {
            context.go('/settings');
          }
        }
      },
    );
  }
}
