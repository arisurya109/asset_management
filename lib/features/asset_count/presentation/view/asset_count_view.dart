import '../../../../core/extension/context_ext.dart';
import 'create_asset_count_view.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widgets/app_space.dart';
import '../bloc/asset_count_detail/asset_count_detail_bloc.dart';
import '../bloc/asset_count/asset_count_bloc.dart';
import 'asset_count_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetCountView extends StatefulWidget {
  const AssetCountView({super.key});

  @override
  State<AssetCountView> createState() => _AssetCountViewState();
}

class _AssetCountViewState extends State<AssetCountView> {
  @override
  void initState() {
    super.initState();
    context.read<AssetCountBloc>().add(OnGetAllAssetCount());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASSET COUNT'),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateAssetCountView()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),

        child: BlocBuilder<AssetCountBloc, AssetCountState>(
          builder: (context, state) {
            if (state.status == StatusAssetCount.loading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.kBase),
              );
            }

            if (state.assetsCount == null || state.assetsCount!.isEmpty) {
              return Center(
                child: Text(state.message ?? 'Asset count is still empty'),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.assetsCount!.length,
                itemBuilder: (context, index) {
                  final assetCount = state.assetsCount![index];
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
                          if (assetCount.status == StatusCount.CREATED) {
                            context.showDialogConfirm(
                              title: 'Start Counting',
                              content:
                                  'Do you want to start counting your assets?',
                              onCancelText: 'No',
                              onCancel: () => Navigator.pop(context),
                              onConfirmText: 'Ya',
                              onConfirm: () {
                                context.read<AssetCountBloc>().add(
                                  OnUpdateStatusAssetCount(
                                    assetCount.id!,
                                    StatusCount.ONPROCESS,
                                  ),
                                );
                                Navigator.pop(context);
                                context.read<AssetCountDetailBloc>().add(
                                  OnGetAllAssetCountDetailById(assetCount.id!),
                                );
                                context.read<AssetCountBloc>().add(
                                  OnSelectedAssetCountDetail(assetCount.id!),
                                );
                                Future.delayed(Duration(seconds: 5));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AssetCountDetailView(),
                                  ),
                                );
                              },
                            );
                          } else {
                            context.read<AssetCountDetailBloc>().add(
                              OnGetAllAssetCountDetailById(assetCount.id!),
                            );
                            context.read<AssetCountBloc>().add(
                              OnSelectedAssetCountDetail(assetCount.id!),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AssetCountDetailView(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    assetCount.title!,
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
                                          assetCount.status ==
                                              StatusCount.CREATED
                                          ? Color(0XFFDFE3E8)
                                          : assetCount.status ==
                                                StatusCount.ONPROCESS
                                          ? AppColors.kOrangeLight
                                          : AppColors.kGreenLight,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      assetCount.status == StatusCount.CREATED
                                          ? 'CREATED'
                                          : assetCount.status ==
                                                StatusCount.ONPROCESS
                                          ? 'ON PROCESS'
                                          : 'COMPLETED',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            assetCount.status ==
                                                StatusCount.CREATED
                                            ? AppColors.kBlack
                                            : assetCount.status ==
                                                  StatusCount.ONPROCESS
                                            ? AppColors.kOrangeDark
                                            : AppColors.kGreenDark,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              AppSpace.vertical(8),

                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.kBackground,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      assetCount.countCode!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.kBlack,
                                      ),
                                    ),
                                    Text('|'),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_sharp,
                                          size: 20,
                                          color: AppColors.kGrey,
                                        ),
                                        AppSpace.horizontal(5),
                                        Text(
                                          DateFormat(
                                            'd-MM-y',
                                          ).format(assetCount.countDate!),
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
              // return ListView.builder(
              //   padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              //   itemCount: state.assetsCount!.length,
              //   itemBuilder: (context, index) {
              //     final assetCount = state.assetsCount![index];
              //     return Padding(
              //       padding: const EdgeInsets.only(bottom: 5),
              //       child: ListTile(
              //         contentPadding: EdgeInsets.symmetric(horizontal: 8),
              //         onTap: () {
              //           if (assetCount.status == StatusCount.CREATED) {
              //             context.showDialogConfirm(
              //               title: 'Start Counting',
              //               content: 'Do you want to start counting your assets?',
              //               onCancelText: 'No',
              //               onCancel: () => Navigator.pop(context),
              //               onConfirmText: 'Ya',
              //               onConfirm: () {
              //                 context.read<AssetCountBloc>().add(
              //                   OnUpdateStatusAssetCount(
              //                     assetCount.id!,
              //                     StatusCount.ONPROCESS,
              //                   ),
              //                 );
              //                 Navigator.pop(context);
              //                 context.read<AssetCountDetailBloc>().add(
              //                   OnGetAllAssetCountDetailById(assetCount.id!),
              //                 );
              //                 context.read<AssetCountBloc>().add(
              //                   OnSelectedAssetCountDetail(assetCount.id!),
              //                 );
              //                 Future.delayed(Duration(seconds: 5));
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                     builder: (_) => AssetCountDetailView(),
              //                   ),
              //                 );
              //               },
              //             );
              //           } else {
              //             context.read<AssetCountDetailBloc>().add(
              //               OnGetAllAssetCountDetailById(assetCount.id!),
              //             );
              //             context.read<AssetCountBloc>().add(
              //               OnSelectedAssetCountDetail(assetCount.id!),
              //             );
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (_) => AssetCountDetailView(),
              //               ),
              //             );
              //           }
              //         },
              //         title: Text(assetCount.title!),
              //         leading: CircleAvatar(
              //           radius: 18,
              //           backgroundColor: AppColors.kBase,
              //           child: Text(
              //             '${index + 1}',
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.w600,
              //             ),
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // );
            }
          },
        ),
      ),
    );
  }
}
