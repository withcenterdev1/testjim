import 'package:firebase_database/firebase_database.dart';

class Database {
  FirebaseDatabase db = FirebaseDatabase.instance;

  getDB() {
    return db;
  }
}
