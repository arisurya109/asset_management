// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/desktop/presentation/components/app_new_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:asset_management/desktop/presentation/bloc/authentication_desktop/authentication_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:asset_management/desktop/presentation/cubit/add_preparation_datas/add_preparation_datas_cubit.dart';

import '../../bloc/preparation_desktop/preparation_desktop_bloc.dart';
import '../../components/app_body_desktop.dart';

class PreparationDesktopView extends StatelessWidget {
  const PreparationDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    final hasPermission =
        context.read<AuthenticationDesktopBloc>().state.user?.modules?.any((e) {
          return e.containsValue('preparation_add');
        }) ??
        false;
    return Column(
      children: [
        AppHeaderDesktop(title: 'Preparation'),
        AppBodyDesktop(
          body: BlocBuilder<PreparationDesktopBloc, PreparationDesktopState>(
            builder: (context, state) {
              final rawData =
                  state.preparations?.asMap().entries.map((entry) {
                    int index = entry.key;
                    var e = entry.value;

                    return {
                      'code': e.code!,
                      'destination': e.destination ?? '',
                      'status': e.status ?? '',
                      'created': e.createdBy ?? '',
                      // 'worker': e.assigned ?? '',
                      // 'approved': e.approvedBy ?? '',
                      'description': 'Description Test ${index + 1}',
                    };
                  }).toList() ??
                  [];

              // final datas = DataTablePreparation(datas: rawData);
              return AppNewTable(
                datas: rawData,
                columns: [
                  AppDataTableColumn(label: 'CODE', key: 'code'),
                  AppDataTableColumn(label: 'DESTINATION', key: 'destination'),
                  AppDataTableColumn(
                    label: 'STATUS',
                    key: 'status',
                    badgeConfig: {
                      'assigned': const Color(
                        0xFF3B82F6,
                      ), // Blue (Fokus/Proses)
                      'cancelled': const Color(
                        0xFFEF4444,
                      ), // Red (Berhenti/Gagal)
                      'completed': const Color(
                        0xFF10B981,
                      ), // Emerald Green (Selesai/Berhasil)
                      'ready': const Color(
                        0xFFF59E0B,
                      ), // Amber/Orange (Menunggu/Siap)
                    },
                  ),
                  AppDataTableColumn(label: 'CREATED', key: 'created'),
                  AppDataTableColumn(label: 'DESCRIPTION', key: 'description'),
                ],
                isLoading: false,
                hintTextField: 'Search by code',
                onClear: () {},
                onSearchSubmit: (query) {},
                onExport: () {},
                onAdd: hasPermission
                    ? () {
                        context.read<AddPreparationDatasCubit>().getAssets();
                        context.push('/preparation/add');
                      }
                    : null,
                titleAdd: hasPermission ? 'Create' : '',
              );
            },
          ),
        ),
      ],
    );
  }
}
