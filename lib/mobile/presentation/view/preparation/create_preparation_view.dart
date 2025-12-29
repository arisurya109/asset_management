// import 'package:asset_management/core/core.dart';
// import 'package:asset_management/core/widgets/app_dropdown_search.dart';
// import 'package:asset_management/domain/entities/master/location.dart';
// import 'package:asset_management/domain/entities/master/preparation_template.dart';
// import 'package:asset_management/domain/entities/preparation/preparation.dart';
// import 'package:asset_management/domain/entities/preparation_detail/preparation_detail.dart';
// import 'package:asset_management/domain/entities/user/user.dart';
// import 'package:asset_management/mobile/presentation/bloc/authentication/authentication_bloc.dart';
// import 'package:asset_management/mobile/presentation/bloc/master/master_bloc.dart';
// import 'package:asset_management/mobile/presentation/bloc/user/user_bloc.dart';
// import 'package:asset_management/mobile/presentation/view/preparation/selected_preparation_detail_asset_view.dart';
// import 'package:asset_management/mobile/responsive_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CreatePreparationView extends StatefulWidget {
//   const CreatePreparationView({super.key});

//   @override
//   State<CreatePreparationView> createState() => _CreatePreparationViewState();
// }

// class _CreatePreparationViewState extends State<CreatePreparationView> {
//   Location? selectedLocation;
//   User? selectedUser;
//   User? approvedUser;
//   String? selectedAfterShipped;
//   PreparationTemplate? selectedTemplate;
//   late TextEditingController notesC;

//   List<String> listAfterShipped = ['USE', 'REPAIR'];

//   @override
//   void initState() {
//     notesC = TextEditingController();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveLayout(
//       mobileLScaffold: _mobileCreatePreparation(context),
//       mobileMScaffold: _mobileCreatePreparation(context, isLarge: false),
//     );
//   }

