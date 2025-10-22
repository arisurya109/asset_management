import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../core.dart';

class AppDropDownSearch<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final String hintText;
  final T? selectedItem;
  final String Function(T)? itemAsString;
  final void Function(T?)? onChanged;
  final bool Function(T, T)? compareFn;
  final bool showSearchBox;
  final bool enabled;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;

  const AppDropDownSearch({
    super.key,
    required this.title,
    required this.items,
    required this.hintText,
    this.selectedItem,
    this.itemAsString,
    this.onChanged,
    this.compareFn,
    this.showSearchBox = true,
    this.enabled = true,
    this.margin,
    this.borderRadius = 8,
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
        DropdownSearch<T>(
          enabled: enabled,
          items: (filter, loadProps) => items,
          selectedItem: selectedItem,
          compareFn: compareFn,
          itemAsString: itemAsString,
          onChanged: onChanged,
          suffixProps: DropdownSuffixProps(
            clearButtonProps: ClearButtonProps(
              isVisible: true,
              color: AppColors.kBase,
            ),
          ),
          popupProps: PopupProps.menu(
            showSearchBox: showSearchBox,
            itemBuilder: (context, item, isDisabled, isSelected) {
              return ListTile(
                title: Text(
                  itemAsString != null ? itemAsString!(item) : item.toString(),
                ),
                selected: isSelected,
              );
            },
          ),
          dropdownBuilder: (context, selectedItem) {
            if (selectedItem == null) {
              return SizedBox();
            }
            return Text(
              itemAsString != null
                  ? itemAsString!(selectedItem)
                  : selectedItem.toString(),
            );
          },
          decoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(color: AppColors.kBlack),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
