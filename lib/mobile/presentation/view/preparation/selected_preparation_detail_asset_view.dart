// import 'package:asset_management/core/core.dart';
// import 'package:asset_management/core/widgets/app_dropdown_search.dart';
// import 'package:asset_management/domain/entities/master/asset_category.dart';
// import 'package:asset_management/domain/entities/master/asset_model.dart';
// import 'package:asset_management/domain/entities/preparation/preparation.dart';
// import 'package:asset_management/domain/entities/preparation_detail/preparation_detail.dart';
// import 'package:asset_management/mobile/presentation/bloc/master/master_bloc.dart';
// import 'package:asset_management/mobile/presentation/view/preparation/create_preparation_detail_review_view.dart';
// import 'package:asset_management/mobile/responsive_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SelectedPreparationDetailAssetView extends StatefulWidget {
//   final Preparation preparation;
//   final List<PreparationDetail> preparationDetails;

//   const SelectedPreparationDetailAssetView({
//     super.key,
//     required this.preparation,
//     required this.preparationDetails,
//   });

//   @override
//   State<SelectedPreparationDetailAssetView> createState() =>
//       _SelectedPreparationDetailAssetViewState();
// }

// class _SelectedPreparationDetailAssetViewState
//     extends State<SelectedPreparationDetailAssetView> {
//   AssetModel? assetModel;
//   AssetCategory? assetCategory;
//   late TextEditingController quantityC;

//   @override
//   void initState() {
//     quantityC = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     quantityC.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveLayout(
//       mobileLScaffold: _mobileSelectedPreparationDetailAsset(),
//       mobileMScaffold: _mobileSelectedPreparationDetailAsset(isLarge: false),
//     );
//   }

//   Widget _mobileSelectedPreparationDetailAsset({bool isLarge = true}) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Selected Asset')),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(16),
//         child: AppButton(
//           title: 'Review',
//           width: context.deviceWidth,
//           fontSize: isLarge ? 16 : 14,
//           onPressed: () {
//             if (widget.preparationDetails == []) {
//               context.showSnackbar(
//                 'No assets have been selected yet',
//                 backgroundColor: AppColors.kRed,
//                 fontSize: isLarge ? 14 : 12,
//               );
//             } else {
//               context.pushExt(
//                 CreatePreparationDetailReviewView(
//                   preparation: widget.preparation,
//                   preparationDetails: widget.preparationDetails,
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               AppSpace.vertical(16),
//               BlocBuilder<MasterBloc, MasterState>(
//                 builder: (context, state) {
//                   return AppDropDownSearch<AssetCategory>(
//                     title: 'Category',
//                     fontSize: isLarge ? 14 : 12,
//                     items: state.categories ?? [],
//                     hintText: 'Selected Category',
//                     compareFn: (value, value1) => value.id == value1.id,
//                     itemAsString: (value) => value.name!,
//                     onChanged: (value) => setState(() {
//                       assetCategory = value;
//                     }),
//                     selectedItem: assetCategory,
//                   );
//                 },
//               ),
//               AppSpace.vertical(16),
//               BlocBuilder<MasterBloc, MasterState>(
//                 builder: (context, state) {
//                   return AppDropDownSearch<AssetModel>(
//                     title: 'Model',
//                     fontSize: isLarge ? 14 : 12,
//                     items: assetCategory == null
//                         ? []
//                         : state.models
//                                   ?.where(
//                                     (element) =>
//                                         element.categoryId == assetCategory?.id,
//                                   )
//                                   .toList() ??
//                               [],
//                     hintText: 'Selected Model',
//                     compareFn: (value, value1) => value.id == value1.id,
//                     itemAsString: (value) => value.name!,
//                     onChanged: (value) => setState(() {
//                       assetModel = value;
//                     }),
//                     selectedItem: assetModel,
//                   );
//                 },
//               ),
//               AppSpace.vertical(16),
//               AppTextField(
//                 controller: quantityC,
//                 fontSize: isLarge ? 14 : 12,
//                 hintText: 'Example : 1',
//                 title: 'Quantity',
//                 textInputAction: TextInputAction.go,
//                 keyboardType: TextInputType.number,
//                 onSubmitted: (_) => _add(isLarge),
//               ),
//               AppSpace.vertical(32),
//               AppButton(
//                 title: 'Add',
//                 fontSize: isLarge ? 16 : 14,
//                 width: context.deviceWidth,
//                 onPressed: () => _add(isLarge),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _add(bool isLarge) {
//     final selectedModel = assetModel;
//     final quantityText = quantityC.value.text.trim();

//     if (selectedModel == null) {
//       context.showSnackbar(
//         'Asset Model not yet selected',
//         backgroundColor: AppColors.kRed,
//         fontSize: isLarge ? 14 : 12,
//       );
//     } else if (quantityText.isEmpty) {
//       context.showSnackbar(
//         'Quantity cannot be empty',
//         backgroundColor: AppColors.kRed,
//         fontSize: isLarge ? 14 : 12,
//       );
//     } else if (!quantityText.isNumber()) {
//       context.showSnackbar(
//         'Quantity not valid (must be a number)',
//         fontSize: isLarge ? 14 : 12,
//         backgroundColor: AppColors.kRed,
//       );
//     } else {
//       final newQuantity = int.tryParse(quantityText);

//       if (newQuantity == null || newQuantity < 1) {
//         context.showSnackbar(
//           'Quantity not valid (must be >= 1)',
//           fontSize: isLarge ? 14 : 12,
//           backgroundColor: AppColors.kRed,
//         );
//         return;
//       }

//       final existingItemIndex = widget.preparationDetails.indexWhere(
//         (item) => item.assetModelId == selectedModel.id,
//       );

//       setState(() {
//         if (existingItemIndex != -1) {
//           final existingItem = widget.preparationDetails[existingItemIndex];

//           final updatedItem = existingItem.copyWith(
//             quantityTarget: existingItem.quantityTarget! + newQuantity,
//           );

//           widget.preparationDetails[existingItemIndex] = updatedItem;

//           context.showSnackbar(
//             'Quantity added to existing asset model',
//             fontSize: isLarge ? 14 : 12,
//             backgroundColor: AppColors.kBase,
//           );
//         } else {
//           widget.preparationDetails.add(
//             PreparationDetail(
//               assetModelId: selectedModel.id,
//               assetType: selectedModel.typeName,
//               assetBrand: selectedModel.brandName,
//               assetCategory: selectedModel.categoryName,
//               assetModel: selectedModel.name,
//               quantityTarget: newQuantity,
//             ),
//           );
//           context.showSnackbar(
//             'New asset model added',
//             fontSize: isLarge ? 14 : 12,
//             backgroundColor: AppColors.kBase,
//           );
//         }
//         quantityC.clear();
//         assetCategory = null;
//         assetModel = null;
//       });
//     }
//   }
// }
