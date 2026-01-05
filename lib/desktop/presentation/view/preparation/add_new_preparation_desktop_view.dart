import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_toast.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/entities/preparation_detail/preparation_detail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/user/user.dart';
import '../../components/app_header_desktop.dart';

class AddNewPreparationDesktopView extends StatefulWidget {
  const AddNewPreparationDesktopView({super.key});

  @override
  State<AddNewPreparationDesktopView> createState() =>
      _AddNewPreparationDesktopViewState();
}

class _AddNewPreparationDesktopViewState
    extends State<AddNewPreparationDesktopView> {
  late TextEditingController notes;
  String selectedAfterShipped = 'USE';
  Location? selectedDestination;
  User? selectedApproved;
  User? selectedWorker;

  String? selectedType;
  String? selectedCategory;
  AssetModel? selectedModel;

  late FocusNode quantityFn;
  late TextEditingController quantityC;
  late ScrollController scrollController;

  List<PreparationDetail> preparationDetails = [];

  List<String> types = ['STORE', 'USER', 'VENDOR'];

  @override
  void initState() {
    scrollController = ScrollController();
    notes = TextEditingController();
    quantityC = TextEditingController();
    quantityFn = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeaderDesktop(
          title: 'Create Preparation',
          hasPermission: false,
          withBackButton: true,
        ),
        AppBodyDesktop(
          body: Row(children: [
              
            ],
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       flex: 5,
          //       child:
          //           BlocBuilder<
          //             AddPreparationDatasCubit,
          //             AddPreparationDatasState
          //           >(
          //             builder: (context, state) {
          //               return Column(
          //                 children: [
          //                   Container(
          //                     padding: EdgeInsets.symmetric(
          //                       vertical: 16,
          //                       horizontal: 24,
          //                     ),
          //                     decoration: BoxDecoration(
          //                       color: AppColors.kWhite,
          //                       borderRadius: BorderRadius.circular(5),
          //                     ),
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Text(
          //                           'Documents',
          //                           style: TextStyle(
          //                             fontWeight: FontWeight.w500,
          //                             fontSize: 15,
          //                           ),
          //                         ),
          //                         AppSpace.vertical(24),
          //                         const Text(
          //                           "After Shipped",
          //                           style: TextStyle(
          //                             fontSize: 12,
          //                             fontWeight: FontWeight.w500,
          //                           ),
          //                         ),
          //                         AppSpace.vertical(8),
          //                         AppSegmentedDesktop(
          //                           options: ['USE', 'REPAIR'],
          //                           selected: selectedAfterShipped,
          //                           onSelected: (value) => setState(() {
          //                             selectedAfterShipped = value;
          //                           }),
          //                         ),
          //                         AppSpace.vertical(12),
          //                         AppDropDownSearch<Location>(
          //                           title: 'Destination',
          //                           hintText: 'Selected Destination',
          //                           onFind: (String filter) async =>
          //                               await context
          //                                   .read<AddPreparationDatasCubit>()
          //                                   .getLocationsForDropdown(),
          //                           borderRadius: 5,
          //                           compareFn: (value, value1) =>
          //                               value.name == value1.name,
          //                           itemAsString: (value) => value.name!,
          //                           fontSize: 10,
          //                           enabled: true,
          //                           onChanged: (value) => setState(() {
          //                             selectedDestination = value;
          //                           }),
          //                           showSearchBox: true,
          //                           selectedItem: selectedDestination,
          //                         ),
          //                         AppSpace.vertical(12),
          //                         AppDropDownSearch<User>(
          //                           title: 'Approved',
          //                           hintText: 'Selected Approved',
          //                           onFind: (String filter) async =>
          //                               await context
          //                                   .read<AddPreparationDatasCubit>()
          //                                   .getApprovedsForDropDown(),
          //                           borderRadius: 5,
          //                           compareFn: (value, value1) =>
          //                               value.name == value1.name,
          //                           itemAsString: (value) => value.name!,
          //                           fontSize: 10,
          //                           enabled: true,
          //                           onChanged: (value) => setState(() {
          //                             selectedApproved = value;
          //                           }),
          //                           showSearchBox: true,
          //                           selectedItem: selectedApproved,
          //                         ),
          //                         AppSpace.vertical(12),
          //                         AppDropDownSearch<User>(
          //                           title: 'Worker',
          //                           hintText: 'Selected Worker',
          //                           onFind: (String filter) async =>
          //                               await context
          //                                   .read<AddPreparationDatasCubit>()
          //                                   .getWorkersForDropDown(
          //                                     selectedApproved,
          //                                   ),
          //                           borderRadius: 5,
          //                           compareFn: (value, value1) =>
          //                               value.name == value1.name,
          //                           itemAsString: (value) => value.name!,
          //                           fontSize: 10,
          //                           enabled: true,
          //                           onChanged: (value) => setState(() {
          //                             selectedWorker = value;
          //                           }),
          //                           showSearchBox: true,
          //                           selectedItem: selectedWorker,
          //                         ),
          //                         AppSpace.vertical(12),
          //                         AppTextField(
          //                           title: 'Notes',
          //                           controller: notes,
          //                           fontSize: 10,
          //                           hintText: 'Notes',
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               );
          //             },
          //           ),
          //     ),
          //     AppSpace.horizontal(16),
          //     Expanded(
          //       flex: 5,
          //       child: Column(
          //         children: [
          //           Container(
          //             padding: EdgeInsets.symmetric(
          //               vertical: 16,
          //               horizontal: 24,
          //             ),
          //             decoration: BoxDecoration(
          //               color: AppColors.kWhite,
          //               borderRadius: BorderRadius.circular(5),
          //             ),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   'Selected Asset',
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 15,
          //                   ),
          //                 ),
          //                 AppSpace.vertical(24),
          //                 AppDropDownSearch<String>(
          //                   title: 'Type',
          //                   hintText: 'Selected Type',
          //                   borderRadius: 5,
          //                   fontSize: 10,
          //                   itemAsString: (value) => value,
          //                   onFind: (value) async => await context
          //                       .read<AddPreparationDatasCubit>()
          //                       .getAssetTypesForDropdown(),
          //                   compareFn: (value, value1) => value == value1,
          //                   onChanged: (value) => setState(() {
          //                     if (value == null || value != selectedType) {
          //                       selectedCategory = null;
          //                       selectedModel = null;
          //                     }
          //                     selectedType = value;
          //                   }),
          //                   selectedItem: selectedType,
          //                 ),
          //                 AppSpace.vertical(12),
          //                 AppDropDownSearch<String>(
          //                   title: 'Category',
          //                   hintText: 'Selected Category',
          //                   compareFn: (value, value1) => value == value1,
          //                   itemAsString: (value) => value,
          //                   fontSize: 10,
          //                   onFind: (value) async => context
          //                       .read<AddPreparationDatasCubit>()
          //                       .getAssetCategoriesForDropdown(selectedType),
          //                   onChanged: (value) => setState(() {
          //                     if (value == null || value != selectedCategory) {
          //                       selectedModel = null;
          //                     }
          //                     selectedCategory = value;
          //                   }),
          //                   borderRadius: 5,
          //                   selectedItem: selectedCategory,
          //                 ),
          //                 AppSpace.vertical(12),
          //                 AppDropDownSearch<AssetModel>(
          //                   title: 'Model',
          //                   hintText: 'Selected Model',
          //                   borderRadius: 5,
          //                   fontSize: 10,
          //                   selectedItem: selectedModel,
          //                   itemAsString: (value) => value.name!,
          //                   compareFn: (value, value1) => value == value1,
          //                   onFind: (value) async => await context
          //                       .read<AddPreparationDatasCubit>()
          //                       .getAssetModelsForDropdown(
          //                         selectedType,
          //                         selectedCategory,
          //                       ),
          //                   onChanged: (value) => setState(() {
          //                     selectedModel = value;
          //                     quantityFn.requestFocus();
          //                   }),
          //                 ),
          //                 AppSpace.vertical(12),
          //                 AppTextField(
          //                   title: 'Quantity',
          //                   hintText: 'Quantity',
          //                   controller: quantityC,
          //                   focusNode: quantityFn,
          //                   fontSize: 10,
          //                   onSubmitted: (_) {
          //                     quantityFn.previousFocus();
          //                     // _add();
          //                   },
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     AppSpace.horizontal(16),
          //     Expanded(
          //       flex: 4,
          //       child: Column(
          //         children: [
          //           Expanded(
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 color: AppColors.kWhite,
          //                 borderRadius: BorderRadius.circular(5),
          //               ),
          //               child: preparationDetails.isEmpty
          //                   ? Center(child: Text('Asset still empty'))
          //                   : Scrollbar(
          //                       thumbVisibility: true,
          //                       controller: scrollController,
          //                       thickness: 5,
          //                       radius: const Radius.circular(10),
          //                       child: ListView.builder(
          //                         controller: scrollController,
          //                         padding: EdgeInsets.fromLTRB(6, 12, 14, 0),
          //                         itemCount: preparationDetails.length,
          //                         itemBuilder: (context, index) {
          //                           final preparationDetail =
          //                               preparationDetails[index];
          //                           return Container(
          //                             margin: EdgeInsets.only(bottom: 16),
          //                             padding: EdgeInsets.all(12),
          //                             decoration: BoxDecoration(
          //                               color: AppColors.kWhite,
          //                               borderRadius: BorderRadius.circular(5),
          //                               border: Border.all(
          //                                 color: AppColors.kBase,
          //                               ),
          //                             ),
          //                             child: Column(
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.start,
          //                               children: [
          //                                 Text(
          //                                   preparationDetail.assetModel!,
          //                                   style: TextStyle(
          //                                     fontSize: 12,
          //                                     fontWeight: FontWeight.w600,
          //                                   ),
          //                                 ),
          //                                 AppSpace.vertical(4),
          //                                 Text(
          //                                   '${preparationDetail.assetCategory} - ${preparationDetail.assetType} ',
          //                                   style: TextStyle(fontSize: 10),
          //                                 ),
          //                                 AppSpace.vertical(10),
          //                                 Row(
          //                                   mainAxisAlignment:
          //                                       MainAxisAlignment.spaceBetween,
          //                                   children: [
          //                                     Material(
          //                                       color: AppColors.kRed,
          //                                       borderRadius:
          //                                           BorderRadius.circular(3),
          //                                       child: InkWell(
          //                                         borderRadius:
          //                                             BorderRadius.circular(3),
          //                                         onTap: () => setState(() {
          //                                           preparationDetails
          //                                               .removeWhere(
          //                                                 (element) =>
          //                                                     element
          //                                                         .assetModelId ==
          //                                                     preparationDetail
          //                                                         .assetModelId,
          //                                               );
          //                                         }),
          //                                         child: Container(
          //                                           padding:
          //                                               const EdgeInsets.all(
          //                                                 5.0,
          //                                               ),
          //                                           decoration: BoxDecoration(
          //                                             borderRadius:
          //                                                 BorderRadius.circular(
          //                                                   3,
          //                                                 ),
          //                                           ),
          //                                           child: Icon(
          //                                             Icons.delete,
          //                                             size: 10,
          //                                             color: AppColors.kWhite,
          //                                           ),
          //                                         ),
          //                                       ),
          //                                     ),
          //                                     Row(
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment.end,
          //                                       children: [
          //                                         Material(
          //                                           color:
          //                                               preparationDetail
          //                                                       .quantityTarget ==
          //                                                   1
          //                                               ? AppColors.kGrey
          //                                               : AppColors.kBase,
          //                                           borderRadius:
          //                                               BorderRadius.circular(
          //                                                 3,
          //                                               ),
          //                                           child: InkWell(
          //                                             borderRadius:
          //                                                 BorderRadius.circular(
          //                                                   3,
          //                                                 ),
          //                                             onTap:
          //                                                 preparationDetail
          //                                                         .quantityTarget ==
          //                                                     1
          //                                                 ? null
          //                                                 : () => setState(() {
          //                                                     preparationDetail
          //                                                             .quantityTarget =
          //                                                         preparationDetail
          //                                                             .quantityTarget! -
          //                                                         1;
          //                                                   }),
          //                                             child: Container(
          //                                               padding:
          //                                                   const EdgeInsets.all(
          //                                                     5.0,
          //                                                   ),
          //                                               decoration: BoxDecoration(
          //                                                 borderRadius:
          //                                                     BorderRadius.circular(
          //                                                       3,
          //                                                     ),
          //                                               ),
          //                                               child: Icon(
          //                                                 Icons.remove,
          //                                                 size: 10,
          //                                                 color:
          //                                                     AppColors.kWhite,
          //                                               ),
          //                                             ),
          //                                           ),
          //                                         ),
          //                                         SizedBox(
          //                                           width: 50,
          //                                           child: Center(
          //                                             child: Text(
          //                                               preparationDetail
          //                                                   .quantityTarget
          //                                                   .toString(),
          //                                               style: TextStyle(
          //                                                 fontSize: 12,
          //                                                 fontWeight:
          //                                                     FontWeight.w500,
          //                                               ),
          //                                             ),
          //                                           ),
          //                                         ),
          //                                         Material(
          //                                           color: AppColors.kBase,
          //                                           borderRadius:
          //                                               BorderRadius.circular(
          //                                                 3,
          //                                               ),
          //                                           child: InkWell(
          //                                             borderRadius:
          //                                                 BorderRadius.circular(
          //                                                   3,
          //                                                 ),
          //                                             onTap: () => setState(() {
          //                                               preparationDetail
          //                                                       .quantityTarget =
          //                                                   preparationDetail
          //                                                       .quantityTarget! +
          //                                                   1;
          //                                             }),
          //                                             child: Container(
          //                                               padding:
          //                                                   const EdgeInsets.all(
          //                                                     5.0,
          //                                                   ),
          //                                               decoration: BoxDecoration(
          //                                                 borderRadius:
          //                                                     BorderRadius.circular(
          //                                                       3,
          //                                                     ),
          //                                               ),
          //                                               child: Icon(
          //                                                 Icons.add,
          //                                                 size: 10,
          //                                                 color:
          //                                                     AppColors.kWhite,
          //                                               ),
          //                                             ),
          //                                           ),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ],
          //                                 ),
          //                               ],
          //                             ),
          //                           );
          //                         },
          //                       ),
          //                     ),
          //             ),
          //           ),
          //           AppSpace.vertical(24),
          //           AppButton(
          //             height: 35,
          //             width: context.deviceWidth,
          //             onPressed: () => _addPreparation(),
          //             fontSize: 12,
          //             title: 'Add Preparation',
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ],
    );
  }

  _addPreparation() {
    final afterShipped = selectedAfterShipped;
    final destination = selectedDestination;
    final approved = selectedApproved;
    final worker = selectedWorker;
    final desc = notes.value.text;
    final prepDetails = preparationDetails;

    if (destination == null) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Destination cannot be empty',
      );
    } else if (approved == null) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Approved cannot be empty',
      );
    } else if (worker == null) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Destination cannot be empty',
      );
    } else if (prepDetails.isEmpty) {
      AppToast.show(
        context: context,
        type: ToastType.error,
        message: 'Asset cannot be empty',
      );
    } else {
      final totalAsset = prepDetails.length;
      final totalQuantity = prepDetails
          .map((e) => e.quantityTarget ?? 0)
          .fold(0, (a, b) => a + b);

      context.showDialogConfirm(
        title: 'Add Preparation ?',
        content:
            'Destination : ${destination.name}\nAfter Shipped : $afterShipped\nApproved : ${approved.name}\nWorker : ${worker.name}\nNotes : $desc\nTotal Asset : $totalAsset\nTotal Quantity : $totalQuantity',
        onCancel: () => context.pop(),
        fontSize: 12,
        onCancelText: 'No',
        onConfirmText: 'Add',
        onConfirm: () {},
      );
    }
  }

  // _add() {
  //   final model = selectedModel;
  //   final quantityText = quantityC.value.text.trim();

  //   if (model == null) {
  //     AppToast.show(
  //       context: context,
  //       message: 'Asset not yet selected',
  //       type: ToastType.error,
  //     );
  //   } else if (quantityText.isEmpty) {
  //     AppToast.show(
  //       context: context,
  //       message: 'Quantity cannot be empty',
  //       type: ToastType.error,
  //     );
  //   } else if (!quantityText.isNumber()) {
  //     AppToast.show(
  //       context: context,
  //       message: 'Quantity not valid (must be a number)',
  //       type: ToastType.error,
  //     );
  //   } else {
  //     final newQuantity = int.tryParse(quantityText);

  //     if (newQuantity == null || newQuantity < 1) {
  //       AppToast.show(
  //         context: context,
  //         message: 'Quantity not valid (must be >= 1)',
  //         type: ToastType.error,
  //       );
  //       return;
  //     }

  //     final existingItemIndex = preparationDetails.indexWhere(
  //       (item) => item.assetModelId == selectedModel!.id,
  //     );

  //     setState(() {
  //       if (existingItemIndex != -1) {
  //         final existingItem = preparationDetails[existingItemIndex];

  //         final updatedItem = existingItem.copyWith(
  //           quantityTarget: existingItem.quantityTarget! + newQuantity,
  //         );

  //         preparationDetails[existingItemIndex] = updatedItem;

  //         AppToast.show(
  //           context: context,
  //           message: 'Quantity added to existing asset model',
  //           type: ToastType.success,
  //         );
  //       } else {
  //         preparationDetails.add(
  //           PreparationDetail(
  //             assetModelId: selectedModel!.id,
  //             assetType: selectedModel!.typeName,
  //             assetBrand: selectedModel!.brandName,
  //             assetCategory: selectedModel!.categoryName,
  //             assetModel: selectedModel!.name,
  //             quantityTarget: newQuantity,
  //           ),
  //         );
  //         AppToast.show(
  //           context: context,
  //           message: 'New asset model added',
  //           type: ToastType.success,
  //         );
  //       }
  //       quantityC.clear();
  //       selectedModel = null;
  //     });
  //   }
  // }
}
