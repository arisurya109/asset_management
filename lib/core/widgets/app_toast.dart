import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

enum ToastType { success, info, warning, error }

class AppToast {
  static void show({
    required BuildContext context,
    required ToastType type,
    required String message,
  }) {
    Color backgroundColor;
    Color borderColor;
    Color iconColor;
    IconData iconData;

    switch (type) {
      case ToastType.success:
        backgroundColor = const Color(0xFFEDF9F0);
        borderColor = const Color(0xFF5CB85C);
        iconColor = const Color(0xFF5CB85C);
        iconData = Icons.check_circle;
        break;
      case ToastType.info:
        backgroundColor = const Color(0xFFEBF5FF);
        borderColor = const Color(0xFF2196F3);
        iconColor = const Color(0xFF2196F3);
        iconData = Icons.info;
        break;
      case ToastType.warning:
        backgroundColor = const Color(0xFFFFF8E1);
        borderColor = const Color(0xFFFFC107);
        iconColor = const Color(0xFFFFC107);
        iconData = Icons.warning_amber_rounded;
        break;
      case ToastType.error:
        backgroundColor = const Color(0xFFFEEFEF);
        borderColor = const Color(0xFFF44336);
        iconColor = const Color(0xFFF44336);
        iconData = Icons.cancel;
        break;
    }

    toastification.showCustom(
      context: context,
      autoCloseDuration: const Duration(seconds: 4),
      // Alignment.topRight adalah kunci untuk menaruh di pojok kanan atas
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              // Mulai dari 1.0 (luar layar kanan) ke 0.0 (posisi asli)
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      builder: (BuildContext context, ToastificationItem holder) {
        return Material(
          color: Colors.transparent,
          child: Container(
            // Margin right: 0 agar menempel persis di pinggir layar
            margin: const EdgeInsets.only(top: 10, right: 0),
            width: 350, // Ukuran diperkecil lagi agar makin ringkas
            decoration: BoxDecoration(
              color: backgroundColor,
              // Memberikan lengkungan hanya di sisi kiri agar terlihat "keluar" dari dinding kanan layar
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: borderColor.withOpacity(0.4), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(-2, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(iconData, color: iconColor, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () => toastification.dismiss(holder),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.grey[500],
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
