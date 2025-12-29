import 'package:asset_management/core/core.dart';
import 'package:flutter/material.dart';

class DataTableColumn {
  final String label;
  final String key;
  final double width;
  final bool isExpanded;
  final bool isCenter;
  final Map<String, Color>? badgeConfig;

  DataTableColumn({
    required this.label,
    required this.key,
    required this.width,
    this.isExpanded = false,
    this.isCenter = false,
    this.badgeConfig,
  });
}

class AppDataTable extends StatefulWidget {
  final List<DataTableColumn> columns;
  final List<Map<String, String>> data;
  final bool isLoading;
  final Function(String query) onSearchSubmit;
  final Function() onClear;
  final String? hintTextField;
  final Function()? onExport;

  const AppDataTable({
    super.key,
    required this.columns,
    required this.data,
    required this.isLoading,
    required this.onSearchSubmit,
    required this.onClear,
    this.hintTextField = 'Find...',
    this.onExport,
  });

  @override
  State<AppDataTable> createState() => _AppDataTableState();
}

class _AppDataTableState extends State<AppDataTable> {
  final ScrollController _horizontalScroll = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  int _currentPage = 1;
  int _itemsPerPage = 15;

  bool _isSearchActive = false;

  @override
  void dispose() {
    _searchController.dispose();
    _horizontalScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int total = widget.data.length;
    int start = (_currentPage - 1) * _itemsPerPage;
    if (start >= total && total > 0) {
      start = 0;
      _currentPage = 1;
    }

    int end = (start + _itemsPerPage > total) ? total : start + _itemsPerPage;
    List<Map<String, String>> pagedData = widget.data.isEmpty
        ? []
        : widget.data.sublist(start, end);

    return Column(
      children: [
        _buildSearchArea(),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double totalColumnWidth = widget.columns.fold(
                0,
                (sum, col) => sum + col.width,
              );
              double tableWidth = (totalColumnWidth + 40) > constraints.maxWidth
                  ? (totalColumnWidth + 40)
                  : constraints.maxWidth;

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Scrollbar(
                  controller: _horizontalScroll,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _horizontalScroll,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: tableWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeader(),
                          const Divider(height: 1, color: Color(0xFFEDF2F7)),
                          Expanded(
                            child: Stack(
                              children: [
                                _buildBody(pagedData),
                                if (widget.isLoading) _buildLoading(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        _buildFooterArea(start, end, total),
      ],
    );
  }

  Widget _buildSearchArea() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          widget.onExport != null
              ? SizedBox(
                  height: 32,
                  child: OutlinedButton.icon(
                    onPressed: widget.onExport,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    icon: const Icon(
                      Icons.download_rounded,
                      size: 16,
                      color: Color(0xFF64748B),
                    ),
                    label: const Text(
                      "Export",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF475569),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),

          widget.onExport != null ? AppSpace.horizontal(24) : SizedBox.shrink(),

          SizedBox(
            width: 240,
            height: 32,
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: 12),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  setState(() => _isSearchActive = true);
                  widget.onSearchSubmit(value);
                }
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                isDense: true,
                hintText: widget.hintTextField,
                prefixIcon: const Icon(Icons.search, size: 16),
                suffixIcon: _isSearchActive
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 16),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _isSearchActive = false;
                          });
                          widget.onClear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: AppColors.kBase,
                    width: 1,
                  ),
                ),
              ),
              onChanged: (value) {
                if (value.isEmpty && _isSearchActive) {
                  setState(() => _isSearchActive = false);
                  widget.onClear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      ),
      child: Row(
        children: widget.columns
            .map(
              (col) => _buildCellWrapper(
                col,
                Text(
                  col.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: Color(0xFF64748B),
                  ),
                ),
                isHeader: true,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildBody(List<Map<String, String>> pagedData) {
    if (pagedData.isEmpty && !widget.isLoading) {
      return const Center(child: Text("Data tidak ditemukan"));
    }
    return ListView.separated(
      itemCount: pagedData.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
      itemBuilder: (context, index) {
        final row = pagedData[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: widget.columns.map((col) {
              String value = row[col.key] ?? "-";
              Widget content = col.badgeConfig != null
                  ? _AppBadge(
                      text: value,
                      color:
                          col.badgeConfig![value.toLowerCase()] ?? Colors.grey,
                    )
                  : Text(
                      value,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF334155),
                      ),
                      overflow: TextOverflow.ellipsis,
                    );
              return _buildCellWrapper(col, content, isHeader: false);
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildCellWrapper(
    DataTableColumn col,
    Widget child, {
    required bool isHeader,
  }) {
    final Alignment cellAlignment = isHeader
        ? Alignment.centerLeft
        : (col.isCenter ? Alignment.center : Alignment.centerLeft);
    Widget content = Container(
      height: isHeader ? 40 : 50,
      alignment: cellAlignment,
      child: child,
    );
    if (col.isExpanded) {
      return Expanded(
        child: Container(
          constraints: BoxConstraints(minWidth: col.width),
          child: content,
        ),
      );
    }
    return SizedBox(width: col.width, child: content);
  }

  Widget _buildFooterArea(int s, int e, int t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildEntriesDropdown(),
              Text(
                "Showing ${t == 0 ? 0 : s + 1}-$e of $t",
                style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
          _buildPaginationButtons(t),
        ],
      ),
    );
  }

  Widget _buildEntriesDropdown() {
    return Container(
      height: 26,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _itemsPerPage,
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 16,
            color: Color(0xFF64748B),
          ),
          focusColor: Colors.transparent,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w600,
          ),
          onChanged: (int? newValue) {
            if (newValue != null) {
              setState(() {
                _itemsPerPage = newValue;
                _currentPage = 1;
              });
            }
          },
          items: [10, 15, 25, 50, 100]
              .map<DropdownMenuItem<int>>(
                (int value) => DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildPaginationButtons(int total) {
    bool canPrev = _currentPage > 1;
    bool canNext = _currentPage < (total / _itemsPerPage).ceil();
    return Container(
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _navBtn(
            Icons.chevron_left,
            canPrev,
            () => setState(() => _currentPage--),
            isLeft: true,
          ),
          Container(width: 1, height: 24, color: const Color(0xFFE2E8F0)),
          _navBtn(
            Icons.chevron_right,
            canNext,
            () => setState(() => _currentPage++),
            isLeft: false,
          ),
        ],
      ),
    );
  }

  Widget _navBtn(
    IconData icon,
    bool active,
    VoidCallback tap, {
    required bool isLeft,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: active ? tap : null,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(isLeft ? 3 : 0),
          right: Radius.circular(isLeft ? 0 : 3),
        ),
        child: Container(
          width: 40,
          height: 24,
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 20,
            color: active ? const Color(0xFF475569) : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => Container(
    color: Colors.white.withOpacity(0.5),
    child: const Center(child: CircularProgressIndicator()),
  );
}

class _AppBadge extends StatelessWidget {
  final String text;
  final Color color;
  const _AppBadge({required this.text, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
