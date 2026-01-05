// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/core/widgets/app_radio_list.dart';
import 'package:asset_management/domain/entities/master/asset_brand.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:asset_management/mobile/presentation/bloc/model/model_bloc.dart';
import 'package:asset_management/mobile/presentation/cubit/datas_cubit.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';

class CreateAssetModelView extends StatefulWidget {
  const CreateAssetModelView({super.key});

  @override
  State<CreateAssetModelView> createState() => _CreateAssetModelViewState();
}

class _CreateAssetModelViewState extends State<CreateAssetModelView> {
  late TextEditingController nameC;
  late FocusNode nameFn;
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
    nameFn = FocusNode();
    nameFn.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    nameFn.dispose();
    super.dispose();
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
      body: BlocBuilder<DatasCubit, void>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  AppTextField(
                    controller: nameC,
                    title: 'Name',
                    hintText: 'Example : Optiplex 7010',
                    focusNode: nameFn,
                    keyboardType: TextInputType.text,
                    fontSize: isLarge ? 14 : 12,
                    textInputAction: TextInputAction.next,
                  ),
                  AppSpace.vertical(12),
                  AppDropDownSearch<AssetType>(
                    fontSize: isLarge ? 14 : 12,
                    title: 'Type',
                    hintText: 'Selected Type',
                    borderRadius: 4,
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value.name!,
                    selectedItem: assetType,
                    onFind: (_) async =>
                        await context.read<DatasCubit>().getAssetTypes(),
                    onChanged: (value) => setState(() {
                      assetType = value;
                    }),
                  ),
                  AppSpace.vertical(12),
                  AppDropDownSearch<AssetBrand>(
                    fontSize: isLarge ? 14 : 12,
                    title: 'Brand',
                    hintText: 'Selected Brand',
                    borderRadius: 4,
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value.name!,
                    selectedItem: assetBrand,
                    onFind: (_) async =>
                        await context.read<DatasCubit>().getAssetBrands(),
                    onChanged: (value) => setState(() {
                      assetBrand = value;
                    }),
                  ),
                  AppSpace.vertical(12),
                  AppDropDownSearch<AssetCategory>(
                    fontSize: isLarge ? 14 : 12,
                    title: 'Category',
                    hintText: 'Selected Category',
                    borderRadius: 4,
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value.name!,
                    selectedItem: assetCategory,
                    onFind: (_) async =>
                        await context.read<DatasCubit>().getAssetCategories(),
                    onChanged: (value) => setState(() {
                      assetCategory = value;
                    }),
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
                  BlocConsumer<ModelBloc, ModelState>(
                    listener: (context, state) {
                      if (state.status == StatusModel.failure) {
                        context.showSnackbar(
                          state.message!,
                          backgroundColor: AppColors.kRed,
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

                      if (state.status == StatusModel.success) {
                        context.showSnackbar(
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
                        title: state.status == StatusModel.loading
                            ? 'Loading...'
                            : 'Create',
                        fontSize: isLarge ? 16 : 14,
                        onPressed: state.status == StatusModel.loading
                            ? null
                            : () => _onSubmit(isLarge),
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

  _onSubmit(bool isLarge) {
    final name = nameC.value.text.trim().toUpperCase();
    final type = assetType;
    final brand = assetBrand;
    final category = assetCategory;
    if (!name.isFilled()) {
      context.showSnackbar(
        'Name cannot be empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (type == null) {
      context.showSnackbar(
        'Type cannot be empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (brand == null) {
      context.showSnackbar(
        'Brand cannot be empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (category == null) {
      context.showSnackbar(
        'Category cannot be empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (isQty == null) {
      context.showSnackbar(
        'Quantity cannot be empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (isSerialNumber == null) {
      context.showSnackbar(
        'Serial Number cannot be empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (isConsumable == null) {
      context.showSnackbar(
        'Consumable cannot be empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else {
      context.showDialogConfirm(
        title: 'Are your sure create new model ?',
        content:
            '''Name : $name
Type : ${type.name}
Brand : ${brand.name}
Category : ${category.name}
Quantity : ${isQty == 1 ? 'Unit' : 'Pcs'}
Serial Number : ${isSerialNumber == 1 ? 'Yes' : 'No'}
Consumable : ${isConsumable == 1 ? 'Yes' : 'No'}''',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        fontSize: isLarge ? 14 : 12,
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<ModelBloc>().add(
            OnCreateModel(
              AssetModel(
                name: name,
                brandId: assetBrand?.id,
                categoryId: assetCategory?.id,
                typeId: assetType?.id,
                hasSerial: isSerialNumber,
                isConsumable: isConsumable,
                unit: isQty,
              ),
            ),
          );
          Navigator.pop(context);
        },
      );
    }
  }
}
