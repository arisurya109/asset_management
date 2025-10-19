import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/features/preparation/presentation/view/select_asset_non_consumable_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../location/location_export.dart';

class CreatePreparationView extends StatefulWidget {
  const CreatePreparationView({super.key});

  @override
  State<CreatePreparationView> createState() => _CreatePreparationViewState();
}

class _CreatePreparationViewState extends State<CreatePreparationView> {
  late TextEditingController description;
  Location? destination;

  @override
  void initState() {
    description = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Preparation'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            children: [
              BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  return AppDropDownSearch<Location>(
                    title: 'Destination',
                    items:
                        state.locations?.where((element) {
                          return element.locationType != 'WAREHOUSE' &&
                              element.locationType != 'RACK' &&
                              element.locationType != 'BOX' &&
                              element.locationType != 'TABLE';
                        }).toList() ??
                        [],
                    hintText: 'Selected Destination',
                    compareFn: (value, value1) => value.name == value1.name,
                    selectedItem: destination,
                    showSearchBox: true,
                    itemAsString: (value) => value.name!,
                    onChanged: (value) => setState(() {
                      destination = value;
                    }),
                  );
                },
              ),
              AppSpace.vertical(16),
              BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  return AppDropDownSearch<Location>(
                    title: 'Assign',
                    items:
                        state.locations?.where((element) {
                          return element.locationType != 'WAREHOUSE' &&
                              element.locationType != 'RACK' &&
                              element.locationType != 'BOX' &&
                              element.locationType != 'TABLE';
                        }).toList() ??
                        [],
                    enabled: false,
                    hintText: 'Selected Worker',
                    compareFn: (value, value1) => value.name == value1.name,
                    selectedItem: destination,
                    showSearchBox: true,
                    itemAsString: (value) => value.name!,
                    onChanged: (value) => setState(() {
                      destination = value;
                    }),
                  );
                },
              ),
              AppSpace.vertical(16),
              AppTextField(
                title: 'Description',
                controller: description,
                hintText: 'Example : Asset New Store X',
                keyboardType: TextInputType.text,
              ),
              AppSpace.vertical(64),
              AppButton(
                title: 'Select Assets',
                onPressed: () => context.push(SelectAssetNonConsumableView()),
                width: double.maxFinite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
