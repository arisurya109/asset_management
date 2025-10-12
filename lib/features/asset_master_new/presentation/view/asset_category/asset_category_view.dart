import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../user/presentation/bloc/user/user_bloc.dart';
import '../../../asset_master_export.dart';
import 'create_asset_category_view.dart';

class AssetCategoryView extends StatelessWidget {
  const AssetCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final permission = state.user!.modules;
        return Scaffold(
          appBar: AppBar(
            title: Text('ASSET CATEGORY'),
            elevation: 0,
            actions: permission?.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAssetCategoryView(),
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
            child: BlocBuilder<AssetCategoryBloc, AssetCategoryState>(
              builder: (context, state) {
                if (state.status == StatusAssetCategory.loading) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.kBase),
                  );
                }

                if (state.assetCategories == null ||
                    state.assetCategories!.isEmpty) {
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
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.assetCategories?.length,
                  itemBuilder: (context, index) {
                    final asset = state.assetCategories![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Material(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(8),
                        clipBehavior: Clip.antiAlias,
                        elevation: 3,
                        shadowColor: Colors.black.withOpacity(0.7),
                        child: InkWell(
                          onTap: permission?.contains('master_update') == true
                              ? () {}
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                AppSpace.horizontal(12),
                                Expanded(
                                  child: Text(
                                    asset.name!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  asset.init!,
                                  style: TextStyle(
                                    color: AppColors.kBase,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
