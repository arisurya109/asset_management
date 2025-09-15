import 'package:asset_management/core/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppSegmentedButton<T> extends StatelessWidget {
  List<T>? options;
  T selected;
  void Function(Set<T>)? onSelectionChanged;

  AppSegmentedButton({
    super.key,
    required this.options,
    required this.selected,
    this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SegmentedButton(
        segments: options!.map((e) {
          return ButtonSegment(
            value: e,
            label: Text(
              e.toString(),
              style: TextStyle(
                color: selected == e ? Colors.white : Colors.grey,
                fontWeight: selected == e ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          );
        }).toList(),
        showSelectedIcon: false,
        selected: {selected},
        onSelectionChanged: onSelectionChanged,
        style: SegmentedButton.styleFrom(
          backgroundColor: Colors.white,
          selectedBackgroundColor: AppColors.kBase,
          side: BorderSide(color: AppColors.kBase, width: 1.5),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.kBase, width: 1.5),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
