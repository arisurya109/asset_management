import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation_detail/preparation_detail_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation_item/preparation_item_bloc.dart';
import 'package:asset_management/presentation/components/app_card_item.dart';
import 'package:asset_management/presentation/view/picking/picking_item_view.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickingListDetailView extends StatefulWidget {
  const PickingListDetailView({super.key});

  @override
  State<PickingListDetailView> createState() => _PickingListDetailViewState();
}

class _PickingListDetailViewState extends State<PickingListDetailView> {
  late TextEditingController totalBoxC;
  late TextEditingController temporaryLocationC;

  @override
  void initState() {
    totalBoxC = TextEditingController();
    temporaryLocationC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    totalBoxC.dispose();
    temporaryLocationC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePickingDetailList(),
      mobileMScaffold: _mobilePickingDetailList(isLarge: false),
    );
  }

  Widget _mobilePickingDetailList({bool isLarge = true}) {
    return BlocBuilder<PreparationDetailBloc, PreparationDetailState>(
      builder: (context, state) {
        final preparationDetails = state.preparationDetails;

        if (state.status == StatusPreparationDetail.loading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.kBase),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text('Pick List')),
          bottomNavigationBar:
              preparationDetails
                      ?.where((element) => element.status == 'COMPLETED')
                      .toList()
                      .length ==
                  preparationDetails?.length
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: AppButton(
                    title: 'Submit',
                    onPressed: () {
                      context.showDialogOption(
                        title: 'Submit Pick List',
                        children: [
                          AppSpace.vertical(16),
                          AppTextField(
                            controller: totalBoxC,
                            noTitle: true,
                            hintText: 'Total Box',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            fontSize: isLarge ? 14 : 12,
                          ),
                          AppSpace.vertical(16),
                          AppTextField(
                            controller: temporaryLocationC,
                            noTitle: true,
                            hintText: 'Location',
                            textInputAction: TextInputAction.go,
                            keyboardType: TextInputType.text,
                            fontSize: isLarge ? 14 : 12,
                          ),
                          AppSpace.vertical(24),
                          BlocListener<PreparationBloc, PreparationState>(
                            listener: (context, state) {
                              if (state.status == StatusPreparation.failed) {
                                context.showSnackbar(
                                  'Failed completed pick list',
                                  backgroundColor: AppColors.kRed,
                                );
                              }
                              if (state.status == StatusPreparation.success) {
                                totalBoxC.clear();
                                temporaryLocationC.clear();
                                context.pop();
                                context.showSnackbar('Successfully picking');
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    final totalBox = totalBoxC.text.trim();
                                    final tempLocation = temporaryLocationC.text
                                        .trim();

                                    // VALIDASI DULU
                                    if (!totalBox.isFilled() ||
                                        !totalBox.isNumber()) {
                                      context.showSnackbar(
                                        'Total box cannot be empty',
                                        backgroundColor: AppColors.kRed,
                                        fontSize: isLarge ? 14 : 12,
                                      );
                                      return;
                                    }

                                    if (!tempLocation.isFilled()) {
                                      context.showSnackbar(
                                        'Temporary Location cannot be empty',
                                        backgroundColor: AppColors.kRed,
                                        fontSize: isLarge ? 14 : 12,
                                      );
                                      return;
                                    }

                                    final locations =
                                        context
                                            .read<MasterBloc>()
                                            .state
                                            .locations ??
                                        [];

                                    final location = locations.firstWhere(
                                      (element) =>
                                          (element.name ?? '')
                                              .toLowerCase()
                                              .trim() ==
                                          tempLocation.toLowerCase(),
                                      orElse: () =>
                                          Location(), // dummy, nanti dicek kosongnya
                                    );

                                    // kalau dummy → berarti tidak ditemukan
                                    if (location.id == null) {
                                      context.showSnackbar(
                                        'Location not found',
                                        backgroundColor: AppColors.kRed,
                                      );
                                      return;
                                    }

                                    // CLOSE DIALOG SETELAH VALID
                                    context.pop();

                                    // PROSES UPDATE
                                    final preparation = context
                                        .read<PreparationBloc>()
                                        .state
                                        .preparation;

                                    context.read<PreparationBloc>().add(
                                      OnUpdatePreparationEvent(
                                        preparation!.copyWith(
                                          temporaryLocationId: location.id,
                                          totalBox: int.parse(totalBox),
                                          status: 'READY',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Submit'),
                                ),
                                TextButton(
                                  onPressed: () => context.pop(),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: AppColors.kRed),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    fontSize: isLarge ? 16 : 14,
                  ),
                )
              : null,
          body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: preparationDetails?.length,
            itemBuilder: (context, index) {
              final preparationDetail = preparationDetails![index];
              return AppCardItem(
                onTap: () {
                  context.read<PreparationDetailBloc>().add(
                    OnFindPreparationDetailById(
                      preparationDetail.id!,
                      preparationDetail.preparationId!,
                    ),
                  );

                  context.read<PreparationItemBloc>().add(
                    OnFindAllPreparationItemsByPreparationDetailId(
                      preparationDetail.id!,
                      preparationDetail.preparationId!,
                    ),
                  );

                  context.push(PickingItemView());
                },
                fontSize: isLarge ? 14 : 12,
                title: preparationDetail.assetModel,
                leading: preparationDetail.status,
                subtitle:
                    '${preparationDetail.assetCategory} - ${preparationDetail.assetType}',
                descriptionLeft: 'Picked : ${preparationDetail.quantityPicked}',
                descriptionRight:
                    'Target : ${preparationDetail.quantityTarget}',
              );
            },
          ),
        );
      },
    );
  }
}
