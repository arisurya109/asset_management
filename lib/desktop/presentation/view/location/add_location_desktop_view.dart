import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:flutter/material.dart';

class AddLocationDesktopView extends StatefulWidget {
  const AddLocationDesktopView({super.key});

  @override
  State<AddLocationDesktopView> createState() => _AddLocationDesktopViewState();
}

class _AddLocationDesktopViewState extends State<AddLocationDesktopView> {
  final categoryLocation = ['NON STORAGE', 'STORAGE'];
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppHeaderDesktop(title: 'Add Location', withBackButton: true),
        AppBodyDesktop(
          body: Container(
            width: 300,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                AppDropDownSearch<String>(
                  hintText: 'Category',
                  title: 'Category',
                  compareFn: (value, value1) => value == value1,
                  borderRadius: 4,
                  items: categoryLocation,
                  selectedItem: _selectedCategory,
                  onChanged: (value) => setState(() {
                    _selectedCategory = value!;
                  }),
                  fontSize: 12,
                ),
                AppSpace.vertical(12),
                AppTextField(title: 'Name', hintText: 'Example : Ruang Server'),
                AppSpace.vertical(12),
                AppTextField(title: 'Code', hintText: 'Example : 909'),
                AppSpace.vertical(12),
                AppTextField(title: 'Init', hintText: 'Example : IT'),
                AppSpace.vertical(12),
                AppTextField(title: 'Type'),
                AppSpace.vertical(12),
                AppTextField(title: 'Parent'),
                AppSpace.vertical(12),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
