import 'package:asset_management/core/utils/colors.dart';
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  void showSnackbar(String message, {Color backgroundColor = AppColors.kBase}) {
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

  pushReplacment(Widget params) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => params),
    );
  }

  push(Widget params) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => params));
  }

  pop() {
    Navigator.pop(this);
  }

  void showDialogOption({
    String title = 'Title',
    required List<Widget> children,
  }) async {
    await showDialog(
      context: this,
      builder: (context) {
        return SimpleDialog(
          alignment: Alignment.center,
          title: Center(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 24),
          // insetPadding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
          children: children,
        );
      },
    );
  }
}
