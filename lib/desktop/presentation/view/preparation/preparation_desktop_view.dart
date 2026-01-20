import 'package:asset_management/core/core.dart';
import 'package:asset_management/desktop/presentation/bloc/authentication_desktop/authentication_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_desktop/preparation_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_new_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PreparationDesktopView extends StatefulWidget {
  const PreparationDesktopView({super.key});

  @override
  State<PreparationDesktopView> createState() => _PreparationDesktopViewState();
}

class _PreparationDesktopViewState extends State<PreparationDesktopView> {
  late ScrollController _horizontalScroll;

  final List<int> _availableRowsPerPage = [10, 20, 50, 100];
  int _rowsPerPage = 10;
  int _currentPage = 1;
  String? _searchQuery;

  @override
  void initState() {
    _horizontalScroll = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _horizontalScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasPermission =
        context.read<AuthenticationDesktopBloc>().state.user?.modules?.any((e) {
          return e.containsValue('master_add');
        }) ??
        false;
    return Column(
      children: [
        AppHeaderDesktop(title: 'Preparation', hasPermission: hasPermission),
        AppBodyDesktop(
          body: BlocBuilder<PreparationDesktopBloc, PreparationDesktopState>(
            builder: (context, state) {
              final datas =
                  state.datas?.preparations?.asMap().entries.map((entry) {
                    int index = entry.key;
                    var e = entry.value;
                    int noUrut =
                        ((_currentPage - 1) * _rowsPerPage) + index + 1;

                    return {
                      'id': e.id.toString(),
                      'no': noUrut.toString(),
                      'code': e.code ?? '',
                      'type': e.type ?? '',
                      'destination': e.destination ?? '',
                      'status': e.status ?? '',
                      'notes': e.notes ?? '',
                    };
                  }).toList() ??
                  [];

              return AppNewTable(
                datas: datas,
                horizontalScrollController: _horizontalScroll,
                totalData: state.datas?.totalData ?? 0,
                availableRowsPerPage: _availableRowsPerPage,
                onTap: (data) =>
                    context.push('/preparation/detail/${data['id']}'),
                rowsPerPage: _rowsPerPage,
                onAdd: hasPermission
                    ? () => context.push('/preparation/add')
                    : null,
                titleAdd: hasPermission ? 'Add Preparation' : null,
                hintTextField: 'Search...',
                onRowsPerPageChanged: (rowsPerPage) {
                  if (rowsPerPage != null) {
                    _rowsPerPage = rowsPerPage;
                    _currentPage = 1;
                    context.read<PreparationDesktopBloc>().add(
                      OnFindPreparationPaginationEvent(
                        limit: _rowsPerPage,
                        page: _currentPage,
                        query: _searchQuery,
                      ),
                    );
                  }
                },
                onPageChanged: (index) {
                  _currentPage = (index / _rowsPerPage).toInt() + 1;
                  context.read<PreparationDesktopBloc>().add(
                    OnFindPreparationPaginationEvent(
                      limit: _rowsPerPage,
                      page: _currentPage,
                      query: _searchQuery,
                    ),
                  );
                },
                onSearchSubmit: (query) {
                  _currentPage = 1;
                  setState(() {
                    _searchQuery = query;
                  });
                  context.read<PreparationDesktopBloc>().add(
                    OnFindPreparationPaginationEvent(
                      limit: _rowsPerPage,
                      page: 1,
                      query: _searchQuery,
                    ),
                  );
                },
                onClear: () {
                  setState(() {
                    _searchQuery = null;
                  });
                  context.read<PreparationDesktopBloc>().add(
                    OnFindPreparationPaginationEvent(
                      limit: _rowsPerPage,
                      page: _currentPage,
                    ),
                  );
                },
                columns: [
                  AppDataTableColumn(label: 'NO', key: 'no', width: 50),
                  AppDataTableColumn(label: 'CODE', key: 'code'),
                  AppDataTableColumn(label: 'TYPE', key: 'type'),
                  AppDataTableColumn(label: 'DESTINATION', key: 'destination'),
                  AppDataTableColumn(
                    label: 'STATUS',
                    key: 'status',
                    badgeConfig: {
                      'draft': AppColors.kGrey,
                      'picking': AppColors.kYellow,
                      'assigned': AppColors.kBlue,
                      'cancelled': AppColors.kRed,
                      'rejected': AppColors.kRed,
                    },
                  ),
                  AppDataTableColumn(
                    label: 'NOTES',
                    key: 'notes',
                    isExpanded: true,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
