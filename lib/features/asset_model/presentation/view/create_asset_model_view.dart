// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/core/widgets/app_radio_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../asset_brand/asset_brand_export.dart';
import '../../../asset_category/asset_category_export.dart';
import '../../../asset_type/asset_type_export.dart';
import '../../asset_model_export.dart';

class CreateAssetModelView extends StatefulWidget {
  const CreateAssetModelView({super.key});

  @override
  State<CreateAssetModelView> createState() => _CreateAssetModelViewState();
}

class _CreateAssetModelViewState extends State<CreateAssetModelView> {
  late TextEditingController nameC;
  AssetType? assetType;
  AssetBrand? assetBrand;
  AssetCategory? assetCategory;

  List<Map<String, dynamic>> option = [
    {'label': 'Yes', 'value': 1},
    {'label': 'No', 'value': 0},
  ];
  List<Map<String, dynamic>> optionQty = [
    {'label': 'Unit', 'value': 1},
    {'label': 'Pcs', 'value': 0},
  ];

  int? isSerialNumber;
  int? isQty;
  int? isConsumable;

  @override
  void initState() {
    nameC = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Asset Model'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              BlocBuilder<AssetTypeBloc, AssetTypeState>(
                builder: (context, state) {
                  return AppDropDownSearch<AssetType>(
                    selectedItem: assetType,
                    hintText: 'Selected Type',
                    title: 'Type',
                    items: state.types ?? [],
                    onChanged: (value) => setState(() {
                      assetType = value;
                    }),
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value.name!,
                  );
                },
              ),
              AppSpace.vertical(12),
              BlocBuilder<AssetCategoryBloc, AssetCategoryState>(
                builder: (context, state) {
                  return AppDropDownSearch<AssetCategory>(
                    selectedItem: assetCategory,
                    hintText: 'Selected Category',
                    title: 'Category',
                    items: state.category ?? [],
                    onChanged: (value) => setState(() {
                      assetCategory = value;
                    }),
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value.name!,
                  );
                },
              ),
              AppSpace.vertical(12),
              BlocBuilder<AssetBrandBloc, AssetBrandState>(
                builder: (context, state) {
                  return AppDropDownSearch<AssetBrand>(
                    selectedItem: assetBrand,
                    hintText: 'Selected Brand',
                    title: 'Brand',
                    items: state.brands ?? [],
                    onChanged: (value) => setState(() {
                      assetBrand = value;
                    }),
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value.name!,
                  );
                },
              ),

              AppSpace.vertical(12),
              AppTextField(
                controller: nameC,
                title: 'Name',
                hintText: 'Example : Optiplex 7010',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),

              AppSpace.vertical(12),
              AppRadioListOption(
                options: optionQty,
                groupValue: isQty,
                title: 'Quantity',
                onChanged: (value) => setState(() {
                  isQty = value;
                }),
              ),
              AppSpace.vertical(4),
              AppRadioListOption(
                options: option,
                groupValue: isSerialNumber,
                title: 'Serial Number',
                onChanged: (value) => setState(() {
                  isSerialNumber = value;
                }),
              ),
              AppSpace.vertical(4),
              AppRadioListOption(
                options: option,
                groupValue: isConsumable,
                title: 'Consumable',
                onChanged: (value) => setState(() {
                  isConsumable = value;
                }),
              ),
              AppSpace.vertical(16),
              BlocConsumer<AssetModelBloc, AssetModelState>(
                listener: (context, state) {
                  if (state.status == StatusAssetModel.failed) {
                    context.showSnackbar(
                      state.message!,
                      backgroundColor: AppColors.kRed,
                    );
                  }

                  if (state.status == StatusAssetModel.success) {
                    context.showSnackbar(
                      state.message ??
                          'Successfully create ${nameC.value.text.trim().toUpperCase()}',
                    );

                    setState(() {
                      nameC.clear();
                      isQty = null;
                      isSerialNumber = null;
                      isConsumable = null;
                    });
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusAssetModel.loading
                        ? 'Loading...'
                        : 'CREATE',
                    onPressed: state.status == StatusAssetModel.loading
                        ? null
                        : () => context.read<AssetModelBloc>().add(
                            OnCreateAssetModel(
                              AssetModel(
                                name: nameC.value.text.trim().toUpperCase(),
                                brandId: assetBrand?.id,
                                categoryId: assetCategory?.id,
                                typeId: assetType?.id,
                                hasSerial: isSerialNumber,
                                isConsumable: isConsumable,
                                unit: isQty,
                              ),
                            ),
                          ),
                    width: double.maxFinite,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
