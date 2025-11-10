// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:asset_management/presentation/view/type/create_asset_type_view.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';

import '../../components/app_list_tile_custom.dart';

class AssetTypeView extends StatefulWidget {
  const AssetTypeView({super.key});

  @override
  State<AssetTypeView> createState() => _AssetTypeViewState();
}

class _AssetTypeViewState extends State<AssetTypeView> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileType(),
      mobileMScaffold: _mobileType(isLarge: false),
    );
  }

  Widget _mobileType({bool isLarge = true}) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final permission = state.user!.modules;
        return Scaffold(
          appBar: AppBar(
            title: Text('Asset Type'),
            actions: permission?.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () => context.push(CreateAssetTypeView()),
                      icon: Icon(Icons.add),
                    ),
                  ]
                : null,
          ),
          body: BlocBuilder<MasterBloc, MasterState>(
            builder: (context, state) {
              if (state.status == StatusMaster.loading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.kBase),
                );
              } else if (state.status == StatusMaster.failed) {
                return Center(
                  child: Text(
                    state.message ?? '',
                    style: TextStyle(fontSize: isLarge ? 14 : 12),
                  ),
                );
              } else if (state.types != null || state.types != []) {
                final types = state.types
                  ?..sort((a, b) => a.name!.compareTo(b.name!));
                List<AssetType> filteredTypes = [];

                if (query.isNotEmpty || query != '') {
                  filteredTypes = types!.where((element) {
                    final name = element.name?.toLowerCase() ?? '';
                    final init = element.init?.toLowerCase() ?? '';
                    return name.contains(query.toLowerCase()) ||
                        init.contains(query.toLowerCase());
                  }).toList();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      AppSpace.vertical(16),
                      AppTextField(
                        noTitle: true,
                        fontSize: isLarge ? 14 : 12,
                        hintText: 'Search...',
                        onChanged: (value) => setState(() {
                          query = value;
                        }),
                      ),
                      AppSpace.vertical(16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredTypes.isEmpty
                              ? types?.length
                              : filteredTypes.length,
                          itemBuilder: (context, index) {
                            final type = filteredTypes.isNotEmpty
                                ? filteredTypes[index]
                                : types?[index];
                            return AppListTileCustom(
                              title: type?.name,
                              trailing: type?.init,
                              fontSize: isLarge ? 14 : 12,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}
