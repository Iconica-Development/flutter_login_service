// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class BasicLoginModel {
  const BasicLoginModel({
    required this.id,
    required this.username,
    required this.hashedPassword,
  });

  factory BasicLoginModel.fromJson(Map<String, dynamic> json) =>
      BasicLoginModel(
        id: json['id'],
        username: json['username'],
        hashedPassword: json['password'],
      );
  final String id;
  final String username;
  final String hashedPassword;

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': hashedPassword,
        'id': id,
      };

  bool passwordMatches(String password) =>
      _unsafeHash(password) == hashedPassword;

  String _unsafeHash(String password) {
    var bytes = base64Encode(password.codeUnits);
    return bytes;
  }
}
