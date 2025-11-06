import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_dropdown_search.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/entities/master/preparation_template.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/domain/entities/user/user.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/bloc/user/user_bloc.dart';
import 'package:asset_management/presentation/view/preparation/selected_assets_preparation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePreparationView extends StatefulWidget {
  const CreatePreparationView({super.key});

  @override
  State<CreatePreparationView> createState() => _CreatePreparationViewState();
}

class _CreatePreparationViewState extends State<CreatePreparationView> {
  Location? selectedLocation;
  User? selectedAssigned;
  PreparationTemplate? selectedTemplate;
  late TextEditingController notesC;

  @override
  void initState() {
    notesC = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Preparation')),
      body: BlocBuilder<MasterBloc, MasterState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  AppSpace.vertical(12),
                  AppDropDownSearch<Location>(
                    title: 'Destination',
                    items:
                        state.locations?.where((element) {
                          final params = element.locationType;
                          return params != 'RACK' && params != 'BOX';
                        }).toList() ??
                        [],
                    hintText: 'Selected Destination',
                    itemAsString: (value) => value.name ?? '',
                    compareFn: (value, value1) => value.name == value1.name,
                    selectedItem: selectedLocation,
                    onChanged: (value) => setState(() {
                      selectedLocation = value;
                    }),
                  ),
                  AppSpace.vertical(16),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      return AppDropDownSearch<User>(
                        title: 'Assigned',
                        items: state.users ?? [],
                        hintText: 'Selected Worker',
                        itemAsString: (value) => value.name ?? '',
                        compareFn: (value, value1) => value.name == value1.name,
                        selectedItem: selectedAssigned,
                        onChanged: (value) => setState(() {
                          selectedAssigned = value;
                        }),
                      );
                    },
                  ),
                  AppSpace.vertical(16),
                  AppDropDownSearch<PreparationTemplate>(
                    title: 'Preparation Set',
                    items: state.preparationTemplates ?? [],
                    hintText: 'Selected Set Preparation',
                    itemAsString: (value) => value.name ?? '',
                    compareFn: (value, value1) => value.name == value1.name,
                    selectedItem: selectedTemplate,
                    onChanged: (value) => setState(() {
                      context.read<MasterBloc>().add(
                        OnFindAllPreparationTemplateItemByIdEvent(value!.id!),
                      );
                      selectedTemplate = value;
                    }),
                  ),
                  AppSpace.vertical(16),
                  AppTextField(
                    controller: notesC,
                    hintText: 'Optional',
                    title: 'Description',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                  ),
                  AppSpace.vertical(32),
                  AppButton(
                    title: 'Next',
                    width: context.deviceWidth,
                    onPressed: _nextButton,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _nextButton() {
    final destination = selectedLocation;
    final assigned = selectedAssigned;
    final preparationSet = selectedTemplate;
    final notes = notesC.value.text.trim();
    List<PreparationDetail> preparationDetail = [];

    if (destination == null) {
      context.showSnackbar(
        'Destination cannot be empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (assigned == null) {
      context.showSnackbar(
        'Assigned Worker cannot be empty',
        backgroundColor: AppColors.kRed,
      );
    } else {
      if (preparationSet != null) {
        final templates = context
            .read<MasterBloc>()
            .state
            .preparationTemplateItems;

        for (var i = 0; i < templates!.length; i++) {
          preparationDetail.add(
            PreparationDetail(
              assetModelId: templates[i].modelId,
              quantityTarget: templates[i].quantity,
              assetBrand: templates[i].assetBrand,
              assetCategory: templates[i].assetCategory,
              assetType: templates[i].assetType,
              assetModel: templates[i].assetModel,
              quantityMissing: 0,
              quantityPicked: 0,
              status: 'PENDING',
            ),
          );
        }
      }
      context.push(
        SelectedAssetsPreparationView(
          preparation: Preparation(
            assigned: assigned.name,
            assignedId: assigned.id,
            destination: destination.name,
            destinationId: destination.id,
            notes: notes,
          ),
          preparationDetail: preparationDetail,
        ),
      );
    }
  }
}
