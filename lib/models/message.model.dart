import 'package:fireflowapp/models/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class MessageModel extends Database {
  getAll() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        // final ref = getDB().ref();

        // final snapshot = await ref.child('users/${user.uid}/messages').get();

        // if (snapshot.exists) {
        //   print(snapshot.value);
        // } else {
        //   print('No data available.');
        // }
      }
    });
  }

  add(String contactID, String message) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        try {
          getDB().ref("users/${user.uid}/messages").push().set({
            "contactID": contactID,
            "messageFrom": user.uid,
            "message": message,
            "datetime": DateTime.now().toString()
          });
        } catch (e) {
          log(e.toString());
        }
      }
    });
  }

  remove(messageKey) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        try {
          getDB().ref("users/${user.uid}/messages/$messageKey").remove();
        } catch (e) {
          log(e.toString());
        }
      }
    });
  }
}
