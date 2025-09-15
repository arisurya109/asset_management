import 'package:flutter/material.dart';

import 'app_space.dart';

// ignore: must_be_immutable
class AppDropDown<T> extends StatelessWidget {
  String title;
  List<T>? items;
  final ValueChanged<T?>? onSelected;
  String hintText;
  T? value;
  AppDropDown({
    super.key,
    this.title = 'Title',
    this.items,
    this.onSelected,
    this.hintText = 'Hint Text',
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        AppSpace.vertical(8),
        DropdownButtonFormField(
          dropdownColor: Colors.white,
          items: items
              ?.map(
                (e) => DropdownMenuItem<T>(value: e, child: Text(e.toString())),
              )
              .toList(),
          value: value,
          isExpanded: true,
          onChanged: onSelected,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          hint: Text(
            hintText,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
