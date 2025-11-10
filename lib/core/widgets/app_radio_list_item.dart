import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppRadioListItem<T> extends StatelessWidget {
  String? title;
  T? value;
  T? groupValue;
  double? fontSize;
  void Function(T?)? onChanged;

  AppRadioListItem({
    super.key,
    this.title,
    this.value,
    this.groupValue,
    this.onChanged,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: RadioListTile<T>(
        title: Text(title ?? 'Title', style: TextStyle(fontSize: fontSize)),
        value: value as T,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
