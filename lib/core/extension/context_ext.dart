import 'package:asset_management/core/utils/colors.dart';
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  void showSnackbar(
    String message, {
    Color backgroundColor = AppColors.kBase,
    double fontSize = 12,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize),
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
    double fontSize = 12,
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
          title: Text(
            title,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
          ),
          actionsPadding: const EdgeInsets.only(bottom: 8, right: 12),
          content: Text(
            content,
            style: TextStyle(height: 2, fontSize: fontSize),
          ),
          actions: [
            TextButton(
              onPressed: onConfirm,
              child: Text(
                onConfirmText,
                style: TextStyle(color: Colors.teal, fontSize: fontSize),
              ),
            ),
            TextButton(
              onPressed: onCancel,
              child: Text(
                onCancelText,
                style: TextStyle(color: Colors.red, fontSize: fontSize),
              ),
            ),
          ],
        );
      },
    );
  }

  double get deviceHeight {
    return MediaQuery.of(this).size.height;
  }

  double get deviceWidth {
    return MediaQuery.of(this).size.width;
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

  void dialogLoading() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.kWhite,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: CircularProgressIndicator(color: AppColors.kBase),
                ),
              ],
            ),
          ),
        );
      },
    );
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
          children: children,
        );
      },
    );
  }
}
