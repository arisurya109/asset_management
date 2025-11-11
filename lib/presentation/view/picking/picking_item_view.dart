import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/core/widgets/app_space.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation_detail/preparation_detail_bloc.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text('Pick Item')),
      body: BlocBuilder<PreparationDetailBloc, PreparationDetailState>(
        builder: (context, state) {
          final item = state.preparationDetail;
          final isUom = context
              .read<MasterBloc>()
              .state
              .models
              ?.where((element) => element.id == item?.assetModelId)
              .firstOrNull
              ?.unit;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: isUom == 0
                  ? _pickItemConsumable(context, item, isLarge)
                  : _pickItemNonConsumable(context, item, isLarge),
            ),
          );
        },
      ),
    );
  }

  Widget _pickItemConsumable(
    BuildContext context,
    PreparationDetail? item,
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
                    _descriptionItem('Model', item?.assetModel, isLarge),
                    AppSpace.vertical(12),
                    _descriptionItem('Category', item?.assetCategory, isLarge),
                  ],
                ),
              ),
              AppSpace.horizontal(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _descriptionItem('Type', item?.assetType, isLarge),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Quantity',
                      '${item?.quantityPicked ?? 0} / ${item!.quantityTarget}',
                      isLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSpace.vertical(24),
        BlocBuilder<MasterBloc, MasterState>(
          builder: (context, state) {
            final locations = state.locations?.where((element) {
              final isRackOrBox =
                  element.locationType == 'RACK' ||
                  element.locationType == 'BOX';
              final startsWithNW =
                  element.name != null && element.name!.startsWith('NW');
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
              final isLocation = element.location == selectedLocationCons?.name;
              final isUom = element.uom == 0;
              return isLocation && isUom;
            }).toList();
            return AppDropDownSearch<AssetEntity>(
              title: '',
              items: asssets ?? [],
              hintText: 'Assets',
              borderRadius: 5,
              compareFn: (value, value1) => value.model == value1.model,
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
        ),
        AppSpace.vertical(32),
        AppButton(
          title: 'Pick',
          height: 40,
          fontSize: isLarge ? 16 : 14,
          width: double.maxFinite,
          onPressed: () {
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

              if (qty + (item.quantityPicked ?? 0) > item.quantityTarget!) {
                context.showSnackbar(
                  'Invalid quantity',
                  backgroundColor: AppColors.kRed,
                  fontSize: isLarge ? 14 : 12,
                );
              } else {
                // context.
              }
            }
          },
        ),
      ],
    );
  }

  Widget _pickItemNonConsumable(
    BuildContext context,
    PreparationDetail? item,
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
                    _descriptionItem('Model', item?.assetModel, isLarge),
                    AppSpace.vertical(12),
                    _descriptionItem('Category', item?.assetCategory, isLarge),
                    AppSpace.vertical(12),
                    BlocBuilder<AssetBloc, AssetState>(
                      builder: (context, state) {
                        final filteredAssets = state.assets?.where((e) {
                          return e.model == item?.assetModel &&
                              e.status == 'READY' &&
                              e.conditions == 'NEW';
                        }).toList();

                        final locationsList =
                            context.read<MasterBloc>().state.locations!.where((
                                element,
                              ) {
                                final isRackOrBox =
                                    element.locationType == 'RACK' ||
                                    element.locationType == 'BOX';
                                final startsWithNW =
                                    element.name != null &&
                                    element.name!.startsWith('NW');
                                return isRackOrBox && startsWithNW;
                              }).toList()
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
                    _descriptionItem('Brand', item?.assetBrand, isLarge),
                    AppSpace.vertical(12),
                    _descriptionItem('Type', item?.assetType, isLarge),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Quantity',
                      '${item?.quantityPicked ?? 0} / ${item?.quantityTarget}',
                      isLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSpace.vertical(24),
        Column(
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
              controller: locationC,
              noTitle: true,
            ),
            AppSpace.vertical(32),
            AppButton(
              title: 'Pick',
              width: context.deviceWidth,
              onPressed: () {},
              height: 40,
              fontSize: isLarge ? 15 : 14,
            ),
          ],
        ),
      ],
    );
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
