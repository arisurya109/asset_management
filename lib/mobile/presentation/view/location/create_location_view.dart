import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/mobile/main_export.dart';
import 'package:asset_management/mobile/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/mobile/responsive_layout.dart';

import '../../../../../core/core.dart';

class CreateLocationView extends StatefulWidget {
  const CreateLocationView({super.key});

  @override
  State<CreateLocationView> createState() => _CreateLocationViewState();
}

class _CreateLocationViewState extends State<CreateLocationView> {
  Location? parentLocation;
  List<String> locationType = [
    'OFFICE',
    'STORE',
    'WAREHOUSE',
    'DIVISION',
    'RACK',
    'BOX',
    'TABLE',
  ];
  List<String> boxType = ['CARDBOX', 'TOTEBOX'];
  late TextEditingController nameC;
  late TextEditingController codeC;
  late TextEditingController initC;
  String? boxTypeSelected;
  String? locationTypeSelected;

  @override
  void initState() {
    nameC = TextEditingController();
    codeC = TextEditingController();
    initC = TextEditingController();
    super.initState();
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
      body: BlocBuilder<MasterBloc, MasterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppSpace.vertical(12),
                  AppDropDownSearch<Location>(
                    title: 'Parent',
                    items: state.locations ?? [],
                    hintText: 'Selected Parent',
                    selectedItem: parentLocation,
                    fontSize: isLarge ? 14 : 12,
                    compareFn: (value, value1) => value.name == value1.name,
                    itemAsString: (value) => value.name!,
                    onChanged: (value) => setState(() {
                      parentLocation = value;
                    }),
                  ),
                  AppSpace.vertical(16),
                  AppDropDownSearch<String>(
                    title: 'Location Type',
                    items: locationType,
                    fontSize: isLarge ? 14 : 12,
                    hintText: 'Selected Type',
                    selectedItem: locationTypeSelected,
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value,
                    onChanged: (value) => setState(() {
                      locationTypeSelected = value;
                    }),
                  ),
                  AppSpace.vertical(16),
                  AppDropDownSearch<String>(
                    title: 'Box Type',
                    items: boxType,
                    fontSize: isLarge ? 14 : 12,
                    hintText: 'Selected Box Type',
                    selectedItem: boxTypeSelected,
                    compareFn: (value, value1) => value == value1,
                    itemAsString: (value) => value,
                    onChanged: (value) => setState(() {
                      boxTypeSelected = value;
                    }),
                  ),
                  AppSpace.vertical(16),
                  AppTextField(
                    controller: nameC,
                    hintText: 'Example : Information Technology',
                    keyboardType: TextInputType.text,
                    fontSize: isLarge ? 14 : 12,
                    textInputAction: TextInputAction.next,
                    title: 'Name Location',
                  ),
                  AppSpace.vertical(16),
                  AppTextField(
                    controller: codeC,
                    fontSize: isLarge ? 14 : 12,
                    hintText: 'Example : 909',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    title: 'Code Location',
                  ),
                  AppSpace.vertical(16),
                  AppTextField(
                    controller: initC,
                    fontSize: isLarge ? 14 : 12,
                    hintText: 'Example : IT',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    title: 'Init Location',
                    onSubmitted: (_) => _onSubmit(isLarge),
                  ),
                  AppSpace.vertical(32),
                  BlocConsumer<MasterBloc, MasterState>(
                    listener: (context, state) {
                      setState(() {
                        nameC.clear();
                        parentLocation = null;
                        locationTypeSelected = null;
                        boxTypeSelected = null;
                        codeC.clear();
                        initC.clear();
                      });
                      if (state.status == StatusMaster.failed) {
                        context.showSnackbar(
                          state.message ?? 'Failed to create location',
                          backgroundColor: AppColors.kRed,
                          fontSize: isLarge ? 14 : 12,
                        );
                      }

                      if (state.status == StatusMaster.success) {
                        context.showSnackbar(
                          'Successfully create location',
                          fontSize: isLarge ? 14 : 12,
                        );
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                        title: state.status == StatusMaster.loading
                            ? 'Loading...'
                            : 'Create',
                        width: double.maxFinite,
                        fontSize: isLarge ? 16 : 14,
                        onPressed: state.status == StatusMaster.loading
                            ? null
                            : () => _onSubmit(isLarge),
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
    if (locationTypeSelected == null) {
      context.showSnackbar(
        'Location type is not empty',
        fontSize: isLarge ? 14 : 12,
      );
    } else if (!nameC.value.text.trim().isFilled()) {
      context.showSnackbar(
        'Location name is not empty',
        fontSize: isLarge ? 14 : 12,
      );
    } else {
      context.showDialogConfirm(
        title: 'Are your sure create new location ?',
        fontSize: isLarge ? 14 : 12,
        content:
            'Parent : ${parentLocation?.name}\nLocation Type : $locationTypeSelected\nLocation Name : $name',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          final isStorage =
              (locationTypeSelected == 'WAREHOUSE' ||
                  locationTypeSelected == 'RACK' ||
                  locationTypeSelected == 'BOX')
              ? 1
              : 0;
          context.read<MasterBloc>().add(
            OnCreateLocationEvent(
              Location(
                name: name,
                isStorage: isStorage,
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
