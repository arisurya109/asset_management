// import 'package:asset_management/core/core.dart';
// import 'package:asset_management/mobile/presentation/bloc/picking/picking_bloc.dart';
// import 'package:asset_management/mobile/presentation/components/app_card_item.dart';
// import 'package:asset_management/mobile/presentation/view/picking/picking_list_detail_view.dart';
// import 'package:asset_management/mobile/responsive_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PickingView extends StatelessWidget {
//   const PickingView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveLayout(
//       mobileLScaffold: _mobilePicking(context),
//       mobileMScaffold: _mobilePicking(context, isLarge: false),
//     );
//   }

//   Widget _mobilePicking(BuildContext context, {bool isLarge = true}) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Picking')),
//       body: BlocBuilder<PickingBloc, PickingState>(
//         builder: (context, state) {
//           if (state.status == StatusPicking.loading) {
//             return Center(
//               child: CircularProgressIndicator(color: AppColors.kBase),
//             );
//           }
//           if (state.preparations == null || state.preparations!.isEmpty) {
//             return Center(child: Text('No task picking'));
//           }

//           if (state.preparations!.isEmpty) {
//             return Center(child: Text('No task picking'));
//           }

//           return ListView.builder(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             itemCount: state.preparations?.length,
//             itemBuilder: (context, index) {
//               final preparation = state.preparations![index];
//               return BlocListener<PickingBloc, PickingState>(
//                 listener: (context, state) {
//                   if (state.status == StatusPicking.failedStartPicking) {
//                     context.showSnackbar(
//                       state.message ?? 'Failed to start picking',
//                     );
//                   }

//                   if (state.status == StatusPicking.successStartPicking) {
//                     context.showSnackbar(
//                       state.message ?? 'Successfully start picking',
//                     );
//                     context.read<PickingBloc>().add(
//                       OnFindPickingTaskDetail(preparation.id!),
//                     );
//                     context.pushExt(PickingListDetailView());
//                   }
//                 },
//                 child: AppCardItem(
//                   title: preparation.preparationCode,
//                   leading: preparation.status,
//                   subtitle: preparation.destination,
//                   noDescription: true,
//                   fontSize: isLarge ? 14 : 12,
//                   onTap: preparation.status == 'ASSIGNED'
//                       ? () {
//                           context.showDialogConfirm(
//                             title: 'Start Picking',
//                             content: 'Are you sure start picking ?',
//                             onCancelText: 'No',
//                             onConfirmText: 'Yes',
//                             fontSize: isLarge ? 14 : 12,
//                             onCancel: () => context.popExt(),
//                             onConfirm: () {
//                               context.read<PickingBloc>().add(
//                                 OnStartPicking(preparation.id!),
//                               );
//                               context.popExt();
//                             },
//                           );
//                         }
//                       : () {
//                           context.read<PickingBloc>().add(
//                             OnFindPickingTaskDetail(preparation.id!),
//                           );
//                           context.pushExt(PickingListDetailView());
//                         },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
