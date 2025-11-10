// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/presentation/view/category/create_asset_category_view.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';

import '../../components/app_list_tile_custom.dart';

class AssetCategoryView extends StatefulWidget {
  const AssetCategoryView({super.key});

  @override
  State<AssetCategoryView> createState() => _AssetCategoryViewState();
}

class _AssetCategoryViewState extends State<AssetCategoryView> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileCategory(),
      mobileMScaffold: _mobileCategory(isLarge: false),
    );
  }

  Widget _mobileCategory({bool isLarge = true}) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final permission = state.user!.modules;
        return Scaffold(
          appBar: AppBar(
            title: Text('Asset Category'),
            actions: permission?.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () => context.push(CreateAssetCategoryView()),
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
              } else if (state.categories != null || state.categories != []) {
                final categories = state.categories
                  ?..sort((a, b) => a.name!.compareTo(b.name!));
                List<AssetCategory> filteredCategories = [];

                if (query.isNotEmpty || query != '') {
                  filteredCategories = categories!.where((element) {
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
                          itemCount: filteredCategories.isEmpty
                              ? categories?.length
                              : filteredCategories.length,
                          itemBuilder: (context, index) {
                            final category = filteredCategories.isNotEmpty
                                ? filteredCategories[index]
                                : categories?[index];
                            return AppListTileCustom(
                              title: category?.name,
                              trailing: category?.init,
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
