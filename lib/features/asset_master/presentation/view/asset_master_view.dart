import 'package:asset_management/features/asset_master/presentation/view/asset_master_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_asset__master_view.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/app_space.dart';
import '../bloc/asset_master/asset_master_bloc.dart';

class AssetMasterView extends StatefulWidget {
  const AssetMasterView({super.key});

  @override
  State<AssetMasterView> createState() => _AssetMasterViewState();
}

class _AssetMasterViewState extends State<AssetMasterView> {
  @override
  void initState() {
    context.read<AssetMasterBloc>().add(OnFindAllAssetMaster());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASSET MASTER'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddAssetMasterView()),
            ),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: BlocBuilder<AssetMasterBloc, AssetMasterState>(
          builder: (context, state) {
            if (state.status == StatusAssetMaster.loading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.kBase),
              );
            }

            if (state.assets == null || state.assets!.isEmpty) {
              return Center(
                child: Text(
                  'Asset is still empty',
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
              itemCount: state.assets?.length,
              itemBuilder: (context, index) {
                final asset = state.assets![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.circular(8),
                    clipBehavior: Clip.antiAlias,
                    elevation: 3,
                    shadowColor: Colors.black.withOpacity(0.7),
                    child: InkWell(
                      onTap: () {
                        context.read<AssetMasterBloc>().add(
                          OnSelectedAssetMaster(asset),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AssetMasterDetailView(),
                          ),
                        );
                      },
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
                              asset.type!,
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
  }
}
