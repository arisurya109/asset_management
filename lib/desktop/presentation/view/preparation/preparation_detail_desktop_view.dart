import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/core/widgets/app_toast.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_desktop/preparation_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_detail_desktop/preparation_detail_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_table_fixed.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_new_table.dart';
import 'package:asset_management/desktop/presentation/components/app_text_field_search_desktop.dart';
import 'package:asset_management/desktop/presentation/cubit/datas/datas_desktop_cubit.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  late TextEditingController _purchaseOrderC;
  late TextEditingController _quantityC;
  late FocusNode _purchaseOrderFn;
  late FocusNode _quantityFn;

  @override
  void initState() {
    _codeC = TextEditingController();
    _destinationC = TextEditingController();
    _statusC = TextEditingController();
    _notesC = TextEditingController();
    _purchaseOrderC = TextEditingController();
    _quantityC = TextEditingController();
    _purchaseOrderFn = FocusNode();
    _quantityFn = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _codeC.dispose();
    _destinationC.dispose();
    _statusC.dispose();
    _notesC.dispose();
    _purchaseOrderC.dispose();
    _quantityC.dispose();
    _purchaseOrderFn.dispose();
    _quantityFn.dispose();
    super.dispose();
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
                  final preparationDetails =
                      state.preparationDetails?.preparationDetail;
                  _codeC = TextEditingController(text: preparation?.code);
                  _destinationC = TextEditingController(
                    text: preparation?.destination,
                  );
                  _statusC = TextEditingController(text: preparation?.status);
                  _notesC = TextEditingController(text: preparation?.notes);

                  final datasTable = <Map<String, String>>[];

                  state.preparationDetails?.preparationDetail?.asMap().forEach((
                    index,
                    e,
                  ) {
                    for (var item in e.items!) {
                      datasTable.add({
                        'id': e.id.toString(),
                        'no': (datasTable.length + 1).toString(),
                        'asset_code': item.assetCode ?? '',
                        'category': e.category ?? '',
                        'model': e.model ?? '',
                        'status': item.status ?? '',
                        'location': item.location ?? '',
                        'quantity': e.isConsumable == 1
                            ? e.quantity.toString()
                            : '1',
                      });
                    }
                  });
                  [];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
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
                      if (preparation?.status == 'DRAFT')
                        _statusPreparationDraft(
                          context,
                          preparation,
                          preparationDetails,
                        ),
                      if (preparation?.status != 'DRAFT')
                        Expanded(
                          child: AppTableFixed(
                            datas: datasTable,
                            // minWidth: 1100,
                            columns: [
                              AppDataTableColumn(
                                label: 'NO',
                                key: 'no',
                                width: 50,
                              ),
                              AppDataTableColumn(
                                label: 'ASSET CODE',
                                key: 'asset_code',
                                isExpanded: true,
                              ),
                              AppDataTableColumn(
                                label: 'CATEGORY',
                                key: 'category',
                                isExpanded: true,
                              ),
                              AppDataTableColumn(
                                label: 'MODEL',
                                key: 'model',
                                isExpanded: true,
                              ),
                              AppDataTableColumn(
                                label: 'STATUS',
                                key: 'status',
                              ),
                              AppDataTableColumn(
                                label: 'LOCATION',
                                key: 'location',
                              ),
                              AppDataTableColumn(
                                label: 'QUANTITY',
                                key: 'quantity',
                              ),
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

  Widget _statusPreparationDraft(
    BuildContext context,
    Preparation? preparation,
    List<PreparationDetail>? preparationDetails,
  ) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
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
                    Text(
                      'Selected Asset',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    AppSpace.vertical(12),
                    AppDropDownSearch<AssetType>(
                      title: '',
                      hintText: 'Selected Type',
                      onFind: (String filter) async => await context
                          .read<DatasDesktopCubit>()
                          .getAssetType(),
                      borderRadius: 4,
                      compareFn: (value, value1) => value.name == value1.name,
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
                      compareFn: (value, value1) => value.name == value1.name,
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
                      onFind: _selectedType != null && _selectedCategory != null
                          ? (String filter) async => await context
                                .read<DatasDesktopCubit>()
                                .getAssetModels(
                                  _selectedType!.name!,
                                  _selectedCategory!.name!,
                                )
                          : null,
                      borderRadius: 4,
                      compareFn: (value, value1) => value.name == value1.name,
                      itemAsString: (value) => value.name!,
                      fontSize: 12,
                      enabled: true,
                      onChanged: (value) {
                        setState(() {
                          _selectedModel = value;
                        });

                        if (_selectedModel != null) {
                          setState(() {
                            _purchaseOrderFn.requestFocus();
                          });
                        }
                      },
                      showSearchBox: true,
                      selectedItem: _selectedModel,
                    ),
                    AppSpace.vertical(16),
                    AppTextFieldSearchDesktop(
                      width: 350,
                      height: 35,
                      hintText: 'Purchase Order',
                      focusNode: _purchaseOrderFn,
                      controller: _purchaseOrderC,
                      suffixIcon: _purchaseOrderC.value.text.isFilled()
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 16),
                              onPressed: () {
                                setState(() {
                                  _purchaseOrderC.clear();
                                });
                              },
                            )
                          : Icon(Icons.minimize, color: Colors.transparent),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            _purchaseOrderC.clear();
                          });
                        }
                      },
                      onSubmitted: (p0) => setState(() {
                        _quantityFn.requestFocus();
                      }),
                    ),
                    AppSpace.vertical(16),
                    AppTextFieldSearchDesktop(
                      width: 350,
                      height: 35,
                      hintText: 'Quantity',
                      focusNode: _quantityFn,
                      controller: _quantityC,
                      suffixIcon: _quantityC.value.text.isFilled()
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 16),
                              onPressed: () {
                                setState(() {
                                  _quantityC.clear();
                                });
                              },
                            )
                          : Icon(Icons.minimize, color: Colors.transparent),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            _quantityC.clear();
                          });
                        }
                      },
                      onSubmitted: (_) => _add(preparation!.id!),
                    ),
                    AppSpace.vertical(24),
                    BlocConsumer<
                      PreparationDetailDesktopBloc,
                      PreparationDetailDesktopState
                    >(
                      listener: (context, state) {
                        if (state.status ==
                            StatusPreparationDetailDesktop.failure) {
                          context.pop();
                          AppToast.show(
                            context: context,
                            type: ToastType.error,
                            message: state.message!,
                          );
                          setState(() => _quantityC.clear());
                        }

                        if (state.status ==
                            StatusPreparationDetailDesktop.addSuccess) {
                          context.pop();
                          AppToast.show(
                            context: context,
                            type: ToastType.success,
                            message: state.message ?? '',
                          );
                          setState(() => _quantityC.clear());
                        }
                      },
                      builder: (context, state) {
                        return AppButton(
                          height: 35,
                          onPressed:
                              state.status ==
                                  StatusPreparationDetailDesktop.loading
                              ? null
                              : () => _add(preparation!.id!),
                          fontSize: 11,
                          title:
                              state.status ==
                                  StatusPreparationDetailDesktop.loading
                              ? 'Loading...'
                              : 'Add',
                          width: context.deviceWidth,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Spacer(),
              if (preparationDetails!.isNotEmpty)
                BlocListener<PreparationDesktopBloc, PreparationDesktopState>(
                  listener: (context, state) {
                    if (state.status == StatusPreparationDesktop.failure) {
                      context.pop();
                      AppToast.show(
                        context: context,
                        type: ToastType.error,
                        message: state.message!,
                      );
                    }

                    if (state.status == StatusPreparationDesktop.loaded) {
                      context.pop();
                      AppToast.show(
                        context: context,
                        type: ToastType.success,
                        message: state.message!,
                      );
                      context.read<PreparationDetailDesktopBloc>().add(
                        OnGetPreparationDetails(preparation!.id!),
                      );
                    }
                  },
                  child: AppButton(
                    height: 33,
                    width: 346,
                    fontSize: 12,
                    title: 'Assigned',
                    onPressed: () =>
                        _assigned(preparation!, preparationDetails),
                  ),
                ),
            ],
          ),
          AppSpace.horizontal(24),
          if (preparationDetails.isNotEmpty)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: preparationDetails.length,
                  itemBuilder: (context, index) {
                    final prepDetail = preparationDetails[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ExpansionTile(
                        // trailing: Text(prepDetail.category!),
                        leading: Text(
                          (index + 1).toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                        title: Text(
                          prepDetail.model!,
                          style: TextStyle(fontSize: 12),
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(color: AppColors.kBackground),
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: AppColors.kBackground),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        expandedAlignment: Alignment.center,
                        expandedCrossAxisAlignment: CrossAxisAlignment.end,
                        childrenPadding: EdgeInsets.fromLTRB(16, 5, 16, 8),
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(36, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Quantity : ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      prepDetail.quantity.toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                AppSpace.vertical(5),
                                Row(
                                  children: [
                                    Text(
                                      'Purchase Order : ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      prepDetail.purchaseOrder ?? '-',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                AppSpace.vertical(5),
                                Text(
                                  'Items : ',
                                  style: TextStyle(fontSize: 12),
                                ),
                                if (prepDetail.items != null)
                                  ...prepDetail.items!.map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        5,
                                        2,
                                        5,
                                        2,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e.assetCode ?? '',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            e.location ?? '',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            e.status ?? '',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  _assigned(
    Preparation preparation,
    List<PreparationDetail>? preparationDetails,
  ) {
    if (preparationDetails == null) {
      AppToast.show(
        context: context,
        type: ToastType.warning,
        message: 'No assets have been selected yet',
      );
    } else {
      context.showDialogConfirm(
        title: 'Assigned Preparation',
        content:
            'Are your sure assigned preparation ?\nCode : ${preparation.code}\nDestination : ${preparation.destination}',
        onCancelText: 'Cancel',
        onConfirmText: 'Ya',
        fontSize: 12,
        onCancel: () => context.pop(),
        onConfirm: () {
          context.pop();
          context.read<PreparationDesktopBloc>().add(
            OnUpdatePreparationStatus(preparation.id!, 'ASSIGNED'),
          );
          context.dialogLoadingDesktop();
        },
      );
    }
  }

  _add(int preparationId) {
    final quantity = _quantityC.value.text;
    final purchaseOrder = _purchaseOrderC.value.text;
    final po = purchaseOrder.isFilled() ? purchaseOrder : '-';
    if (_selectedType == null) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Type cannot be empty',
      );
    } else if (_selectedCategory == null) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Category cannot be empty',
      );
    } else if (_selectedModel == null) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Model cannot be empty',
      );
    } else if (!quantity.isNumber()) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Quantity not valid',
      );
    } else {
      context.showDialogConfirm(
        title: 'Add Asset Preparation ?',
        content:
            'Type : ${_selectedType?.name}\nCategory : ${_selectedCategory?.name}\nModel : ${_selectedModel?.name}\nPurchase Order : $po\nQuantity : $quantity',
        onCancelText: 'Cancel',
        onConfirmText: 'Yes',
        onCancel: () => context.pop(),
        onConfirm: () {
          context.read<PreparationDetailDesktopBloc>().add(
            OnAddPreparationDetailEvent(
              PreparationDetail(
                modelId: _selectedModel!.id,
                isConsumable: _selectedModel!.isConsumable,
                preparationId: preparationId,
                quantity: int.parse(quantity),
                purchaseOrder: po == '-' ? null : po,
              ),
            ),
          );
          context.pop();
          context.dialogLoadingDesktop();
        },
      );
    }
  }
}
