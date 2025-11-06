import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/main_export.dart';
import 'package:asset_management/presentation/bloc/asset/asset_bloc.dart';
import 'package:flutter/material.dart';

class DesktopAssetsView extends StatefulWidget {
  const DesktopAssetsView({super.key});

  @override
  State<DesktopAssetsView> createState() => _DesktopAssetsViewState();
}

class _DesktopAssetsViewState extends State<DesktopAssetsView> {
  // Pagination & Filter variables
  int _currentPage = 1;
  int _rowsPerPage = 10;
  final List<int> _rowsPerPageOptions = [10, 25, 50, 100];
  String _searchQuery = '';
  String _selectedStatus = 'ALL';
  final List<String> _statusOptions = [
    'ALL',
    'READY',
    'USE',
    'REPAIR',
    'DISPOSAL',
  ];
  String _selectedCondition = 'ALL';
  final List<String> _conditionOptions = ['ALL', 'NEW', 'GOOD', 'OLD', 'BAD'];

  // Sorting variables
  String _sortColumn = 'id';
  bool _sortAscending = true;

  // Scroll controllers untuk sinkronisasi
  final ScrollController _horizontalHeaderScrollController = ScrollController();
  final ScrollController _horizontalBodyScrollController = ScrollController();
  final ScrollController _verticalBodyScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Sinkronisasi scroll horizontal
    _horizontalHeaderScrollController.addListener(_syncHorizontalScroll);
    _horizontalBodyScrollController.addListener(_syncHorizontalScroll);
  }

  void _syncHorizontalScroll() {
    if (_horizontalHeaderScrollController.hasClients &&
        _horizontalBodyScrollController.hasClients) {
      final headerOffset = _horizontalHeaderScrollController.offset;
      final bodyOffset = _horizontalBodyScrollController.offset;

      if (headerOffset != bodyOffset) {
        if (_horizontalHeaderScrollController
            .position
            .isScrollingNotifier
            .value) {
          _horizontalBodyScrollController.jumpTo(headerOffset);
        } else if (_horizontalBodyScrollController
            .position
            .isScrollingNotifier
            .value) {
          _horizontalHeaderScrollController.jumpTo(bodyOffset);
        }
      }
    }
  }

  @override
  void dispose() {
    _horizontalHeaderScrollController.dispose();
    _horizontalBodyScrollController.dispose();
    _verticalBodyScrollController.dispose();
    super.dispose();
  }

  List<AssetEntity> _filterData(List<AssetEntity>? assets) {
    if (assets == null) return [];

    var data = assets.where((asset) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          asset.assetCode?.toLowerCase().contains(_searchQuery.toLowerCase()) ==
              true ||
          asset.serialNumber?.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ==
              true ||
          asset.model?.toLowerCase().contains(_searchQuery.toLowerCase()) ==
              true ||
          asset.brand?.toLowerCase().contains(_searchQuery.toLowerCase()) ==
              true;

      final matchesStatus =
          _selectedStatus == 'ALL' || asset.status == _selectedStatus;
      final matchesCondition =
          _selectedCondition == 'ALL' || asset.conditions == _selectedCondition;

      return matchesSearch && matchesStatus && matchesCondition;
    }).toList();

    // Sorting berdasarkan index/No
    data.sort((a, b) {
      dynamic aValue;
      dynamic bValue;

      switch (_sortColumn) {
        case 'no': // Ubah dari 'id' menjadi 'no'
          // Untuk sorting No, kita gunakan index dari data asli
          final originalData = assets.where((asset) {
            final matchesSearch =
                _searchQuery.isEmpty ||
                asset.assetCode?.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ==
                    true ||
                asset.serialNumber?.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ==
                    true ||
                asset.model?.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ==
                    true ||
                asset.brand?.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ==
                    true;

            final matchesStatus =
                _selectedStatus == 'ALL' || asset.status == _selectedStatus;
            final matchesCondition =
                _selectedCondition == 'ALL' ||
                asset.conditions == _selectedCondition;

            return matchesSearch && matchesStatus && matchesCondition;
          }).toList();

          final aIndex = originalData.indexWhere((item) => item.id == a.id);
          final bIndex = originalData.indexWhere((item) => item.id == b.id);
          aValue = aIndex;
          bValue = bIndex;
          break;
        case 'assetCode':
          aValue = a.assetCode;
          bValue = b.assetCode;
          break;
        case 'quantity':
          aValue = a.quantity;
          bValue = b.quantity;
          break;
        case 'status':
          aValue = a.status;
          bValue = b.status;
          break;
        case 'conditions':
          aValue = a.conditions;
          bValue = b.conditions;
          break;
        case 'serialNumber':
          aValue = a.serialNumber;
          bValue = b.serialNumber;
          break;
        default:
          // Default sorting berdasarkan index juga
          final originalData = assets.where((asset) {
            final matchesSearch =
                _searchQuery.isEmpty ||
                asset.assetCode?.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ==
                    true ||
                asset.serialNumber?.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ==
                    true ||
                asset.model?.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ==
                    true ||
                asset.brand?.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ==
                    true;

            final matchesStatus =
                _selectedStatus == 'ALL' || asset.status == _selectedStatus;
            final matchesCondition =
                _selectedCondition == 'ALL' ||
                asset.conditions == _selectedCondition;

            return matchesSearch && matchesStatus && matchesCondition;
          }).toList();

          final aIndex = originalData.indexWhere((item) => item.id == a.id);
          final bIndex = originalData.indexWhere((item) => item.id == b.id);
          aValue = aIndex;
          bValue = bIndex;
      }

      if (aValue == null && bValue == null) return 0;
      if (aValue == null) return _sortAscending ? -1 : 1;
      if (bValue == null) return _sortAscending ? 1 : -1;

      final comparison = aValue.toString().compareTo(bValue.toString());
      return _sortAscending ? comparison : -comparison;
    });

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 15,
      child: BlocBuilder<AssetBloc, AssetState>(
        builder: (context, state) {
          if (state.assets == null || state.assets!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: AppColors.kGrey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No assets found',
                    style: TextStyle(fontSize: 16, color: AppColors.kGrey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add your first asset to get started',
                    style: TextStyle(fontSize: 14, color: AppColors.kGrey),
                  ),
                ],
              ),
            );
          }

          final filteredData = _filterData(state.assets);
          final startIndex = (_currentPage - 1) * _rowsPerPage;
          final endIndex = startIndex + _rowsPerPage;
          final paginatedData = filteredData.sublist(
            startIndex,
            endIndex > filteredData.length ? filteredData.length : endIndex,
          );
          final totalPages = (filteredData.length / _rowsPerPage).ceil();

          return Container(
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTableHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.kBackground),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        children: [
                          // Header dengan scroll controller yang sama
                          _buildTableHeaderRow(),
                          // Body dengan scroll controller yang sama
                          Expanded(child: _buildTableBody(paginatedData)),
                        ],
                      ),
                    ),
                  ),
                ),
                AppSpace.vertical(24),
                _buildPaginationControls(
                  filteredData.length,
                  totalPages,
                  startIndex,
                  endIndex,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.kGrey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 12),
                  Icon(Icons.search, size: 20, color: AppColors.kGrey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText:
                            'Search by asset code, serial number, model...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: AppColors.kGrey),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                          _currentPage = 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.kGrey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedStatus,
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value!;
                    _currentPage = 1;
                  });
                },
                items: _statusOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize: 13)),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(width: 12),
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.kGrey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCondition,
                onChanged: (value) {
                  setState(() {
                    _selectedCondition = value!;
                    _currentPage = 1;
                  });
                },
                items: _conditionOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize: 13)),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kBase,
              foregroundColor: AppColors.kWhite,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.add, size: 16),
                SizedBox(width: 6),
                Text('Add Asset'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeaderRow() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.kBase.withOpacity(0.05),
        border: Border(
          bottom: BorderSide(color: AppColors.kGrey.withOpacity(0.2)),
        ),
      ),
      child: SingleChildScrollView(
        controller: _horizontalHeaderScrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildHeaderCell('No', 60, 'no'),
            _buildHeaderCell('Asset Code', 220, 'assetCode'),
            _buildHeaderCell('Serial Number', 220, 'serialNumber'),
            _buildHeaderCell('Model', 200, 'model'),
            _buildHeaderCell('Category', 200, 'category'),
            _buildHeaderCell('Brand', 200, 'brand'),
            _buildHeaderCell('Type', 200, 'types'),
            _buildHeaderCell('Color', 80, 'color'),
            _buildHeaderCell('Location', 140, 'location'),
            _buildHeaderCell('Qty', 80, 'quantity'),
            _buildHeaderCell('Status', 100, 'status'),
            _buildHeaderCell('Condition', 100, 'conditions'),
            _buildHeaderCell('Purchase Order', 140, 'purchaseOrder'),
            _buildHeaderCell('Remarks', 220, 'remarks'),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, double width, String columnId) {
    final isSorted = _sortColumn == columnId;

    return Container(
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColors.kGrey.withOpacity(0.2)),
        ),
      ),
      child: InkWell(
        onTap: columnId.isNotEmpty
            ? () {
                setState(() {
                  if (_sortColumn == columnId) {
                    _sortAscending = !_sortAscending;
                  } else {
                    _sortColumn = columnId;
                    _sortAscending = true;
                  }
                });
              }
            : null,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.kGrey,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (columnId.isNotEmpty && isSorted)
              Icon(
                _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                size: 14,
                color: AppColors.kBase,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableBody(List<AssetEntity> data) {
    if (data.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 48, color: AppColors.kGrey),
              SizedBox(height: 16),
              Text(
                'No assets match your search criteria',
                style: TextStyle(fontSize: 14, color: AppColors.kGrey),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      controller: _verticalBodyScrollController,
      scrollDirection: Axis.vertical,

      child: Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: Column(
          children: [
            // Body rows dengan horizontal scroll yang sinkron
            SingleChildScrollView(
              controller: _horizontalBodyScrollController,
              scrollDirection: Axis.horizontal,
              child: Column(
                children: data.asMap().entries.map((entry) {
                  final index = entry.key;
                  final asset = entry.value;

                  final startIndex = (_currentPage - 1) * _rowsPerPage;
                  final rowNumber = startIndex + index + 1;

                  return Container(
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.kGrey.withOpacity(0.1),
                        ),
                      ),
                      color: index % 2 == 0
                          ? AppColors.kWhite
                          : AppColors.kBase.withOpacity(0.02),
                    ),
                    child: Row(
                      children: [
                        _buildDataCell(rowNumber.toString(), 60),
                        _buildDataCell(asset.assetCode ?? '-', 220),
                        _buildDataCell(asset.serialNumber ?? '-', 220),
                        _buildDataCell(asset.model ?? '-', 200),
                        _buildDataCell(asset.category ?? '-', 200),
                        _buildDataCell(asset.brand ?? '-', 200),
                        _buildDataCell(asset.types ?? '-', 200),
                        _buildDataCell(asset.color ?? '-', 80),
                        _buildDataCell(asset.location ?? '-', 140),
                        _buildDataCell(asset.quantity?.toString() ?? '-', 80),
                        _buildStatusCell(asset.status ?? '-', 100),
                        _buildConditionCell(asset.conditions ?? '-', 100),
                        _buildDataCell(asset.purchaseOrder ?? '-', 140),
                        _buildDataCell(
                          asset.remarks != null && asset.remarks!.length > 20
                              ? '${asset.remarks!.substring(0, 20)}...'
                              : asset.remarks ?? '-',
                          220,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, double width) {
    return Container(
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColors.kGrey.withOpacity(0.2)),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: AppColors.kGrey),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildStatusCell(String status, double width) {
    Color textColor;

    switch (status) {
      case 'READY':
        textColor = Colors.green;
        break;
      case 'USE':
        textColor = Colors.blue;
        break;
      case 'REPAIR':
        textColor = Colors.orange;
        break;
      case 'DISPOSAL':
        textColor = Colors.red;
        break;
      default:
        textColor = AppColors.kGrey;
    }

    return Container(
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColors.kGrey.withOpacity(0.2)),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          status,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildConditionCell(String condition, double width) {
    Color textColor;

    switch (condition) {
      case 'NEW':
        textColor = Colors.green;
        break;
      case 'GOOD':
        textColor = Colors.blue;
        break;
      case 'OLD':
        textColor = Colors.orange;
        break;
      case 'BAD':
        textColor = Colors.red;
        break;
      default:
        textColor = AppColors.kGrey;
    }

    return Container(
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColors.kGrey.withOpacity(0.2)),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          condition,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildPaginationControls(
    int totalItems,
    int totalPages,
    int startIndex,
    int endIndex,
  ) {
    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.kGrey.withOpacity(0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing ${startIndex + 1} to $endIndex of $totalItems entries',
            style: TextStyle(color: AppColors.kGrey, fontSize: 13),
          ),
          Row(
            children: [
              Text(
                'Rows per page:',
                style: TextStyle(color: AppColors.kGrey, fontSize: 13),
              ),
              SizedBox(width: 8),
              Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.kGrey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _rowsPerPage,
                    onChanged: (value) {
                      setState(() {
                        _rowsPerPage = value!;
                        _currentPage = 1;
                      });
                    },
                    style: TextStyle(fontSize: 13, color: AppColors.kGrey),
                    items: _rowsPerPageOptions.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Container(
                height: 32,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.kGrey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left, size: 18),
                      onPressed: _currentPage > 1
                          ? () => setState(() {
                              _currentPage--;
                            })
                          : null,
                      color: _currentPage > 1
                          ? AppColors.kBase
                          : AppColors.kGrey,
                      padding: EdgeInsets.all(6),
                    ),
                    ..._buildPageNumbers(totalPages),
                    IconButton(
                      icon: Icon(Icons.chevron_right, size: 18),
                      onPressed: _currentPage < totalPages
                          ? () => setState(() {
                              _currentPage++;
                            })
                          : null,
                      color: _currentPage < totalPages
                          ? AppColors.kBase
                          : AppColors.kGrey,
                      padding: EdgeInsets.all(6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageNumbers(int totalPages) {
    List<Widget> pages = [];
    int start = _currentPage - 1 > 0 ? _currentPage - 1 : 1;
    int end = _currentPage + 1 <= totalPages ? _currentPage + 1 : totalPages;
    for (int i = start; i <= end; i++) {
      pages.add(_buildPageNumber(i));
    }
    return pages;
  }

  Widget _buildPageNumber(int page) {
    return Container(
      width: 32,
      height: 32,
      margin: EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: _currentPage == page ? AppColors.kBase : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        onPressed: () => setState(() {
          _currentPage = page;
        }),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
        ),
        child: Text(
          page.toString(),
          style: TextStyle(
            fontSize: 13,
            color: _currentPage == page ? AppColors.kWhite : AppColors.kGrey,
            fontWeight: _currentPage == page
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
