import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../main_export.dart';
import '../../../../view/view.dart';
import '../../../asset_count/asset_count.dart';
import '../../../asset_master/asset_master.dart';
import '../../../asset_preparation/asset_preparation.dart';
import '../../../reprint/reprint.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<AssetMasterBloc>().add(OnFindAllAssetMaster());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASSET MANAGEMENT'),
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            AppSpace.vertical(12),
            Container(
              height: 300,
              width: double.infinity,
              color: AppColors.kBase,
            ),
            AppSpace.vertical(24),
            Expanded(
              child: BlocBuilder<HomeCubit, List<Map<String, dynamic>>>(
                builder: (context, state) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                            switch (item['value']) {
                              case 0:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AssetMasterView(),
                                  ),
                                );
                                break;
                              case 1:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AssetPreparationView(),
                                  ),
                                );
                                break;
                              case 2:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AssetCountView(),
                                  ),
                                );
                                break;
                              case 3:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ReprintAssetIdView(),
                                  ),
                                );
                                break;
                              case 4:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ReprintLocationView(),
                                  ),
                                );
                                break;
                              case 5:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PrinterView(),
                                  ),
                                );
                                break;
                            }
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
          ],
        ),
      ),
    );
  }
}
