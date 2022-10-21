import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class BasicLoginModel {
  final String id;
  final String username;
  final String hashedPassword;

  const BasicLoginModel({
    required this.id,
    required this.username,
    required this.hashedPassword,
  });

  factory BasicLoginModel.fromJson(Map<String, dynamic> json) {
    return BasicLoginModel(
      id: json['id'],
      username: json['username'],
      hashedPassword: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': hashedPassword,
        'id': id,
      };

  bool passwordMatches(String password) {
    return _unsafeHash(password) == hashedPassword;
  }

  String _unsafeHash(String password) {
    var bytes = base64Encode(password.codeUnits);
    return bytes.toString();
  }
}
