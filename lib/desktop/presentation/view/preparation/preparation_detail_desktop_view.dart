import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/utils/colors.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_detail_desktop/preparation_detail_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_text_field_search_desktop.dart';
import 'package:asset_management/desktop/presentation/cubit/datas/datas_desktop_cubit.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreparationDetailDesktopView extends StatefulWidget {
  const PreparationDetailDesktopView({super.key});

  @override
  State<PreparationDetailDesktopView> createState() =>
      _PreparationDetailDesktopViewState();
}

class _PreparationDetailDesktopViewState
    extends State<PreparationDetailDesktopView> {
  late TextEditingController _codeC;
  late TextEditingController _destinationC;
  late TextEditingController _statusC;
  late TextEditingController _notesC;

  AssetType? _selectedType;
  AssetCategory? _selectedCategory;
  AssetModel? _selectedModel;

  @override
  void initState() {
    _codeC = TextEditingController();
    _destinationC = TextEditingController();
    _statusC = TextEditingController();
    _notesC = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeaderDesktop(
          title: 'Preparation Detail',
          hasPermission: false,
          withBackButton: true,
        ),
        AppBodyDesktop(
          body:
              BlocBuilder<
                PreparationDetailDesktopBloc,
                PreparationDetailDesktopState
              >(
                builder: (context, state) {
                  final preparation = state.preparationDetails?.preparation;
                  _codeC = TextEditingController(text: preparation?.code);
                  _destinationC = TextEditingController(
                    text: preparation?.destination,
                  );
                  _statusC = TextEditingController(text: preparation?.status);
                  _notesC = TextEditingController(text: preparation?.notes);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),

                        width: context.deviceWidth,
                        decoration: BoxDecoration(
                          color: AppColors.kWhite,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Code',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                AppSpace.vertical(5),
                                AppTextFieldSearchDesktop(
                                  width: (context.deviceWidth - 272) / 5,
                                  controller: _codeC,
                                  enabled: false,
                                ),
                              ],
                            ),
                            AppSpace.horizontal(12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Destination',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                AppSpace.vertical(5),
                                AppTextFieldSearchDesktop(
                                  width: (context.deviceWidth - 272) / 4.5,
                                  controller: _destinationC,
                                  enabled: false,
                                ),
                              ],
                            ),
                            AppSpace.horizontal(12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Status',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                AppSpace.vertical(5),
                                AppTextFieldSearchDesktop(
                                  width: (context.deviceWidth - 272) / 5,
                                  controller: _statusC,
                                  enabled: false,
                                ),
                              ],
                            ),
                            AppSpace.horizontal(12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Notes',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                AppSpace.vertical(5),
                                AppTextFieldSearchDesktop(
                                  width: (context.deviceWidth - 272) / 3,
                                  controller: _notesC,
                                  enabled: false,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      AppSpace.vertical(12),
                      Container(
                        width: 350,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.kWhite,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppDropDownSearch<AssetType>(
                              title: '',
                              hintText: 'Selected Type',
                              onFind: (String filter) async => await context
                                  .read<DatasDesktopCubit>()
                                  .getAssetType(),
                              borderRadius: 4,
                              compareFn: (value, value1) =>
                                  value.name == value1.name,
                              itemAsString: (value) => value.name!,
                              fontSize: 12,
                              enabled: true,
                              onChanged: (value) {
                                if (_selectedType != value) {
                                  setState(() {
                                    _selectedType = value;
                                    _selectedCategory = null;
                                    _selectedModel = null;
                                  });
                                }
                              },
                              showSearchBox: true,
                              selectedItem: _selectedType,
                            ),
                            AppSpace.vertical(16),
                            AppDropDownSearch<AssetCategory>(
                              title: '',
                              hintText: 'Selected Category',
                              onFind: _selectedType == null
                                  ? null
                                  : (String filter) async => await context
                                        .read<DatasDesktopCubit>()
                                        .getAssetCategory(_selectedType!.name!),
                              borderRadius: 4,
                              compareFn: (value, value1) =>
                                  value.name == value1.name,
                              itemAsString: (value) => value.name!,
                              fontSize: 12,
                              enabled: true,
                              onChanged: (value) {
                                if (_selectedCategory != value) {
                                  setState(() {
                                    _selectedCategory = value;
                                    _selectedModel = null;
                                  });
                                }
                              },
                              showSearchBox: true,
                              selectedItem: _selectedCategory,
                            ),
                            AppSpace.vertical(16),
                            AppDropDownSearch<AssetModel>(
                              title: '',
                              hintText: 'Selected Model',
                              onFind:
                                  _selectedType != null &&
                                      _selectedCategory != null
                                  ? (String filter) async => await context
                                        .read<DatasDesktopCubit>()
                                        .getAssetModels(
                                          _selectedType!.name!,
                                          _selectedCategory!.name!,
                                        )
                                  : null,
                              borderRadius: 4,
                              compareFn: (value, value1) =>
                                  value.name == value1.name,
                              itemAsString: (value) => value.name!,
                              fontSize: 12,
                              enabled: true,
                              onChanged: (value) => setState(() {
                                _selectedModel = value;
                              }),
                              showSearchBox: true,
                              selectedItem: _selectedModel,
                            ),
                            // AppDropDownSearch<String>(
                            //   title: '',
                            //   hintText: 'Selected Status',
                            //   items: listStatus,
                            //   borderRadius: 4,
                            //   compareFn: (value, value1) => value == value1,
                            //   itemAsString: (value) => value,
                            //   fontSize: 12,
                            //   enabled: true,
                            //   onChanged: (value) => setState(() {
                            //     selectedStatus = value;
                            //     fnAssetCode.requestFocus();
                            //   }),
                            //   showSearchBox: true,
                            //   selectedItem: selectedStatus,
                            // ),
                            // AppSpace.vertical(16),
                            // AppTextFieldSearchDesktop(
                            //   width: 350,
                            //   height: 35,
                            //   hintText: 'Remarks',
                            //   focusNode: fnRemarks,
                            //   controller: remarksC,
                            //   suffixIcon: remarksC.value.text.isFilled()
                            //       ? IconButton(
                            //           icon: const Icon(Icons.clear, size: 16),
                            //           onPressed: () {
                            //             setState(() {
                            //               remarksC.clear();
                            //             });
                            //           },
                            //         )
                            //       : Icon(
                            //           Icons.minimize,
                            //           color: Colors.transparent,
                            //         ),
                            //   onChanged: (value) {
                            //     if (value.isEmpty) {
                            //       setState(() {
                            //         remarksC.clear();
                            //       });
                            //     }
                            //   },
                            //   onSubmitted: (p0) => setState(() {
                            //     fnAssetCode.requestFocus();
                            //   }),
                            // ),
                            // AppSpace.vertical(16),

                            // AppTextFieldSearchDesktop(
                            //   width: 350,
                            //   height: 35,
                            //   hintText: 'Asset Code',
                            //   focusNode: fnAssetCode,
                            //   controller: assetCodeC,
                            //   suffixIcon: _isSearchActiveAsset
                            //       ? IconButton(
                            //           icon: const Icon(Icons.clear, size: 16),
                            //           onPressed: () {
                            //             setState(() {
                            //               assetCodeC.clear();
                            //               _isSearchActiveAsset = false;
                            //               _clear();
                            //             });
                            //           },
                            //         )
                            //       : null,
                            //   withSearchIcon: true,
                            //   onChanged: (value) {
                            //     if (value.isEmpty && _isSearchActiveAsset) {
                            //       setState(() {
                            //         _isSearchActiveAsset = false;
                            //         _clear();
                            //       });
                            //     }
                            //   },
                            //   onSubmitted: (value) async {
                            //     await _findAsset(value);
                            //   },
                            // ),
                            // AppSpace.vertical(24),
                            // AppButton(
                            //   height: 35,
                            //   onPressed: () async {
                            //     if (assetCodeC.value.text.isFilled()) {
                            //       await _findAsset(assetCodeC.value.text);
                            //     }
                            //   },
                            //   fontSize: 11,
                            //   title: 'Search',
                            //   width: context.deviceWidth,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
        ),
      ],
    );
  }
}
