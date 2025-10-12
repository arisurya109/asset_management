import 'package:asset_management/features/asset_master_new/asset_master_export.dart';
import 'package:asset_management/features/asset_master_new/presentation/cubit/asset_master_new_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';

class AssetMasterNewView extends StatefulWidget {
  const AssetMasterNewView({super.key});

  @override
  State<AssetMasterNewView> createState() => _AssetMasterNewViewState();
}

class _AssetMasterNewViewState extends State<AssetMasterNewView> {
  @override
  void initState() {
    context.read<AssetMasterNewCubit>().load();
    context.read<AssetBrandBloc>().add(OnGetAllAssetBrand());
    context.read<AssetCategoryBloc>().add(OnGetAllAssetCategory());
    context.read<AssetModelBloc>().add(OnGetAllAssetModel());
    context.read<AssetTypeBloc>().add(OnGetAllAssetType());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEW ASSET MASTER'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: BlocBuilder<AssetMasterNewCubit, List<Map<String, dynamic>>>(
          builder: (context, state) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: state.length,
              itemBuilder: (context, index) {
                final item = state[index];

                return Material(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(8),
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  shadowColor: Colors.black.withOpacity(0.7),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => item['view']),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(item['icon'], height: 32),
                          AppSpace.vertical(8),
                          Text(
                            item['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
