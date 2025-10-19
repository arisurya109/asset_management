import 'package:asset_management/core/widgets/app_searchable_dropdown.dart';
import 'package:asset_management/main_export.dart';

import '../../../../core/core.dart';
import '../../location_export.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Location'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpace.vertical(12),
              BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  return AppSearchableDropdown<Location>(
                    items: state.locations ?? [],
                    onChanged: (value) => setState(() {
                      parentLocation = value;
                    }),
                    hintText: 'Parent',
                    filterFn: (item, query) =>
                        item.name!.toUpperCase().contains(
                          query.toUpperCase(),
                        ) ||
                        item.code!.toUpperCase().contains(query.toUpperCase()),
                    displayFn: (item) => '${item.name} - ${item.locationType}',
                    hintTextField: 'Find by name and type',
                    value: parentLocation,
                  );
                },
              ),
              AppSpace.vertical(16),
              AppDropDown<String>(
                items: locationType,
                hintText: 'Selected Type',
                onSelected: (value) => setState(() {
                  locationTypeSelected = value;
                }),
                title: 'Location Type',
                value: locationTypeSelected,
              ),
              AppSpace.vertical(16),
              AppDropDown<String>(
                items: boxType,
                hintText: 'Selected Type',
                onSelected: (value) => setState(() {
                  boxTypeSelected = value;
                }),
                title: 'Box Type',
                value: boxTypeSelected,
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: nameC,
                hintText: 'Example : Information Technology',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                title: 'Name Location',
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: codeC,
                hintText: 'Example : 909',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                title: 'Code Location',
              ),
              AppSpace.vertical(16),
              AppTextField(
                controller: initC,
                hintText: 'Example : IT',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                title: 'Init Location',
                onSubmitted: (_) => _onSubmit(),
              ),
              AppSpace.vertical(32),
              BlocConsumer<LocationBloc, LocationState>(
                listener: (context, state) {
                  nameC.clear();
                  if (state.status == StatusLocation.failed) {
                    context.showSnackbar(
                      state.message ?? 'Failed to create location',
                      backgroundColor: AppColors.kRed,
                    );
                  }

                  if (state.status == StatusLocation.success) {
                    context.showSnackbar('Successfully create location');
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusLocation.loading
                        ? 'Loading...'
                        : 'Create',
                    width: double.maxFinite,

                    onPressed: state.status == StatusLocation.loading
                        ? null
                        : _onSubmit,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmit() {
    final name = nameC.value.text.trim();
    final init = initC.value.text.trim();
    final code = codeC.value.text.trim().toString();
    if (locationTypeSelected == null) {
      context.showSnackbar('Location type is not empty');
    } else if (!nameC.value.text.trim().isFilled()) {
      context.showSnackbar('Location name is not empty');
    } else {
      context.showDialogConfirm(
        title: 'Are your sure create new location ?',
        content:
            'Parent : ${parentLocation?.name}\nLocation Type : $locationTypeSelected\nLocation Name : $name',
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<LocationBloc>().add(
            OnCreateLocation(
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
