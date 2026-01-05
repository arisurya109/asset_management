import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/mobile/main_export.dart';
import 'package:asset_management/mobile/presentation/bloc/location/location_bloc.dart';
import 'package:asset_management/mobile/presentation/cubit/datas_cubit.dart';
import 'package:asset_management/mobile/responsive_layout.dart';

import '../../../../../core/core.dart';

class CreateLocationView extends StatefulWidget {
  const CreateLocationView({super.key});

  @override
  State<CreateLocationView> createState() => _CreateLocationViewState();
}

class _CreateLocationViewState extends State<CreateLocationView> {
  Location? parentLocation;
  List<String> boxType = ['CARDBOX', 'TOTEBOX'];
  late TextEditingController nameC;
  late FocusNode nameFn;
  late TextEditingController codeC;
  late FocusNode codeFn;

  late TextEditingController initC;
  late FocusNode initFn;

  String? boxTypeSelected;
  String? locationTypeSelected;

  @override
  void initState() {
    nameC = TextEditingController();
    codeC = TextEditingController();
    initC = TextEditingController();
    nameFn = FocusNode();
    codeFn = FocusNode();
    initFn = FocusNode();
    nameFn.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    codeC.dispose();
    initC.dispose();
    nameFn.dispose();
    codeFn.dispose();
    initFn.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileCreateLocation(),
      mobileMScaffold: _mobileCreateLocation(isLarge: false),
    );
  }

  Widget _mobileCreateLocation({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Location'), elevation: 0),
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
                    hintText: 'Example : Ruang Server',
                    focusNode: nameFn,
                    keyboardType: TextInputType.text,
                    fontSize: isLarge ? 14 : 12,
                    textInputAction: TextInputAction.next,
                  ),
                  AppSpace.vertical(12),
                  AppTextField(
                    controller: initC,
                    title: 'Init',
                    hintText: 'Example : WHS (Optional)',
                    focusNode: initFn,
                    keyboardType: TextInputType.text,
                    fontSize: isLarge ? 14 : 12,
                    textInputAction: TextInputAction.next,
                  ),
                  AppSpace.vertical(12),
                  AppTextField(
                    controller: codeC,
                    title: 'Code',
                    hintText: 'Example : 999 (Optional)',
                    focusNode: codeFn,
                    keyboardType: TextInputType.number,
                    fontSize: isLarge ? 14 : 12,
                    textInputAction: TextInputAction.next,
                  ),
                  AppSpace.vertical(12),
                  AppDropDownSearch<String>(
                    fontSize: isLarge ? 14 : 12,
                    title: 'Type',
                    hintText: 'Selected Type',
                    borderRadius: 4,
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value,
                    selectedItem: locationTypeSelected,
                    onFind: (_) async =>
                        await context.read<DatasCubit>().getLocationTypes(),
                    onChanged: (value) => setState(() {
                      locationTypeSelected = value;
                    }),
                  ),
                  AppSpace.vertical(12),
                  AppDropDownSearch<Location>(
                    fontSize: isLarge ? 14 : 12,
                    title: 'Parent',
                    hintText: 'Selected Parent (Optional)',
                    borderRadius: 4,
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value.name!,
                    selectedItem: parentLocation,
                    onFind: (_) async =>
                        await context.read<DatasCubit>().getLocations(),
                    onChanged: (value) => setState(() {
                      parentLocation = value;
                    }),
                  ),
                  AppSpace.vertical(12),
                  AppDropDownSearch<String>(
                    fontSize: isLarge ? 14 : 12,
                    title: 'Box Type',
                    hintText: 'Selected Box Type (Optional)',
                    borderRadius: 4,
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value,
                    selectedItem: boxTypeSelected,
                    items: boxType,
                    onChanged: (value) => setState(() {
                      boxTypeSelected = value;
                    }),
                  ),
                  AppSpace.vertical(16),
                  BlocConsumer<LocationBloc, LocationState>(
                    listener: (context, state) {
                      if (state.status == StatusLocation.failure) {
                        context.showSnackbar(
                          state.message!,
                          backgroundColor: AppColors.kRed,
                          fontSize: isLarge ? 14 : 12,
                        );
                        setState(() {
                          nameC.clear();
                          initC.clear();
                          codeC.clear();
                          locationTypeSelected = null;
                          parentLocation = null;
                          boxTypeSelected = null;
                        });
                      }

                      if (state.status == StatusLocation.success) {
                        context.showSnackbar(
                          'Successfully create ${nameC.value.text.trim().toUpperCase()}',
                          fontSize: isLarge ? 14 : 12,
                        );
                        setState(() {
                          nameC.clear();
                          initC.clear();
                          codeC.clear();
                          locationTypeSelected = null;
                          parentLocation = null;
                          boxTypeSelected = null;
                        });
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                        title: state.status == StatusLocation.loading
                            ? 'Loading...'
                            : 'Create',
                        fontSize: isLarge ? 16 : 14,
                        onPressed: state.status == StatusLocation.loading
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
    final name = nameC.value.text.trim();
    final init = initC.value.text.trim();
    final code = codeC.value.text.trim().toString();

    if (!nameC.value.text.trim().isFilled()) {
      context.showSnackbar(
        'Location name is not empty',
        fontSize: isLarge ? 14 : 12,
        backgroundColor: AppColors.kRed,
      );
    } else if (locationTypeSelected == null) {
      context.showSnackbar(
        'Location type is not empty',
        fontSize: isLarge ? 14 : 12,
        backgroundColor: AppColors.kRed,
      );
    } else {
      context.showDialogConfirm(
        title: 'Are your sure create new location ?',
        fontSize: isLarge ? 14 : 12,
        content:
            '''Name : $name
Init : $init
Code : $code
Type : $locationTypeSelected
            ''',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<LocationBloc>().add(
            OnCreateLocationEvent(
              Location(
                name: name,
                init: init,
                code: code,
                locationType: locationTypeSelected,
                boxType: boxTypeSelected,
                parentId: parentLocation?.id,
              ),
            ),
          );
          Navigator.pop(context);
        },
      );
    }
  }
}
