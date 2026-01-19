import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/core/widgets/app_toast.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_desktop/preparation_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_detail_desktop/preparation_detail_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_text_field_search_desktop.dart';
import 'package:asset_management/desktop/presentation/cubit/datas/datas_desktop_cubit.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail_request.dart';
import 'package:asset_management/domain/entities/preparation/preparation_request.dart';
import 'package:asset_management/mobile/main_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class PreparationDetailContentDraftDesktopView extends StatefulWidget {
  final Preparation? preparation;
  final List<PreparationDetail>? preparationDetails;

  const PreparationDetailContentDraftDesktopView({
    super.key,
    this.preparation,
    this.preparationDetails,
  });

  @override
  State<PreparationDetailContentDraftDesktopView> createState() =>
      _PreparationDetailContentDraftDesktopViewState();
}

class _PreparationDetailContentDraftDesktopViewState
    extends State<PreparationDetailContentDraftDesktopView> {
  AssetType? _selectedType;
  AssetCategory? _selectedCategory;
  AssetModel? _selectedModel;
  late TextEditingController _purchaseOrderC;
  late TextEditingController _quantityC;
  late FocusNode _purchaseOrderFn;
  late FocusNode _quantityFn;

  @override
  void initState() {
    _purchaseOrderC = TextEditingController();
    _quantityC = TextEditingController();
    _purchaseOrderFn = FocusNode();
    _quantityFn = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _purchaseOrderC.dispose();
    _quantityC.dispose();
    _purchaseOrderFn.dispose();
    _quantityFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 400,
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
                      width: 400,
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
                      width: 400,
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
                      onSubmitted: (_) => _add(widget.preparation!.id!),
                    ),
                    AppSpace.vertical(24),
                    AppButton(
                      height: 35,
                      onPressed: () => _add(widget.preparation!.id!),
                      fontSize: 11,
                      title: 'Add',
                      width: context.deviceWidth,
                    ),
                  ],
                ),
              ),
              Spacer(),
              if (widget.preparationDetails!.isNotEmpty)
                AppButton(
                  height: 33,
                  width: 400 - 12,
                  fontSize: 12,
                  title: 'Assigned',
                  onPressed: () =>
                      _assigned(widget.preparation!, widget.preparationDetails),
                ),
            ],
          ),
          AppSpace.horizontal(24),
          if (widget.preparationDetails!.isNotEmpty)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: widget.preparationDetails?.length,
                  itemBuilder: (context, index) {
                    final prepDetail = widget.preparationDetails?[index];
                    return Container(
                      width: context.deviceWidth,
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.kBase),
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prepDetail?.model ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kBlack,
                                ),
                              ),
                              InkWell(
                                onTap: () => _delete(
                                  widget.preparation!.id!,
                                  prepDetail!,
                                ),
                                child: Icon(
                                  Icons.highlight_remove_outlined,
                                  color: AppColors.kRed,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                          AppSpace.vertical(5),
                          Text(
                            prepDetail?.isConsumable == 1
                                ? '${prepDetail?.quantity} PCS | ${prepDetail?.purchaseOrder ?? ''}'
                                : '${prepDetail?.quantity} UNIT | ${prepDetail?.purchaseOrder ?? ''}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.kBlack,
                            ),
                          ),
                          AppSpace.vertical(5),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.kBackgroundMobile,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      prepDetail?.type ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.kBlack,
                                      ),
                                    ),
                                  ],
                                ),
                                Text('|'),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      prepDetail?.category ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 11,
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
          context.read<PreparationDesktopBloc>().add(
            OnUpdatePreparationStatus(
              params: PreparationRequest(
                id: preparation.id,
                status: 'ASSIGNED',
              ),
            ),
          );
          context.pop();
          context.dialogLoadingDesktop();
        },
      );
    }
  }

  _delete(int preparationId, PreparationDetail preparationDetail) {
    context.showDialogConfirm(
      title: 'Delete Asset Preparation ?',
      content:
          'Type : ${preparationDetail.type}\nCategory : ${preparationDetail.category}\nModel : ${preparationDetail.model}\nPurchase Order : ${preparationDetail.purchaseOrder ?? ''}\nQuantity : ${preparationDetail.quantity}',
      onCancelText: 'Cancel',
      onConfirmText: 'Yes',
      onCancel: () => context.pop(),
      onConfirm: () {
        context.read<PreparationDetailDesktopBloc>().add(
          OnDeletePreparationDetailEvent(preparationDetail.id!, preparationId),
        );
        context.pop();
        context.dialogLoadingDesktop();
      },
    );
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
              PreparationDetailRequest(
                assetModelId: _selectedModel!.id,
                isConsumbale: _selectedModel?.isConsumable,
                preparationId: preparationId,
                quantity: int.parse(quantity),
                purchaseOrder: po == '-' ? null : po,
              ),
            ),
          );
          setState(() {
            _quantityC.clear();
          });
          context.pop();
          context.dialogLoadingDesktop();
        },
      );
    }
  }
}
