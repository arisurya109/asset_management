import 'package:flutter/material.dart';

import 'app_radio_list_item.dart';

// ignore: must_be_immutable
class AppRadioListOption<T> extends StatelessWidget {
  String? title;
  List<Map<String, dynamic>> options;
  T? groupValue;
  void Function(T?)? onChanged;

  AppRadioListOption({
    super.key,
    this.title,
    required this.options,
    this.groupValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? 'Title',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Row(
          children: options.map((e) {
            return Expanded(
              child: AppRadioListItem<T>(
                groupValue: groupValue,
                onChanged: onChanged,
                title: e['label'],
                value: e['value'],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
