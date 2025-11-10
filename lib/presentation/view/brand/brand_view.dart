// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/asset_brand.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/view/brand/create_asset_brand_view.dart';

import '../../components/app_list_tile_custom.dart';

class AssetBrandView extends StatefulWidget {
  const AssetBrandView({super.key});

  @override
  State<AssetBrandView> createState() => _AssetBrandViewState();
}

class _AssetBrandViewState extends State<AssetBrandView> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileBrand(),
      mobileMScaffold: _mobileBrand(isLarge: false),
    );
  }

  Widget _mobileBrand({bool isLarge = true}) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final permission = state.user!.modules;
        return Scaffold(
          appBar: AppBar(
            title: Text('Asset Brand'),
            actions: permission?.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () => context.push(CreateAssetBrandView()),
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
              } else if (state.brands != null || state.brands != []) {
                final brands = state.brands
                  ?..sort((a, b) => a.name!.compareTo(b.name!));
                List<AssetBrand> filteredBrand = [];

                if (query.isNotEmpty || query != '') {
                  filteredBrand = brands!.where((element) {
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
                        hintText: 'Search...',
                        fontSize: isLarge ? 14 : 12,
                        onChanged: (value) => setState(() {
                          query = value;
                        }),
                      ),
                      AppSpace.vertical(16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredBrand.isEmpty
                              ? brands?.length
                              : filteredBrand.length,
                          itemBuilder: (context, index) {
                            final brand = filteredBrand.isNotEmpty
                                ? filteredBrand[index]
                                : brands?[index];
                            return AppListTileCustom(
                              title: brand?.name,
                              fontSize: isLarge ? 14 : 12,
                              trailing: brand?.init,
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
