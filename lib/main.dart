import 'package:fireflowapp/firebase_options.dart';
import 'package:fireflowapp/screens/home/home.screen.dart';
import 'package:fireflowapp/screens/messages/messages.screen.dart';
import 'package:fireflowapp/screens/user/login/login.screen.dart';
import 'package:fireflowapp/screens/user/profile/profile.screen.dart';
import 'package:fireflowapp/screens/user/settings.screen.dart';
import 'package:fireflowapp/screens/user/edit_account.dart';
import 'package:fireflowapp/screens/user/time.screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/time',
      builder: (context, state) => const TimeScreen(),
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) => const EditAccountScreen(),
    ),
    GoRoute(
      path: '/messages',
      builder: (context, state) => const MessagesScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.purple,
      ),
      routerConfig: _router,
    );
  }
}
