import 'dart:convert';

import 'package:fireflowapp/etc/defines.dart';
import 'package:fireflowapp/services/app.exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Api {
  static Future<Json> request(
    String method,
    Json data,
  ) async {
    debugPrint('--> backendLogin reqest data; $data');
    data['method'] = method;
    final res = await post(
      Uri.parse('https://sonub.com/api'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(data),
    );

    final json = jsonDecode(res.body);

    if (json['code'] != null || json['code'] != '' || json['code'] is String) {
      throw AppException(code: json['code'], message: json['message'] ?? '');
    }

    return json;
  }
}
