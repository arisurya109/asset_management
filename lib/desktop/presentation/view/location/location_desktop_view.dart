import 'package:asset_management/desktop/presentation/bloc/authentication_desktop/authentication_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_new_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/location_desktop/location_desktop_bloc.dart';

class LocationDesktopView extends StatelessWidget {
  const LocationDesktopView({super.key});

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
                  state.locations?.asMap().entries.map((entry) {
                    int index = entry.key;
                    var e = entry.value;

                    return {
                      'id': e.id.toString(),
                      'no': (index + 1).toString(),
                      'name': e.name ?? '',
                      'code': e.code ?? '',
                      'init': e.init ?? '',
                      'type': e.locationType ?? '',
                    };
                  }).toList() ??
                  [];
              return AppNewTable(
                datas: datas,
                totalData: 2000,
                onAdd: hasPermission
                    ? () => context.push('/location/add')
                    : null,
                titleAdd: hasPermission ? 'Add Location' : null,
                hintTextField: 'Search By Name or Init',
                onSearchSubmit: (query) => context
                    .read<LocationDesktopBloc>()
                    .add(OnFindAllLocationByQuery(query)),
                onClear: () => context.read<LocationDesktopBloc>().add(
                  OnFindAllLocation(),
                ),
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
