import 'package:asset_management/desktop/presentation/bloc/authentication_desktop/authentication_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_new_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/location_desktop/location_desktop_bloc.dart';

class LocationDesktopView extends StatefulWidget {
  const LocationDesktopView({super.key});

  @override
  State<LocationDesktopView> createState() => _LocationDesktopViewState();
}

class _LocationDesktopViewState extends State<LocationDesktopView> {
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
        AppHeaderDesktop(title: 'Location', hasPermission: hasPermission),
        AppBodyDesktop(
          body: BlocBuilder<LocationDesktopBloc, LocationDesktopState>(
            builder: (context, state) {
              final datas =
                  state.response?.locations?.asMap().entries.map((entry) {
                    int index = entry.key;
                    var e = entry.value;
                    int noUrut =
                        ((_currentPage - 1) * _rowsPerPage) + index + 1;

                    return {
                      'id': e.id.toString(),
                      'no': noUrut.toString(),
                      'name': e.name ?? '',
                      'code': e.code ?? '',
                      'init': e.init ?? '',
                      'type': e.locationType ?? '',
                    };
                  }).toList() ??
                  [];

              return AppNewTable(
                datas: datas,
                horizontalScrollController: _horizontalScroll,
                totalData: state.response?.totalData ?? 0,
                availableRowsPerPage: _availableRowsPerPage,
                rowsPerPage: _rowsPerPage,
                onAdd: hasPermission
                    ? () => context.push('/location/add')
                    : null,
                titleAdd: hasPermission ? 'Add Location' : null,
                hintTextField: 'Search By Name or Init',
                onRowsPerPageChanged: (rowsPerPage) {
                  if (rowsPerPage != null) {
                    _rowsPerPage = rowsPerPage;
                    _currentPage = 1;
                    context.read<LocationDesktopBloc>().add(
                      OnFindLocationPagination(
                        limit: _rowsPerPage,
                        page: _currentPage,
                        query: _searchQuery,
                      ),
                    );
                  }
                },
                onPageChanged: (index) {
                  _currentPage = (index / _rowsPerPage).toInt() + 1;
                  context.read<LocationDesktopBloc>().add(
                    OnFindLocationPagination(
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
                  context.read<LocationDesktopBloc>().add(
                    OnFindLocationPagination(
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
                  context.read<LocationDesktopBloc>().add(
                    OnFindLocationPagination(
                      limit: _rowsPerPage,
                      page: _currentPage,
                    ),
                  );
                },
                columns: [
                  AppDataTableColumn(label: 'NO', key: 'no', width: 50),
                  AppDataTableColumn(
                    label: 'NAME',
                    key: 'name',
                    isExpanded: true,
                  ),
                  AppDataTableColumn(label: 'CODE', key: 'code'),
                  AppDataTableColumn(label: 'INIT', key: 'init'),
                  AppDataTableColumn(
                    label: 'TYPE',
                    key: 'type',
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
