import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/core/widgets/app_toast.dart';
import 'package:asset_management/desktop/presentation/bloc/authentication_desktop/authentication_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_desktop/preparation_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_detail_desktop/preparation_detail_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_button_header_table.dart';
import 'package:asset_management/desktop/presentation/components/app_pdf.dart';
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
import 'package:asset_management/mobile/main_export.dart';
import 'package:asset_management/mobile/presentation/components/app_card_item.dart';
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
  late TextEditingController _locationC;
  late TextEditingController _totalBoxC;
  late TextEditingController _workerC;
  late TextEditingController _createdC;

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
    _locationC = TextEditingController();
    _totalBoxC = TextEditingController();
    _workerC = TextEditingController();
    _createdC = TextEditingController();
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
    _locationC.dispose();
    _totalBoxC.dispose();
    _workerC.dispose();
    _createdC.dispose();
    _purchaseOrderC.dispose();
    _quantityC.dispose();
    _purchaseOrderFn.dispose();
    _quantityFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationDesktopBloc>().state.user;
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
                  _locationC = TextEditingController(
                    text: preparation?.temporaryLocation,
                  );
                  _totalBoxC = TextEditingController(
                    text: preparation?.totalBox.toString(),
                  );
                  _workerC = TextEditingController(text: preparation?.worker);
                  _createdC = TextEditingController(text: preparation?.created);

                  final datasTable =
                      state.preparationDetails?.preparationDetail
                          ?.asMap()
                          .entries
                          .map((entry) {
                            int index = entry.key;
                            var e = entry.value;

                            return {
                              'id': e.id.toString(),
                              'no': (index + 1).toString(),
                              'asset_code': e.assetCode ?? '',
                              'category': e.category ?? '',
                              'model': e.model ?? '',
                              'quantity': e.quantity.toString(),
                              'location': e.location ?? '',
                              'status': e.status ?? '',
                              'purchase_order': e.purchaseOrder ?? '',
                            };
                          })
                          .toList() ??
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
                        child: Column(
                          children: [
                            Row(
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
                            AppSpace.vertical(16),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    AppSpace.vertical(5),
                                    AppTextFieldSearchDesktop(
                                      width: (context.deviceWidth - 272) / 5,
                                      controller: _locationC,
                                      enabled: false,
                                    ),
                                  ],
                                ),
                                AppSpace.horizontal(12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Box',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    AppSpace.vertical(5),
                                    AppTextFieldSearchDesktop(
                                      width: (context.deviceWidth - 272) / 4.5,
                                      controller: _totalBoxC,
                                      enabled: false,
                                    ),
                                  ],
                                ),
                                AppSpace.horizontal(12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Worker',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    AppSpace.vertical(5),
                                    AppTextFieldSearchDesktop(
                                      width: (context.deviceWidth - 272) / 5,
                                      controller: _workerC,
                                      enabled: false,
                                    ),
                                  ],
                                ),
                                AppSpace.horizontal(12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Created',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    AppSpace.vertical(5),
                                    AppTextFieldSearchDesktop(
                                      width: (context.deviceWidth - 272) / 3,
                                      controller: _createdC,
                                      enabled: false,
                                    ),
                                  ],
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
                      if (preparation?.status == 'READY TO DELIVERY' &&
                          preparation?.createdId == user?.id)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppButtonHeaderTable(
                              title: 'Outgoing',
                              icons: Icons.print_rounded,
                              onPressed: () => AppPdf.showPdfPreviewDialog(
                                context,
                                preparation!,
                                preparationDetails!,
                              ),
                              borderColor: AppColors.kBase,
                              iconColors: AppColors.kBase,
                              titleColor: AppColors.kBase,
                            ),
                            AppSpace.horizontal(16),
                            AppButtonHeaderTable(
                              title: 'Completed',
                              icons: Icons.done,
                              onPressed: () {},
                              borderColor: AppColors.kBase,
                              iconColors: AppColors.kBase,
                              titleColor: AppColors.kBase,
                            ),
                            AppSpace.horizontal(16),
                          ],
                        ),
                      if (preparation?.status == 'READY' &&
                          preparation?.approvedId == user?.id)
                        BlocConsumer<
                          PreparationDesktopBloc,
                          PreparationDesktopState
                        >(
                          listener: (context, state) {
                            if (state.status ==
                                StatusPreparationDesktop.failure) {
                              context.pop();
                              AppToast.show(
                                context: context,
                                type: ToastType.error,
                                message: state.message!,
                              );
                            }

                            if (state.status ==
                                StatusPreparationDesktop.updateSuccess) {
                              context.pop();
                              AppToast.show(
                                context: context,
                                type: ToastType.success,
                                message: state.message!,
                              );
                              context.pop();
                            }
                          },
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppButtonHeaderTable(
                                  title: 'Approved',
                                  icons: Icons.approval_outlined,
                                  onPressed:
                                      state.status ==
                                          StatusPreparationDesktop.loading
                                      ? null
                                      : () {
                                          context.showDialogConfirm(
                                            title: 'Approved',
                                            content:
                                                'Are your sure approved ${preparation?.code}\nTo ${preparation?.destination} ?',
                                            onCancel: () => context.pop(),
                                            onConfirm: () {
                                              context
                                                  .read<
                                                    PreparationDesktopBloc
                                                  >()
                                                  .add(
                                                    OnUpdatePreparationStatus(
                                                      preparation!.id!,
                                                      'READY TO DELIVERY',
                                                    ),
                                                  );
                                              context.pop();
                                              context.dialogLoadingDesktop();
                                            },
                                          );
                                        },
                                  iconColors: AppColors.kBase,
                                  borderColor: AppColors.kBase,
                                  titleColor: AppColors.kBase,
                                ),
                                AppSpace.horizontal(16),
                              ],
                            );
                          },
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
                                label: 'PO NUMBER',
                                key: 'purchase_order',
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

                    if (state.status ==
                        StatusPreparationDesktop.updateSuccess) {
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
                    return prepDetail.isConsumable == 1
                        ? AppCardItem(
                            title:
                                '${prepDetail.model} | ${prepDetail.quantity} PCS',
                            leading: prepDetail.category,
                            subtitle: prepDetail.location,
                            noDescription: true,
                          )
                        : AppCardItem(
                            title: prepDetail.assetCode,
                            leading: prepDetail.purchaseOrder ?? '-',
                            subtitle: prepDetail.location,
                            noDescription: true,
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
