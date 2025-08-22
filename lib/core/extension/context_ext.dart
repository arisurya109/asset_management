import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  void showSnackbar(String message, {Color backgroundColor = Colors.green}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          backgroundColor: backgroundColor,
        ),
      );
  }
}
