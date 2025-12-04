import 'dart:io';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation_item/preparation_item.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/presentation/view/preparation/components/preparation_component_fnc.dart';
import 'package:asset_management/presentation/view/preparation/preparation_detail_item_view.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';

class PreparationDetailView extends StatefulWidget {
  const PreparationDetailView({super.key});

  @override
  State<PreparationDetailView> createState() => _PreparationDetailViewState();
}

class _PreparationDetailViewState extends State<PreparationDetailView> {
  PlatformFile? filePdf;
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePreparationDetail(context),
      mobileMScaffold: _mobilePreparationDetail(context, isLarge: false),
    );
  }

  Widget _mobilePreparationDetail(BuildContext context, {bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preparation Detail'),
        actions: [
          // BlocBuilder<PreparationBloc, PreparationState>(
          //   builder: (context, state) {
          //     if (state.preparation?.status == 'READY' ||
          //         state.preparation?.status == 'PARTIALLY READY') {
          //       // final items = context
          //       //     .watch<PreparationItemBloc>()
          //       //     .state
          //       //     .allItemPreparation;
          //       return IconButton(
          //         onPressed: () async =>
          //             await exportExcel(state.preparation!, items!),
          //         icon: Icon(Icons.download),
          //       );
          //     }
          //     return Container();
          //   },
          // ),
        ],
      ),
      floatingActionButton: BlocConsumer<PreparationBloc, PreparationState>(
        listener: (context, state) {
          if (state.status == StatusPreparation.updatePreparation) {
            context.showSnackbar(
              state.message ?? 'Successfully update preparation',
              fontSize: isLarge ? 14 : 12,
            );
          }
          if (state.status == StatusPreparation.failure) {
            context.showSnackbar(
              state.message ?? 'Please try again',
              backgroundColor: AppColors.kRed,
              fontSize: isLarge ? 14 : 12,
            );
          }
        },
        builder: (context, state) {
          final preparation = context
              .watch<PreparationBloc>()
              .state
              .preparation
              ?.status;
          if (state.status == StatusPreparation.loading ||
              state.preparation == null) {
            return SizedBox();
          }
          if (preparation == 'DRAFT') {
            return Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    width: (context.deviceWidth / 2) - 36,
                    title: 'Cancel',
                    fontSize: isLarge ? 16 : 14,
                    backgroundColor: AppColors.kRed,
                    onPressed: () {
                      context.read<PreparationBloc>().add(
                        OnUpdateStatusPreparation(
                          state.preparation!.id!,
                          'CANCELLED',
                        ),
                      );
                    },
                  ),
                  AppButton(
                    width: (context.deviceWidth / 2) - 36,
                    title: 'Assigned',
                    fontSize: isLarge ? 16 : 14,
                    onPressed: () {
                      context.pop();
                      context.read<PreparationBloc>().add(
                        OnUpdateStatusPreparation(
                          state.preparation!.id!,
                          'ASSIGNED',
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          if (preparation == 'READY' &&
              state.preparation!.approvedById ==
                  context.read<AuthenticationBloc>().state.user!.id!) {
            return AppButton(
              width: context.deviceWidth - 32,
              fontSize: isLarge ? 16 : 14,
              title: 'Approved',
              onPressed: () {
                // context.read<PreparationBloc>().add(
                //   OnDispatchPreparationEvent(
                //     state.preparation!.copyWith(status: 'DISPATCHED'),
                //   ),
                // );
              },
            );
          }

          if (preparation == 'DISPATCHED') {
            return AppButton(
              width: context.deviceWidth - 32,
              fontSize: isLarge ? 16 : 14,
              title: 'Upload',
              onPressed: () {
                if (filePdf == null) {
                  context.showSnackbar(
                    'Please select document',
                    backgroundColor: AppColors.kRed,
                  );
                } else {
                  // context.read<PreparationBloc>().add(
                  //   OnCompletedPreparationEvent(
                  //     filePdf!,
                  //     state.preparation!.copyWith(status: 'COMPLETED'),
                  //   ),
                  // );
                }
              },
            );
          }
          return SizedBox();
        },
      ),
      body: BlocBuilder<PreparationBloc, PreparationState>(
        builder: (context, state) {
          if (state.status == StatusPreparation.loading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.kBase),
            );
          }
          final preparationDetails = state.preparationDetails;
          final preparation = context.read<PreparationBloc>().state.preparation;
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              _descriptionPreparationDetail(isLarge),
              AppSpace.vertical(16),
              (preparation?.status == 'DISPATCHED')
                  ? Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            final result =
                                await PreparationComponentFnc.pickedFilePdf();

                            if (result != null) {
                              setState(() {
                                filePdf = result;
                              });
                            }
                          },
                          child: Container(
                            width: context.deviceWidth,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              border: BoxBorder.all(color: AppColors.kBase),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: filePdf == null
                                ? Center(
                                    child: Text('Tap to selected documents'),
                                  )
                                : Text(filePdf!.name),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: preparationDetails!.length,
                      itemBuilder: (context, index) {
                        final preparationDetail = preparationDetails[index];
                        return Padding(
                          padding:
                              context
                                      .read<PreparationBloc>()
                                      .state
                                      .preparation
                                      ?.status ==
                                  'DRAFT'
                              ? EdgeInsets.only(
                                  bottom: preparationDetails.length - 1 == index
                                      ? 74
                                      : 0,
                                )
                              : EdgeInsets.zero,
                          child: AppCardItem(
                            fontSize: isLarge ? 14 : 12,
                            title: preparationDetail.assetModel,
                            leading: preparationDetail.status,
                            onTap: preparationDetail.status != 'PENDING'
                                ? () {
                                    context.read<PreparationBloc>().add(
                                      OnFindItemByPreparationDetail(
                                        preparationDetail.id!,
                                      ),
                                    );
                                    context.push(PreparationDetailItemView());
                                  }
                                : null,
                            subtitle:
                                '${preparationDetail.assetCategory} - ${preparationDetail.assetType}',
                            noDescription: true,
                          ),
                        );
                      },
                    ),
            ],
          );
        },
      ),
    );
  }

  Future<void> exportExcel(
    Preparation preparation,
    List<PreparationItem> items,
  ) async {
    final excel = Excel.createExcel();
    final sheet = excel[preparation.preparationCode!];

    sheet.merge(CellIndex.indexByString('A1'), CellIndex.indexByString('D3'));

    final cell = sheet.cell(CellIndex.indexByString('A1'));
    cell.value = TextCellValue('Destination : ${preparation.destination}');

    // Set alignment ke tengah horizontal dan vertical
    cell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
      fontFamily: getFontFamily(FontFamily.Calibri),
    );

    var a4 = sheet.cell(CellIndex.indexByString('A4'));
    var b4 = sheet.cell(CellIndex.indexByString('B4'));
    a4.value = TextCellValue('Notes :');
    b4.value = TextCellValue(preparation.notes ?? '');

    var a5 = sheet.cell(CellIndex.indexByString('A5'));
    var b5 = sheet.cell(CellIndex.indexByString('B5'));
    a5.value = TextCellValue('Location :');
    b5.value = TextCellValue(preparation.temporaryLocation ?? '');

    var a6 = sheet.cell(CellIndex.indexByString('A6'));
    var b6 = sheet.cell(CellIndex.indexByString('B6'));

    a6.value = TextCellValue('Total Box :');
    b6.value = IntCellValue(preparation.totalBox!);

    sheet.cell(CellIndex.indexByString('A7'));
    sheet.cell(CellIndex.indexByString('B7'));
    sheet.cell(CellIndex.indexByString('A8'));
    sheet.cell(CellIndex.indexByString('B8'));

    const headerStartRow = 8;
    const dataStartRow = headerStartRow + 1;

    // Header manual dengan styling
    final headers = [
      'No',
      'Asset Code',
      'Model',
      'Category',
      'Brand',
      'Type',
      'Quantity',
    ];
    for (var col = 0; col < headers.length; col++) {
      final cell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: col, rowIndex: headerStartRow),
      );
      cell.value = TextCellValue(headers[col]);
      cell.cellStyle = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        bold: true,
      );
    }

    // Data mulai dari baris ke-10
    for (var i = 0; i < items.length; i++) {
      final rowIndex = dataStartRow + i;
      final rowData = [
        IntCellValue(i + 1),
        TextCellValue(items[i].assetCode ?? ''),
        TextCellValue(items[i].assetModel ?? ''),
        TextCellValue(items[i].assetCategory ?? ''),
        TextCellValue(items[i].assetBrand ?? ''),
        TextCellValue(items[i].assetType ?? ''),
        IntCellValue(items[i].quantity ?? 0),
      ];

      for (var col = 0; col < rowData.length; col++) {
        final cell = sheet.cell(
          CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
        );
        cell.value = rowData[col];
        cell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);
      }
    }

    var dir = Directory('/storage/emulated/0/Download');
    final filePath = '${dir.path}/${preparation.preparationCode}.xlsx';
    final fileBytes = excel.save();
    final file = File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    debugPrint('Exported to ::::: $filePath');

    await OpenFile.open(file.path);
  }

  Widget _descriptionPreparationDetail(bool isLarge) {
    return BlocSelector<PreparationBloc, PreparationState, Preparation>(
      selector: (state) {
        return state.preparation!;
      },
      builder: (context, state) {
        final preparation = state;
        return SizedBox(
          width: context.deviceWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.deviceWidth / 1.3 - 36,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _descriptionItem(
                      'Code',
                      preparation.preparationCode!,
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Condition Asset',
                      preparation.assetConditionAfter,
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Status Asset',
                      preparation.assetStatusAfter,
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem('Notes', preparation.notes, isLarge),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _descriptionItem(
                      'Destination',
                      preparation.destination ?? '',
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Status',
                      preparation.status ?? '',
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Approved',
                      preparation.approvedBy ?? '',
                      isLarge,
                    ),
                    AppSpace.vertical(12),
                    _descriptionItem(
                      'Worker',
                      preparation.assigned ?? '',
                      isLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _descriptionItem(String title, String? value, bool isLarge) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isLarge ? 14 : 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppSpace.vertical(3),
        Text(
          value == null
              ? '-'
              : value.isEmpty
              ? '-'
              : value,
          style: TextStyle(
            fontSize: isLarge ? 14 : 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
