import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/core/widgets/app_toast.dart';
import 'package:asset_management/desktop/presentation/bloc/location_desktop/location_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_text_field_desktop.dart';
import 'package:asset_management/desktop/presentation/cubit/datas/datas_desktop_cubit.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddLocationDesktopView extends StatefulWidget {
  const AddLocationDesktopView({super.key});

  @override
  State<AddLocationDesktopView> createState() => _AddLocationDesktopViewState();
}

class _AddLocationDesktopViewState extends State<AddLocationDesktopView> {
  late TextEditingController _nameC;
  late FocusNode _nameFn;
  late TextEditingController _initC;
  late FocusNode _initFn;
  late TextEditingController _codeC;
  late FocusNode _codeFn;
  String? _locationSelectedType;
  Location? _parentLocation;
  String? _boxTypeSelected;
  final List<String> _boxsType = ['CARDBOX', 'TOTEBOX'];

  @override
  void initState() {
    _nameC = TextEditingController();
    _nameFn = FocusNode();
    _initC = TextEditingController();
    _initFn = FocusNode();
    _codeC = TextEditingController();
    _codeFn = FocusNode();
    _nameFn.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppHeaderDesktop(title: 'Add Location', withBackButton: true),
        AppBodyDesktop(
          body: Container(
            width: 300,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(4),
            ),
            child: BlocBuilder<DatasDesktopCubit, void>(
              builder: (context, state) {
                return Column(
                  children: [
                    AppTextFieldDesktop(
                      title: 'Name',
                      hintText: 'Example : Ruang Server',
                      controller: _nameC,
                      focusNode: _nameFn,
                      fontSize: 12,
                      textInputAction: TextInputAction.next,
                    ),
                    AppSpace.vertical(12),
                    AppTextFieldDesktop(
                      title: 'Code',
                      hintText: 'Example : 909',
                      controller: _codeC,
                      focusNode: _codeFn,
                      fontSize: 12,
                      textInputAction: TextInputAction.next,
                    ),
                    AppSpace.vertical(12),
                    AppTextFieldDesktop(
                      title: 'Init',
                      hintText: 'Example : IT',
                      controller: _initC,
                      focusNode: _initFn,
                      fontSize: 12,
                      textInputAction: TextInputAction.next,
                    ),
                    AppSpace.vertical(12),
                    AppDropDownSearch<String>(
                      fontSize: 12,
                      title: 'Type',
                      hintText: 'Selected Type',
                      borderRadius: 4,
                      compareFn: (value, value1) => value == value1,
                      itemAsString: (value) => value,
                      selectedItem: _locationSelectedType,
                      onFind: (_) async => await context
                          .read<DatasDesktopCubit>()
                          .getLocationTypes(),
                      onChanged: (value) => setState(() {
                        _locationSelectedType = value;
                      }),
                    ),
                    AppSpace.vertical(12),
                    AppDropDownSearch<Location>(
                      fontSize: 12,
                      title: 'Parent',
                      hintText: 'Selected Parent (Optional)',
                      borderRadius: 4,
                      compareFn: (value, value1) => value == value1,
                      itemAsString: (value) => value.name!,
                      selectedItem: _parentLocation,
                      onFind: (_) async => await context
                          .read<DatasDesktopCubit>()
                          .getLocations(),
                      onChanged: (value) => setState(() {
                        _parentLocation = value;
                      }),
                    ),
                    AppSpace.vertical(12),
                    AppDropDownSearch<String>(
                      fontSize: 12,
                      title: 'Box Type',
                      hintText: 'Selected Box Type (Optional)',
                      borderRadius: 4,
                      compareFn: (value, value1) => value == value1,
                      itemAsString: (value) => value,
                      selectedItem: _boxTypeSelected,
                      items: _boxsType,
                      onChanged: (value) => setState(() {
                        _boxTypeSelected = value;
                      }),
                    ),
                    AppSpace.vertical(24),
                    BlocConsumer<LocationDesktopBloc, LocationDesktopState>(
                      listener: (context, state) {
                        if (state.status == StatusLocationDesktop.failure) {
                          context.pop();
                          setState(() {
                            _nameC.clear();
                            _codeC.clear();
                            _initC.clear();
                            _locationSelectedType = null;
                            _parentLocation = null;
                            _boxTypeSelected = null;
                          });
                          AppToast.show(
                            context: context,
                            type: ToastType.error,
                            message: state.message!,
                          );
                        }

                        if (state.status == StatusLocationDesktop.success) {
                          context.pop();
                          setState(() {
                            _nameC.clear();
                            _codeC.clear();
                            _initC.clear();
                            _locationSelectedType = null;
                            _parentLocation = null;
                            _boxTypeSelected = null;
                          });
                          AppToast.show(
                            context: context,
                            type: ToastType.success,
                            message: state.message!,
                          );
                        }
                      },
                      builder: (context, state) {
                        return AppButton(
                          height: 35,
                          title: 'Add',
                          onPressed:
                              state.status == StatusLocationDesktop.loading
                              ? null
                              : () => _onSubmit(),
                          width: context.deviceWidth,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  _onSubmit() {
    final name = _nameC.value.text.trim();
    final init = _initC.value.text.trim();
    final code = _codeC.value.text.trim().toString();

    if (!name.isFilled()) {
      AppToast.show(
        context: context,
        message: 'Location name is not empty',
        type: ToastType.error,
      );
    } else if (code.isFilled() && !code.isNumber() && code.length > 3) {
      AppToast.show(
        context: context,
        message: 'Code Location must number & Max length 3',
        type: ToastType.error,
      );
    } else if (init.isFilled() && init.length > 3) {
      AppToast.show(
        context: context,
        message: 'Init Location max length 3',
        type: ToastType.error,
      );
    } else if (_locationSelectedType == null) {
      AppToast.show(
        context: context,
        message: 'Location type is not empty',
        type: ToastType.error,
      );
    } else {
      context.showDialogConfirm(
        title: 'Are your sure create new location ?',
        fontSize: 12,
        content:
            '''Name : $name
Init : $init
Code : $code
Type : $_locationSelectedType
            ''',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => context.pop(),
        onConfirm: () {
          context.read<LocationDesktopBloc>().add(
            OnCreateLocationEvent(
              Location(
                name: name,
                init: init,
                code: code,
                locationType: _locationSelectedType,
                boxType: _boxTypeSelected,
                parentId: _parentLocation?.id,
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
