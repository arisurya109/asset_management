import 'package:flutter/material.dart';

class SearchableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final String hintText;
  final void Function(T?) onChanged;
  final bool Function(T item, String query) filterFn;
  final String Function(T item) displayFn;

  const SearchableDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.hintText,
    required this.filterFn,
    required this.displayFn,
    this.value,
  });

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
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
          title: Text('Selected ${widget.hintText}'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Find name or code...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
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
    return InkWell(
      onTap: openSearchDialog,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Text(
          widget.value != null
              ? widget.displayFn(widget.value!)
              : 'Selected ${widget.hintText}',
          style: TextStyle(
            color: widget.value == null ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }
}