//   Widget _mobileCreatePreparation(BuildContext context, {bool isLarge = true}) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Create Preparation')),
//       body: BlocBuilder<MasterBloc, MasterState>(
//         builder: (context, state) {
//           final locations = state.locations?.where((element) {
//             return element.locationType != 'RACK' &&
//                 element.locationType != 'BOX' &&
//                 element.name != 'GUDANG I';
//           }).toList();
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 children: [
//                   // Destination
//                   AppDropDownSearch<Location>(
//                     title: 'Destination',
//                     items: locations ?? [],
//                     borderRadius: 5,
//                     selectedItem: selectedLocation,
//                     compareFn: (value, value1) => value.id == value1.id,
//                     itemAsString: (value) => value.name!,
//                     onChanged: (value) => setState(() {
//                       selectedLocation = value;
//                     }),
//                     fontSize: isLarge ? 14 : 12,
//                     hintText: 'Selected destination',
//                   ),
//                   AppSpace.vertical(16),
//                   // Worker
//                   BlocSelector<UserBloc, UserState, List<User>>(
//                     selector: (state) {
//                       return state.users ?? [];
//                     },
//                     builder: (context, state) {
//                       final userId = context
//                           .read<AuthenticationBloc>()
//                           .state
//                           .user!
//                           .id;
//                       final users = state.where((element) {
//                         return element.id != userId;
//                       }).toList();
//                       return AppDropDownSearch<User>(
//                         title: 'Worker',
//                         items: users,
//                         borderRadius: 5,
//                         selectedItem: selectedUser,
//                         compareFn: (value, value1) => value.id == value1.id,
//                         itemAsString: (value) => value.name!,
//                         onChanged: (value) => setState(() {
//                           selectedUser = value;
//                         }),
//                         fontSize: isLarge ? 14 : 12,
//                         hintText: 'Selected worker',
//                       );
//                     },
//                   ),
//                   AppSpace.vertical(16),
//                   // Approved
//                   BlocSelector<UserBloc, UserState, List<User>>(
//                     selector: (state) {
//                       return state.users ?? [];
//                     },
//                     builder: (context, state) {
//                       final userId = context
//                           .read<AuthenticationBloc>()
//                           .state
//                           .user!
//                           .id;
//                       final users = state.where((element) {
//                         return element.id != userId &&
//                             element.id != selectedUser?.id;
//                       }).toList();
//                       return AppDropDownSearch<User>(
//                         title: 'Approved',
//                         items: users,
//                         borderRadius: 5,
//                         selectedItem: approvedUser,
//                         compareFn: (value, value1) => value.id == value1.id,
//                         itemAsString: (value) => value.name!,
//                         onChanged: (value) => setState(() {
//                           approvedUser = value;
//                         }),
//                         fontSize: isLarge ? 14 : 12,
//                         hintText: 'Approved By',
//                       );
//                     },
//                   ),
//                   AppSpace.vertical(16),
//                   // Template
//                   AppDropDownSearch<PreparationTemplate>(
//                     title: 'Template',
//                     borderRadius: 5,
//                     items: state.preparationTemplates ?? [],
//                     selectedItem: selectedTemplate,
//                     compareFn: (value, value1) => value.id == value1.id,
//                     itemAsString: (value) => value.name!,
//                     onChanged: (value) => setState(() {
//                       selectedTemplate = value;
//                       if (selectedTemplate != null) {
//                         context.read<MasterBloc>().add(
//                           OnFindAllPreparationTemplateItemByIdEvent(
//                             selectedTemplate!.id!,
//                           ),
//                         );
//                       }
//                     }),
//                     fontSize: isLarge ? 14 : 12,
//                     hintText: 'Selected template',
//                   ),
//                   AppSpace.vertical(16),
//                   // Asset Status After
//                   AppDropDownSearch<String>(
//                     title: 'After Shipped',
//                     borderRadius: 5,
//                     items: listAfterShipped,
//                     selectedItem: selectedAfterShipped,
//                     compareFn: (value, value1) => value == value1,
//                     itemAsString: (value) => value,
//                     onChanged: (value) => setState(() {
//                       selectedAfterShipped = value;
//                     }),
//                     fontSize: isLarge ? 14 : 12,
//                     hintText: 'Selected shipped',
//                   ),
//                   AppSpace.vertical(16),
//                   // Notes
//                   AppTextField(
//                     title: 'Notes',
//                     controller: notesC,
//                     fontSize: isLarge ? 14 : 12,
//                     hintText: 'Optional',
//                     keyboardType: TextInputType.text,
//                     textInputAction: TextInputAction.go,
//                     onSubmitted: (_) => _nextButton(isLarge),
//                   ),
//                   AppSpace.vertical(32),
//                   AppButton(
//                     fontSize: isLarge ? 16 : 14,
//                     onPressed: () => _nextButton(isLarge),
//                     title: 'Next',
//                     width: context.deviceWidth,
//                   ),
//                   AppSpace.vertical(16),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   _nextButton(bool isLarge) {
//     final destination = selectedLocation;
//     final assigned = selectedUser;
//     final approved = approvedUser;
//     final afterShipped = selectedAfterShipped;
//     final preparationSet = selectedTemplate;
//     final notes = notesC.value.text.trim();
//     List<PreparationDetail> preparationDetail = [];

//     if (destination == null) {
//       context.showSnackbar(
//         'Destination cannot be empty',
//         backgroundColor: AppColors.kRed,
//         fontSize: isLarge ? 14 : 12,
//       );
//     } else if (assigned == null) {
//       context.showSnackbar(
//         'Assigned Worker cannot be empty',
//         backgroundColor: AppColors.kRed,
//         fontSize: isLarge ? 14 : 12,
//       );
//     } else if (approved == null) {
//       context.showSnackbar(
//         'Approved cannot be empty',
//         backgroundColor: AppColors.kRed,
//         fontSize: isLarge ? 14 : 12,
//       );
//     } else if (afterShipped == null) {
//       context.showSnackbar(
//         'After Shipped cannot be empty',
//         backgroundColor: AppColors.kRed,
//         fontSize: isLarge ? 14 : 12,
//       );
//     } else {
//       if (preparationSet != null) {
//         final templates = context
//             .read<MasterBloc>()
//             .state
//             .preparationTemplateItems;

//         for (var i = 0; i < templates!.length; i++) {
//           preparationDetail.add(
//             PreparationDetail(
//               assetModelId: templates[i].modelId,
//               quantityTarget: templates[i].quantity,
//               assetBrand: templates[i].assetBrand,
//               assetCategory: templates[i].assetCategory,
//               assetType: templates[i].assetType,
//               assetModel: templates[i].assetModel,
//               quantityMissing: 0,
//               quantityPicked: 0,
//               status: 'PENDING',
//             ),
//           );
//         }
//       }
//       context.pushExt(
//         SelectedPreparationDetailAssetView(
//           preparation: Preparation(
//             assigned: assigned.name,
//             assignedId: assigned.id,
//             approvedBy: approved.name,
//             approvedById: approved.id,
//             afterShipped: afterShipped,
//             destination: destination.name,
//             destinationId: destination.id,
//             notes: notes,
//           ),
//           preparationDetails: preparationDetail,
//         ),
//       );
//     }
//   }
// }
