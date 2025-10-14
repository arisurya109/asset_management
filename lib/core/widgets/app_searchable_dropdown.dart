import 'package:flutter/material.dart';

import '../core.dart';

class AppSearchableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final String hintText;
  final String hintTextField;
  final void Function(T?) onChanged;
  final bool Function(T item, String query) filterFn;
  final String Function(T item) displayFn;

  const AppSearchableDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.hintText,
    required this.filterFn,
    required this.displayFn,
    this.value,
    required this.hintTextField,
  });

  @override
  State<AppSearchableDropdown<T>> createState() =>
      _AppSearchableDropdownState<T>();
}

class _AppSearchableDropdownState<T> extends State<AppSearchableDropdown<T>> {
  late List<T> filteredItems;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  void openSearchDialog() async {
    final result = await showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Selected ${widget.hintText}'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: widget.hintTextField,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 18,
                    ),
                    hintStyle: TextStyle(
                      // color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      filteredItems = widget.items
                          .where((item) => widget.filterFn(item, value))
                          .toList();
                    });
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return ListTile(
                        title: Text(widget.displayFn(item)),
                        onTap: () => Navigator.pop(context, item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (result != null) widget.onChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hintText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        AppSpace.vertical(8),
        InkWell(
          onTap: openSearchDialog,
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              widget.value != null
                  ? widget.displayFn(widget.value!)
                  : 'Selected ${widget.hintText}',
              style: TextStyle(
                color: widget.value != null ? AppColors.kBlack : Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
