import 'package:asset_management/features/modules/assets/cubit/modul_asset_cubit.dart';
import 'package:asset_management/features/modules/inventories/inventory_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../user/presentation/bloc/user/user_bloc.dart';

class AssetModuleView extends StatefulWidget {
  const AssetModuleView({super.key});

  @override
  State<AssetModuleView> createState() => _AssetModuleViewState();
}

class _AssetModuleViewState extends State<AssetModuleView> {
  @override
  void initState() {
    final modules = context
        .read<UserBloc>()
        .state
        .user
        ?.modules
        ?.map((e) => e.toString())
        .toList();

    context.read<ModulAssetCubit>().loadItems(modules!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASSETS'),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: BlocBuilder<ModulAssetCubit, List<Map<String, dynamic>>>(
          builder: (context, state) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
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
                    onTap: () {
                      if (item['value'] == 'inventory_view') {
                        context.read<InventoryBloc>().add(OnGetAllInventory());
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => item['view']),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(item['icons'], height: 32),
                          AppSpace.vertical(8),
                          Text(
                            item['name'],
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
