import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/core/widgets/app_toast.dart';
import 'package:asset_management/desktop/presentation/bloc/return/return_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_text_field_search_desktop.dart';
import 'package:asset_management/desktop/presentation/cubit/datas/datas_desktop_cubit.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/entities/movement/movement.dart';
import 'package:asset_management/mobile/main_export.dart';
import 'package:go_router/go_router.dart';

class ReturnDesktopView extends StatefulWidget {
  const ReturnDesktopView({super.key});

  @override
  State<ReturnDesktopView> createState() => _ReturnDesktopViewState();
}

class _ReturnDesktopViewState extends State<ReturnDesktopView> {
  late TextEditingController assetCodeC;
  late TextEditingController locationAssetC;
  late TextEditingController categoryAssetC;
  late TextEditingController modelAssetC;
  late TextEditingController statusAssetC;
  late TextEditingController conditonsAssetC;
  late TextEditingController poAssetC;
  late TextEditingController typeAssetC;
  late TextEditingController remarksC;
  late FocusNode fnAssetCode;
  late FocusNode fnRemarks;

  Location? toLocation;
  AssetEntity? selectedAsset;
  List<String> listCondition = ['GOOD', 'OLD', 'NEED TO CHECK'];
  String? selectedCondition;

  bool _isSearchActiveAsset = false;
  bool _isBtnUpdateActive = false;

  @override
  void initState() {
    assetCodeC = TextEditingController();
    locationAssetC = TextEditingController();
    categoryAssetC = TextEditingController();
    modelAssetC = TextEditingController();
    statusAssetC = TextEditingController();
    conditonsAssetC = TextEditingController();
    poAssetC = TextEditingController();
    typeAssetC = TextEditingController();
    remarksC = TextEditingController();
    fnAssetCode = FocusNode();
    fnRemarks = FocusNode();
    super.initState();
  }

