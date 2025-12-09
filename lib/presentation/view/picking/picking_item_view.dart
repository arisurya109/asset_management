import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/entities/preparation_detail/preparation_detail.dart';
import 'package:asset_management/domain/entities/preparation_item/preparation_item.dart';
import 'package:asset_management/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/bloc/picking/picking_bloc.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickingItemView extends StatefulWidget {
  const PickingItemView({super.key});

  @override
  State<PickingItemView> createState() => _PickingItemViewState();
}

class _PickingItemViewState extends State<PickingItemView> {
  late TextEditingController locationC;
  late TextEditingController quantityC;
  late TextEditingController assetCodeC;

  Location? selectedLocationCons;
  AssetEntity? selectedAssetCons;

  @override
  void initState() {
    locationC = TextEditingController();
    quantityC = TextEditingController();
    assetCodeC = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePickingItem(),
      mobileMScaffold: _mobilePickingItem(isLarge: false),
    );
  }

  Widget _mobilePickingItem({bool isLarge = true}) {
    return BlocBuilder<PickingBloc, PickingState>(
      builder: (context, state) {
        final preparationDetail = state.preparationDetail;

        final items = state.itemsDetail;

        final isUom = context
            .read<MasterBloc>()
            .state
            .models
            ?.where((element) => element.id == preparationDetail?.assetModelId)
            .firstOrNull
            ?.unit;
        return Scaffold(
          appBar: AppBar(title: Text('Pick Item')),
          // bottomNavigationBar: BlocConsumer<PickingBloc, PickingState>(
          //   listener: (context, state) {
          //     if (state.status ==
          //         StatusPicking.failedUpdateStatusPreparationDetail) {
          //       context.showSnackbar(
          //         state.message ?? '',
          //         backgroundColor: AppColors.kRed,
          //       );
          //     }
          //     if (state.status == StatusPicking.updateStatusPreparationDetail) {
          //       context.showSnackbar(
          //         'Successfully locked asset',
          //         backgroundColor: AppColors.kBase,
          //       );
          //       context.pop();
          //     }
          //   },
          //   builder: (context, state) {
          //     if (state.status == StatusPicking.loading) {
          //       return SizedBox();
          //     }

          //     if (((preparationDetail?.quantityPicked ==
          //             preparationDetail?.quantityTarget) &&
          //         preparationDetail?.status == 'PROGRESS')) {
          //       return Padding(
          //         padding: EdgeInsets.all(12),
          //         child: BlocListener<PickingBloc, PickingState>(
          //           listenWhen: (previous, current) =>
          //               previous.status != current.status,
          //           listener: (context, state) {},
          //           child: AppButton(
          //             title: 'Completed',
          //             onPressed: () {
          //               context.showDialogConfirm(
          //                 fontSize: isLarge ? 15 : 14,
          //                 title: 'Are your sure completed item ?',
          //                 content:
          //                     'Model : ${preparationDetail?.assetModel}\nQuantity Pick : ${preparationDetail?.quantityPicked}\nQuantity Target : ${preparationDetail?.quantityTarget}',
          //                 onCancel: () => context.pop(),
          //                 onConfirm: () {
          //                   context.read<PickingBloc>().add(
          //                     OnUpdateStatusCompletedPreparationDetail(
          //                       preparationDetail!.id!,
          //                     ),
          //                   );
          //                   context.pop();
          //                 },
          //               );
          //             },
          //             fontSize: isLarge ? 16 : 14,
          //           ),
          //         ),
          //       );
          //     }
          //     return SizedBox();
          //   },
          // ),
          body: BlocConsumer<PickingBloc, PickingState>(
            listener: (context, state) {
              if (state.status == StatusPicking.failureInsertItem) {
                context.showSnackbar(
                  state.message ?? 'Failed pick asset',
                  backgroundColor: AppColors.kRed,
                );
              }
              if (state.status == StatusPicking.insertItem) {
                context.showSnackbar('Successfully pick asset');
              }
            },
            builder: (context, state) {
              if (state.status == StatusPicking.loading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.kBase),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: isUom == 0
                    ? _pickItemConsumable(
                        context,
                        preparationDetail,
                        items,
                        isLarge,
                      )
                    : _pickItemNonConsumable(
                        context,
                        preparationDetail,
                        items,
                        isLarge,
                      ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _pickItemConsumable(
    BuildContext context,
    PreparationDetail? preparationDetail,
    List<PreparationItem>? items,
    bool isLarge,
  ) {
    return Column(
      children: [
        SizedBox(
          width: context.deviceWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.deviceWidth / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _descriptionItem(
                      'Model',
                      preparationDetail?.assetModel,
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Category',
                      preparationDetail?.assetCategory,
                      isLarge,
                    ),
                  ],
                ),
              ),
              AppSpace.horizontal(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _descriptionItem(
                      'Type',
                      preparationDetail?.assetType,
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Quantity',
                      '${preparationDetail?.quantityPicked ?? 0} / ${preparationDetail!.quantityTarget}',
                      isLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSpace.vertical(24),
        preparationDetail.quantityPicked != preparationDetail.quantityTarget
            ? Column(
                children: [
                  BlocBuilder<MasterBloc, MasterState>(
                    builder: (context, state) {
                      final locations = state.locations?.where((element) {
                        final isRackOrBox =
                            element.locationType == 'RACK' ||
                            element.locationType == 'BOX';
                        final startsWithNW =
                            element.name != null &&
                            element.name!.startsWith('NW');
                        return isRackOrBox && startsWithNW;
                      }).toList();

                      return AppDropDownSearch<Location>(
                        title: '',
                        items: locations ?? [],
                        hintText: 'Locations',
                        borderRadius: 5,
                        compareFn: (value, value1) => value.name == value1.name,
                        selectedItem: selectedLocationCons,
                        itemAsString: (value) => value.name!,
                        fontSize: isLarge ? 14 : 12,
                        onChanged: (value) => setState(() {
                          selectedLocationCons = value;
                        }),
                      );
                    },
                  ),
                  AppSpace.vertical(16),
                  BlocBuilder<AssetBloc, AssetState>(
                    builder: (context, state) {
                      final asssets = state.assets?.where((element) {
                        final isLocation =
                            element.location == selectedLocationCons?.name;
                        final isUom = element.uom == 0;
                        return isLocation && isUom;
                      }).toList();
                      return AppDropDownSearch<AssetEntity>(
                        title: '',
                        items: asssets ?? [],
                        hintText: 'Assets',
                        borderRadius: 5,
                        compareFn: (value, value1) =>
                            value.model == value1.model,
                        selectedItem: selectedAssetCons,
                        itemAsString: (value) => value.model!,
                        fontSize: isLarge ? 14 : 12,
                        onChanged: (value) => setState(() {
                          selectedAssetCons = value;
                        }),
                      );
                    },
                  ),
                  AppSpace.vertical(16),
                  AppTextField(
                    controller: quantityC,
                    hintText: 'Quantity',
                    fontSize: isLarge ? 14 : 12,
                    keyboardType: TextInputType.number,
                    noTitle: true,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (_) =>
                        _pickAssetConsumable(isLarge, preparationDetail),
                  ),
                  AppSpace.vertical(32),
                  BlocListener<PickingBloc, PickingState>(
                    listener: (context, state) {},
                    child: AppButton(
                      title: 'Pick',
                      height: 40,
                      fontSize: isLarge ? 16 : 14,
                      width: double.maxFinite,
                      onPressed: () =>
                          _pickAssetConsumable(isLarge, preparationDetail),
                    ),
                  ),
                ],
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: items?.length,
                  itemBuilder: (context, index) {
                    final item = items?[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.kBase),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item?.assetModel ?? '',
                                style: TextStyle(
                                  fontSize: isLarge ? 16 : 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              AppSpace.vertical(8),
                              Text(
                                'Category : ${item?.assetCategory ?? '-'}',
                                style: TextStyle(fontSize: isLarge ? 14 : 12),
                              ),
                              AppSpace.vertical(8),
                              Text(
                                'Quantity : ${item?.quantity ?? '-'}',
                                style: TextStyle(fontSize: isLarge ? 14 : 12),
                              ),
                            ],
                          ),
                          if (preparationDetail.status != 'COMPLETED')
                            Material(
                              color: AppColors.kRed,
                              borderRadius: BorderRadius.circular(3),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(3),
                                onTap: () {
                                  context.showDialogConfirm(
                                    fontSize: isLarge ? 15 : 14,
                                    title: 'Are your sure delete asset ?',
                                    content:
                                        'Model : ${item?.assetModel}\nQuantity : ${item?.quantity}\nCategory : ${item?.assetCategory}',
                                    onCancel: () => context.pop(),
                                    onConfirm: () {
                                      context.read<PickingBloc>().add(
                                        OnDeleteItemPicking(
                                          item!,
                                          preparationDetail,
                                        ),
                                      );
                                      context.pop();
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    size: 14,
                                    color: AppColors.kWhite,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  _pickAssetConsumable(bool isLarge, PreparationDetail preparationDetail) {
    final quantity = quantityC.value.text.trim();
    if (selectedLocationCons == null) {
      context.showSnackbar(
        'Location is empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (selectedAssetCons == null) {
      context.showSnackbar(
        'Assets is empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (!quantity.isNumber()) {
      context.showSnackbar(
        'Quantity is not valid',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else {
      final qty = int.parse(quantity);

      if (qty + (preparationDetail.quantityPicked ?? 0) >
          preparationDetail.quantityTarget!) {
        context.showSnackbar(
          'Invalid quantity',
          backgroundColor: AppColors.kRed,
          fontSize: isLarge ? 14 : 12,
        );
      } else {
        context.read<PickingBloc>().add(
          OnInsertItemPicking(
            PreparationItem(
              assetId: selectedAssetCons?.id,
              preparationId: preparationDetail.preparationId,
              preparationDetailId: preparationDetail.id,
              quantity: qty,
              locationId: selectedLocationCons?.id,
              assetModelId: selectedAssetCons?.assetModelId,
            ),
          ),
        );
        setState(() {
          selectedAssetCons = null;
          quantityC.clear();
          selectedLocationCons = null;
        });
      }
    }
  }

  Widget _pickItemNonConsumable(
    BuildContext context,
    PreparationDetail? preparationDetail,
    List<PreparationItem>? items,
    bool isLarge,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.deviceWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.deviceWidth / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _descriptionItem(
                      'Model',
                      preparationDetail?.assetModel,
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Category',
                      preparationDetail?.assetCategory,
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    if (preparationDetail?.status != 'READY')
                      BlocBuilder<AssetBloc, AssetState>(
                        builder: (context, state) {
                          final filteredAssets = state.assets?.where((e) {
                            return e.model == preparationDetail?.assetModel &&
                                e.status == 'READY' &&
                                e.conditions == 'NEW';
                          }).toList();

                          final locationsList =
                              context.read<MasterBloc>().state.locations!.where(
                                  (element) {
                                    final isRackOrBox =
                                        element.locationType == 'RACK' ||
                                        element.locationType == 'BOX';
                                    final startsWithNW =
                                        element.name != null &&
                                        element.name!.startsWith('NW');
                                    return isRackOrBox && startsWithNW;
                                  },
                                ).toList()
                                ..sort((a, b) => a.name!.compareTo(b.name!));

                          List<String> locationRecommendationAssets = [];

                          for (var location in locationsList) {
                            final hasMatchingAsset = filteredAssets!.any(
                              (asset) => asset.location == location.name,
                            );
                            if (hasMatchingAsset) {
                              locationRecommendationAssets.add(location.name!);
                            }
                          }

                          return _descriptionItem(
                            'Location',
                            locationRecommendationAssets
                                .take(2)
                                .map((loc) => '• $loc')
                                .join('\n'),
                            isLarge,
                          );
                        },
                      ),
                  ],
                ),
              ),
              AppSpace.horizontal(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _descriptionItem(
                      'Brand',
                      preparationDetail?.assetBrand,
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Type',
                      preparationDetail?.assetType,
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Quantity',
                      '${preparationDetail?.quantityPicked ?? 0} / ${preparationDetail?.quantityTarget}',
                      isLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSpace.vertical(24),

        preparationDetail?.quantityPicked != preparationDetail?.quantityTarget
            ? Expanded(
                child: Column(
                  children: [
                    AppTextField(
                      hintText: 'Location',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      title: 'Location',
                      fontSize: isLarge ? 14 : 12,
                      controller: locationC,
                      noTitle: true,
                    ),
                    AppSpace.vertical(16),
                    AppTextField(
                      hintText: 'Asset Code',
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.text,
                      title: 'Asset Code',
                      fontSize: isLarge ? 14 : 12,
                      controller: assetCodeC,
                      onSubmitted: (_) =>
                          _pickAssetNonConsumable(isLarge, preparationDetail!),
                      noTitle: true,
                    ),
                    AppSpace.vertical(32),
                    BlocConsumer<PickingBloc, PickingState>(
                      listener: (context, state) {
                        if (state.status == StatusPicking.loadingFindAsset) {
                          context.dialogLoading();
                        }

                        if (state.status == StatusPicking.successFindAsset) {
                          context.pop();
                          final asset = state.asset;
                          final locationId = context
                              .read<MasterBloc>()
                              .state
                              .locations
                              ?.firstWhere(
                                (element) => element.name == asset?.location,
                              );
                          context.showDialogConfirm(
                            fontSize: isLarge ? 15 : 14,
                            title: 'Are your sure pick asset ?',
                            content:
                                'Asset Code : ${asset?.assetCode}\nLocation : ${asset?.location}\nPO Number : ${asset?.purchaseOrder}\nStatus : ${asset?.status}\nCondition : ${asset?.conditions}',
                            onCancel: () => context.pop(),
                            onConfirm: () {
                              context.read<PickingBloc>().add(
                                OnInsertItemPicking(
                                  PreparationItem(
                                    assetId: asset?.id,
                                    preparationId: state.preparation?.id,
                                    preparationDetailId:
                                        state.preparationDetail?.id,
                                    quantity: 1,
                                    locationId: locationId?.id,
                                    assetModelId: asset?.assetModelId,
                                  ),
                                ),
                              );
                              setState(() {
                                assetCodeC.clear();
                                locationC.clear();
                              });
                              context.pop();
                            },
                          );
                        }

                        if (state.status == StatusPicking.insertItem) {
                          context.showSnackbar('Successfully pick assets');
                        }

                        if (state.status == StatusPicking.failureInsertItem) {
                          context.showSnackbar(
                            state.message ?? 'Failed pick assets',
                          );
                        }

                        if (state.status == StatusPicking.failureDeleteItem) {
                          context.showSnackbar(
                            state.message ?? 'Failed delete assets',
                          );
                        }

                        if (state.status == StatusPicking.deleteItem) {
                          context.showSnackbar(
                            state.message ?? 'Successfully delete assets',
                          );
                        }
                      },
                      builder: (context, state) {
                        return AppButton(
                          title: 'Pick',
                          width: context.deviceWidth,
                          onPressed:
                              state.status == StatusPicking.loadingFindAsset
                              ? null
                              : () => _pickAssetNonConsumable(
                                  isLarge,
                                  preparationDetail!,
                                ),
                          height: 40,
                          fontSize: isLarge ? 15 : 14,
                        );
                      },
                    ),
                  ],
                ),
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: items?.length,
                  itemBuilder: (context, index) {
                    final item = items?[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.kBase),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item?.assetCode ?? '',
                                style: TextStyle(
                                  fontSize: isLarge ? 16 : 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              AppSpace.vertical(8),
                              Text(
                                'Conditions : ${item?.conditions ?? '-'}',
                                style: TextStyle(fontSize: isLarge ? 14 : 12),
                              ),
                              AppSpace.vertical(8),
                              Text(
                                'Status : ${item?.status ?? '-'}',
                                style: TextStyle(fontSize: isLarge ? 14 : 12),
                              ),
                              AppSpace.vertical(8),
                              Text(
                                'PO : ${item?.purchaseOrder ?? '-'}',
                                style: TextStyle(fontSize: isLarge ? 14 : 12),
                              ),
                            ],
                          ),
                          if (preparationDetail?.status != 'COMPLETED')
                            Material(
                              color: AppColors.kRed,
                              borderRadius: BorderRadius.circular(3),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(3),
                                onTap: () {
                                  context.showDialogConfirm(
                                    fontSize: isLarge ? 15 : 14,
                                    title: 'Are your sure delete asset ?',
                                    content:
                                        'Asset Code : ${item?.assetCode ?? '-'}\nModel : ${item?.assetModel}\nQuantity : ${item?.quantity}\nStatus : ${item?.status}\nCondition : ${item?.conditions}',
                                    onCancel: () => context.pop(),
                                    onConfirm: () {
                                      context.read<PickingBloc>().add(
                                        OnDeleteItemPicking(
                                          item!,
                                          preparationDetail!,
                                        ),
                                      );
                                      context.pop();
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    size: 14,
                                    color: AppColors.kWhite,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  _pickAssetNonConsumable(bool isLarge, PreparationDetail preparationDetail) {
    final location = locationC.value.text.trim();
    final assetCode = assetCodeC.value.text.trim();

    if (!location.isFilled()) {
      context.showSnackbar(
        'Location cannot empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (!assetCode.isFilled()) {
      context.showSnackbar(
        'Asset Code cannot empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else {
      context.read<PickingBloc>().add(
        OnFindAssetByAssetCodeAndLocation(assetCode, location),
      );
      setState(() {
        locationC.clear();
        assetCodeC.clear();
      });
    }
  }

  Widget _descriptionItem(String title, String? value, bool isLarge) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isLarge ? 14 : 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppSpace.vertical(3),
        Text(
          value == null
              ? '-'
              : value.isEmpty
              ? '-'
              : value,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isLarge ? 14 : 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
