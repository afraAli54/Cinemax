import 'package:flutter/material.dart';

extension Helper on BuildContext {
  void showSnackBar(_, String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
