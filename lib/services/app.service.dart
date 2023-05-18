import 'package:flutter/material.dart';

class AppService {
  static BuildContext? _context;
  static BuildContext get context => _context!;
  static set context(_) => _context = _;
}
