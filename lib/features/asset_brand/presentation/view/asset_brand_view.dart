import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_brand/asset_brand_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../user/user_export.dart';

class AssetBrandView extends StatelessWidget {
  const AssetBrandView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final permission = state.user!.modules;
        return Scaffold(
          appBar: AppBar(
            title: Text('Asset Brand'),
            actions: permission?.contains('master_add') == true
                ? [
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAssetBrandView(),
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
          body: BlocBuilder<AssetBrandBloc, AssetBrandState>(
            builder: (context, state) {
              if (state.status == StatusAssetBrand.loading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.kBase),
                );
              } else if (state.status == StatusAssetBrand.failed) {
                return Center(child: Text(state.message ?? ''));
              } else if (state.brands != null || state.brands != []) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(state.brands!.length, (index) {
                        final asset = state.brands?[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Material(
                            color: AppColors.kWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: AppColors.kBase),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        asset?.name ?? '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      asset?.init ?? '',
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
                      }),
                    ),
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