  _clear() {
    locationAssetC.clear();
    categoryAssetC.clear();
    modelAssetC.clear();
    statusAssetC.clear();
    conditonsAssetC.clear();
    poAssetC.clear();
    typeAssetC.clear();
    selectedAsset = null;
    _isBtnUpdateActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppHeaderDesktop(title: 'Return'),
        AppBodyDesktop(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Find Asset
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
                    AppDropDownSearch<Location>(
                      title: '',
                      hintText: 'Selected Destination',
                      onFind: (String filter) async => await context
                          .read<DatasDesktopCubit>()
                          .getLocationsByStorage('STORAGE'),
                      borderRadius: 4,
                      compareFn: (value, value1) => value.name == value1.name,
                      itemAsString: (value) => value.name!,
                      fontSize: 12,
                      enabled: true,
                      onChanged: (value) => setState(() {
                        toLocation = value;
                      }),
                      showSearchBox: true,
                      selectedItem: toLocation,
                    ),
                    AppSpace.vertical(16),
                    AppDropDownSearch<String>(
                      title: '',
                      hintText: 'Selected Condition',
                      items: listCondition,
                      borderRadius: 4,
                      compareFn: (value, value1) => value == value1,
                      itemAsString: (value) => value,
                      fontSize: 12,
                      enabled: true,
                      onChanged: (value) => setState(() {
                        selectedCondition = value;
                        fnAssetCode.requestFocus();
                      }),
                      showSearchBox: true,
                      selectedItem: selectedCondition,
                    ),
                    AppSpace.vertical(16),
                    AppTextFieldSearchDesktop(
                      width: 350,
                      height: 35,
                      hintText: 'Remarks',
                      focusNode: fnRemarks,
                      controller: remarksC,
                      suffixIcon: remarksC.value.text.isFilled()
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 16),
                              onPressed: () {
                                setState(() {
                                  remarksC.clear();
                                });
                              },
                            )
                          : Icon(Icons.minimize, color: Colors.transparent),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            remarksC.clear();
                          });
                        }
                      },
                      onSubmitted: (p0) => setState(() {
                        fnAssetCode.requestFocus();
                      }),
                    ),
                    AppSpace.vertical(16),
                    AppTextFieldSearchDesktop(
                      width: 350,
                      height: 35,
                      hintText: 'Asset Code',
                      focusNode: fnAssetCode,
                      controller: assetCodeC,
                      suffixIcon: _isSearchActiveAsset
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 16),
                              onPressed: () {
                                setState(() {
                                  assetCodeC.clear();
                                  _isSearchActiveAsset = false;
                                  _clear();
                                });
                              },
                            )
                          : null,
                      withSearchIcon: true,
                      onChanged: (value) {
                        if (value.isEmpty && _isSearchActiveAsset) {
                          setState(() {
                            _isSearchActiveAsset = false;
                            _clear();
                          });
                        }
                      },
                      onSubmitted: (value) async {
                        await _findAsset(value);
                      },
                    ),
                    AppSpace.vertical(24),
                    AppButton(
                      height: 35,
                      onPressed: () async {
                        if (assetCodeC.value.text.isFilled()) {
                          await _findAsset(assetCodeC.value.text);
                        }
                      },
                      fontSize: 11,
                      title: 'Search',
                      width: context.deviceWidth,
                    ),
                  ],
                ),
              ),
              AppSpace.horizontal(24),
              // Field Asset After Finding
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
                    Text('Type', style: TextStyle(fontSize: 12)),
                    AppSpace.vertical(5),
                    AppTextFieldSearchDesktop(
                      hintText: 'Type',
                      controller: typeAssetC,
                      enabled: false,
                      width: 350,
                    ),
                    AppSpace.vertical(11),
                    Text('Category', style: TextStyle(fontSize: 12)),
                    AppSpace.vertical(5),
                    AppTextFieldSearchDesktop(
                      hintText: 'Category',
                      controller: categoryAssetC,
                      enabled: false,
                      width: 350,
                    ),
                    AppSpace.vertical(11),
                    Text('Model', style: TextStyle(fontSize: 12)),
                    AppSpace.vertical(5),
                    AppTextFieldSearchDesktop(
                      hintText: 'Model',
                      controller: modelAssetC,
                      enabled: false,
                      width: 350,
                    ),
                    AppSpace.vertical(11),
                    Text('Location', style: TextStyle(fontSize: 12)),
                    AppSpace.vertical(5),
                    AppTextFieldSearchDesktop(
                      hintText: 'Location',
                      controller: locationAssetC,
                      enabled: false,
                      width: 350,
                    ),
                    AppSpace.vertical(11),
                    Text('PO', style: TextStyle(fontSize: 12)),
                    AppSpace.vertical(5),
                    AppTextFieldSearchDesktop(
                      hintText: 'PO',
                      controller: poAssetC,
                      enabled: false,
                      width: 350,
                    ),
                    AppSpace.vertical(11),
                    Text('Status', style: TextStyle(fontSize: 12)),
                    AppSpace.vertical(5),
                    AppTextFieldSearchDesktop(
                      hintText: 'Status',
                      width: 350,
                      controller: statusAssetC,
                      enabled: false,
                    ),
                    AppSpace.vertical(11),
                    Text('Condition', style: TextStyle(fontSize: 12)),
                    AppSpace.vertical(5),
                    AppTextFieldSearchDesktop(
                      hintText: 'Condition',
                      width: 350,
                      controller: conditonsAssetC,
                      enabled: false,
                    ),
                    AppSpace.vertical(24),
                    BlocListener<ReturnBloc, ReturnState>(
                      listener: (context, state) {
                        if (state.status == StatusReturn.loading) {
                          context.dialogLoadingDesktop();
                        }

                        if (state.status == StatusReturn.failure) {
                          context.pop();
                          AppToast.show(
                            context: context,
                            type: ToastType.error,
                            message: state.message!,
                          );
                          setState(() {
                            _clear();
                            assetCodeC.clear();
                            fnAssetCode.requestFocus();
                          });
                        }

                        if (state.status == StatusReturn.success) {
                          context.pop();
                          setState(() {
                            _clear();
                            assetCodeC.clear();
                            fnAssetCode.requestFocus();
                          });
                          AppToast.show(
                            context: context,
                            type: ToastType.success,
                            message: state.message!,
                          );
                        }
                      },
                      child: AppButton(
                        title: 'Accept',
                        onPressed: _isBtnUpdateActive ? () => _btn() : null,
                        height: 35,
                        width: 350,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Find Asset Fnc
  Future _findAsset(String value) async {
    if (value.trim().isNotEmpty) {
      setState(() => _isSearchActiveAsset = true);
      final asset = await context.read<DatasDesktopCubit>().getAssetByAssetCode(
        value,
      );

      if (asset != null) {
        setState(() {
          selectedAsset = asset;
          _isBtnUpdateActive = true;

          categoryAssetC.value = TextEditingValue(text: asset.category ?? '');
          modelAssetC.value = TextEditingValue(text: asset.model ?? '');
          locationAssetC.value = TextEditingValue(
            text: asset.locationDetail ?? asset.location ?? '',
          );
          typeAssetC.value = TextEditingValue(text: asset.types ?? '');
          poAssetC.value = TextEditingValue(
            text: asset.purchaseOrder.isFilled() ? asset.purchaseOrder! : '-',
          );
          statusAssetC.value = TextEditingValue(text: asset.status ?? '');
          conditonsAssetC.value = TextEditingValue(
            text: asset.conditions ?? '',
          );
        });
      } else {
        setState(() => _clear());
        AppToast.show(
          context: context,
          type: ToastType.error,
          message: 'Asset not found',
        );
      }
    }
  }

  // Update Dialog Asset Fnc
  _btn() {
    if (toLocation == null) {
      AppToast.show(
        context: context,
        type: ToastType.warning,
        message: 'Please selected destination',
      );
    } else if (selectedAsset == null) {
      AppToast.show(
        context: context,
        type: ToastType.warning,
        message: 'Not Found Asset',
      );
    } else if (selectedCondition == null) {
      AppToast.show(
        context: context,
        type: ToastType.warning,
        message: 'Please selected status',
      );
    } else {
      context.showDialogConfirm(
        title: 'Accept Asset',
        content: 'Are your sure accept asset ?',
        onCancelText: 'Cancel',
        onConfirm: () {
          context.read<ReturnBloc>().add(
            OnReturn(
              Movement(
                assetId: selectedAsset?.id,
                destination: toLocation?.name,
                fromLocation: selectedAsset?.locationDetail,
                type: 'RETURN',
                status: 'READY',
                conditions: selectedCondition,
                remarks: remarksC.value.text.trim().isFilled()
                    ? remarksC.value.text.trim()
                    : null,
              ),
            ),
          );
          context.pop();
        },
        onConfirmText: 'Yes',
        onCancel: () {
          context.pop();
          fnAssetCode.requestFocus();
        },
      );
    }
  }
}
