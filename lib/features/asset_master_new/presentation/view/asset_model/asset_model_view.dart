import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../components/app_card_item.dart';
import '../../../../../core/core.dart';
import '../../../../user/presentation/bloc/user/user_bloc.dart';
import '../../../asset_master_export.dart';
import 'create_asset_model_view.dart';

class AssetModelView extends StatefulWidget {
  const AssetModelView({super.key});

  @override
  State<AssetModelView> createState() => _AssetModelViewState();
}

class _AssetModelViewState extends State<AssetModelView> {
  final TextEditingController _searchC = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    _searchC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final permission = state.user!.modules;
        return Scaffold(
          appBar: AppBar(
            title: Text('ASSET MODEL'),
            elevation: 0,
            actions: permission?.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAssetModelView(),
                        ),
                      ),
                      icon: Icon(Icons.add),
                    ),
                  ]
                : null,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(height: 1, color: AppColors.kBase),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              children: [
                AppTextField(
                  noTitle: true,
                  controller: _searchC,
                  hintText: 'Search by name, code or category',
                  onChanged: (value) => setState(() {
                    searchQuery = value.toUpperCase();
                  }),
                ),
                AppSpace.vertical(16),
                Expanded(
                  child: BlocBuilder<AssetModelBloc, AssetModelState>(
                    builder: (context, state) {
                      if (state.status == StatusAssetModel.loading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.kBase,
                          ),
                        );
                      }

                      if (state.assetModels == null ||
                          state.assetModels == []) {
                        return Center(
                          child: Text(
                            state.message ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.kGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }

                      // 🔍 Filter list berdasarkan searchQuery
                      final filteredList = state.assetModels!.where((asset) {
                        final name = asset.name?.toUpperCase() ?? '';
                        final category =
                            asset.categoryName?.toUpperCase() ?? '';
                        return name.contains(searchQuery) ||
                            category.contains(searchQuery);
                      }).toList();

                      if (filteredList.isEmpty) {
                        return const Center(
                          child: Text(
                            'Tidak ada hasil pencarian',
                            style: TextStyle(color: AppColors.kGrey),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final asset = filteredList[index];
                          return AppCardItem(
                            onTap: permission?.contains('master_update') == true
                                ? () {}
                                : null,
                            title: asset.name,
                            subtitle: asset.categoryName,
                            leading: asset.typeName,
                            colorTextLeading: asset.typeName == 'BACKOFFICE'
                                ? AppColors.kBlack
                                : asset.typeName == 'POS'
                                ? AppColors.kOrangeDark
                                : AppColors.kGreenDark,
                            backgroundColorLeading:
                                asset.typeName == 'BACKOFFICE'
                                ? Color(0XFFDFE3E8)
                                : asset.typeName == 'POS'
                                ? AppColors.kOrangeLight
                                : AppColors.kGreenLight,
                            descriptionLeft: asset.brandName,
                            descriptionRight: asset.unit == 1 ? 'Unit' : 'Pcs',
                          );
                        },
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
  }
}
