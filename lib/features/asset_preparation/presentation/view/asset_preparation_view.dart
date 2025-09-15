import 'package:asset_management/core/extension/context_ext.dart';
import 'package:asset_management/core/utils/constant.dart';
import 'package:asset_management/features/asset_preparation/presentation/view/add_asset_preparation_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/app_space.dart';
import '../../asset_preparation.dart';

class AssetPreparationView extends StatefulWidget {
  const AssetPreparationView({super.key});

  @override
  State<AssetPreparationView> createState() => _AssetPreparationViewState();
}

class _AssetPreparationViewState extends State<AssetPreparationView> {
  @override
  void initState() {
    context.read<AssetPreparationBloc>().add(OnFindAllPreparation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASSET PREPARATION'),
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
              MaterialPageRoute(
                builder: (context) => AddAssetPreparationView(),
              ),
            ),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: BlocBuilder<AssetPreparationBloc, AssetPreparationState>(
          builder: (context, state) {
            if (state.status == StatusPreparation.loading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.kBackground),
              );
            }

            if (state.preparations == null || state.preparations!.isEmpty) {
              return Center(
                child: Text(
                  'Preparation is still empty',
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
              itemCount: state.preparations?.length,
              itemBuilder: (context, index) {
                final preparation = state.preparations![index];
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
                        if (preparation.status == PreparationStatus.created) {
                          context.showDialogConfirm(
                            title: 'Start Preparation',
                            content:
                                'Do you want to start preparing your assets?',
                            onCancelText: 'No',
                            onCancel: () => Navigator.pop(context),
                            onConfirmText: 'Ya',
                            onConfirm: () {
                              context.read<AssetPreparationBloc>().add(
                                OnUpdateStatusPreparaion(
                                  AssetPreparation(
                                    id: preparation.id,
                                    status: PreparationStatus.inprogress,
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                              context.read<AssetPreparationBloc>().add(
                                OnSelectedPreparation(preparation),
                              );
                              Future.delayed(Duration(seconds: 5));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AddAssetPreparationDetailView(),
                                ),
                              );
                            },
                          );
                        } else {
                          context.read<AssetPreparationBloc>().add(
                            OnSelectedPreparation(preparation),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddAssetPreparationDetailView(),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  preparation.storeName!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.kBlack,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color:
                                        preparation.status ==
                                            PreparationStatus.created
                                        ? Color(0XFFDFE3E8)
                                        : preparation.status ==
                                              PreparationStatus.inprogress
                                        ? AppColors.kOrangeLight
                                        : AppColors.kGreenLight,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    preparation.status!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          preparation.status ==
                                              PreparationStatus.created
                                          ? AppColors.kBlack
                                          : preparation.status ==
                                                PreparationStatus.inprogress
                                          ? AppColors.kOrangeDark
                                          : AppColors.kGreenDark,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppSpace.vertical(8),
                            Text(
                              '${preparation.storeInitial!} - ${preparation.storeCode}',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.kBlack,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            AppSpace.vertical(8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.kBackground,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_sharp,
                                        size: 20,
                                        color: AppColors.kGrey,
                                      ),
                                      AppSpace.horizontal(5),
                                      Text(
                                        DateFormat('d-MM-y').format(
                                          DateTime.parse(
                                            preparation.createdAt!,
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.kBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text('|'),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.store_outlined,
                                        size: 20,
                                        color: AppColors.kGrey,
                                      ),
                                      AppSpace.horizontal(5),
                                      Text(
                                        preparation.type!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.kBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
