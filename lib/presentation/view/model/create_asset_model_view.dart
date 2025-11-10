// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/core/widgets/app_radio_list.dart';
import 'package:asset_management/domain/entities/master/asset_brand.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';

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
    return ResponsiveLayout(
      mobileLScaffold: _mobileCreateModel(),
      mobileMScaffold: _mobileCreateModel(isLarge: false),
    );
  }

  Widget _mobileCreateModel({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Asset Model'), elevation: 0),
      body: BlocBuilder<MasterBloc, MasterState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  AppDropDownSearch<AssetType>(
                    selectedItem: assetType,
                    hintText: 'Selected Type',
                    title: 'Type',
                    fontSize: isLarge ? 14 : 12,
                    items: state.types ?? [],
                    onChanged: (value) => setState(() {
                      assetType = value;
                    }),
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value.name!,
                  ),
                  AppSpace.vertical(12),
                  AppDropDownSearch<AssetCategory>(
                    selectedItem: assetCategory,
                    hintText: 'Selected Category',
                    title: 'Category',
                    fontSize: isLarge ? 14 : 12,
                    items: state.categories ?? [],
                    onChanged: (value) => setState(() {
                      assetCategory = value;
                    }),
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value.name!,
                  ),
                  AppSpace.vertical(12),
                  AppDropDownSearch<AssetBrand>(
                    selectedItem: assetBrand,
                    hintText: 'Selected Brand',
                    title: 'Brand',
                    fontSize: isLarge ? 14 : 12,
                    items: state.brands ?? [],
                    onChanged: (value) => setState(() {
                      assetBrand = value;
                    }),
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value.name!,
                  ),
                  AppSpace.vertical(12),
                  AppTextField(
                    controller: nameC,
                    title: 'Name',
                    hintText: 'Example : Optiplex 7010',
                    keyboardType: TextInputType.text,
                    fontSize: isLarge ? 14 : 12,
                    textInputAction: TextInputAction.next,
                  ),
                  AppSpace.vertical(12),
                  AppRadioListOption(
                    options: optionQty,
                    groupValue: isQty,
                    title: 'Quantity',
                    fontSize: isLarge ? 14 : 12,
                    onChanged: (value) => setState(() {
                      isQty = value;
                    }),
                  ),
                  AppSpace.vertical(4),
                  AppRadioListOption(
                    options: option,
                    groupValue: isSerialNumber,
                    fontSize: isLarge ? 14 : 12,
                    title: 'Serial Number',
                    onChanged: (value) => setState(() {
                      isSerialNumber = value;
                    }),
                  ),
                  AppSpace.vertical(4),
                  AppRadioListOption(
                    options: option,
                    groupValue: isConsumable,
                    fontSize: isLarge ? 14 : 12,
                    title: 'Consumable',
                    onChanged: (value) => setState(() {
                      isConsumable = value;
                    }),
                  ),
                  AppSpace.vertical(16),
                  BlocConsumer<MasterBloc, MasterState>(
                    listener: (context, state) {
                      if (state.status == StatusMaster.failed) {
                        context.showSnackbar(
                          state.message!,
                          backgroundColor: AppColors.kRed,
                          fontSize: isLarge ? 14 : 12,
                        );
                      }

                      if (state.status == StatusMaster.success) {
                        context.showSnackbar(
                          state.message ??
                              'Successfully create ${nameC.value.text.trim().toUpperCase()}',
                          fontSize: isLarge ? 14 : 12,
                        );

                        setState(() {
                          assetType = null;
                          assetCategory = null;
                          assetBrand = null;
                          nameC.clear();
                          isQty = null;
                          isSerialNumber = null;
                          isConsumable = null;
                        });
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                        title: state.status == StatusMaster.loading
                            ? 'Loading...'
                            : 'CREATE',
                        fontSize: isLarge ? 16 : 14,
                        onPressed: state.status == StatusMaster.loading
                            ? null
                            : () => context.read<MasterBloc>().add(
                                OnCreateModelEvent(
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
          );
        },
      ),
    );
  }
}
