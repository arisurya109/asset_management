import 'package:flutter/material.dart';

Color defaultBorder = Color(0xFFE2E8F0);

class AppButtonHeaderTable extends StatelessWidget {
  final IconData? icons;
  final Color? iconColors;
  final String? title;
  final Color? titleColor;
  final Color? borderColor;
  final void Function()? onPressed;

  const AppButtonHeaderTable({
    super.key,
    this.icons = Icons.download_rounded,
    this.iconColors,
    this.title = 'Title',
    this.titleColor,
    this.onPressed,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor ?? Color(0xFFE2E8F0)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        icon: Icon(icons, size: 16, color: iconColors ?? Color(0xFF64748B)),
        label: Text(
          title!,
          style: TextStyle(
            fontSize: 12,
            color: titleColor ?? Color(0xFF475569),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
