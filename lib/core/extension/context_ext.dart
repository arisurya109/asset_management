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

  void showDialogConfirm({
    String title = 'Title',
    String content = 'Content',
    String onConfirmText = 'Confirm',
    String onCancelText = 'Cancel',
    void Function()? onConfirm,
    void Function()? onCancel,
  }) async {
    await showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(title),
          actionsPadding: const EdgeInsets.only(bottom: 8, right: 12),
          content: Text(content, style: const TextStyle(height: 2)),
          actions: [
            TextButton(
              onPressed: onConfirm,
              child: Text(
                onConfirmText,
                style: const TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
              onPressed: onCancel,
              child: Text(
                onCancelText,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
