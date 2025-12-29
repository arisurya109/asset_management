import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/mobile/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/picking/picking_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_card_item.dart';
import 'package:asset_management/mobile/presentation/view/picking/picking_item_view.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text('Pick List')),
      bottomNavigationBar: BlocBuilder<PickingBloc, PickingState>(
        builder: (context, state) {
          final preparationDetails = state.preparationDetails;

          if (state.status == StatusPicking.loading) {
            return SizedBox();
          }

          if (preparationDetails
                  ?.where((element) => element.status == 'COMPLETED')
                  .toList()
                  .length !=
              preparationDetails?.length) {
            return SizedBox();
          }

          if (state.preparation?.status == 'READY') {
            return SizedBox();
          }

          return Padding(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            final totalBox = totalBoxC.text.trim();
                            final tempLocation = temporaryLocationC.text.trim();

                            // VALIDASI DULU
                            if (!totalBox.isFilled() || !totalBox.isNumber()) {
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
                                context.read<MasterBloc>().state.locations ??
                                [];

                            final location = locations.firstWhere(
                              (element) =>
                                  (element.name ?? '').toLowerCase().trim() ==
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

                            context.popExt();

                            context.read<PickingBloc>().add(
                              OnSubmitReadyPreparation(
                                state.preparation!.id!,
                                location.id!,
                                int.parse(totalBox),
                                context
                                    .read<AuthenticationBloc>()
                                    .state
                                    .user!
                                    .id!,
                              ),
                            );
                          },
                          child: Text('Submit'),
                        ),
                        TextButton(
                          onPressed: () => context.popExt(),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: AppColors.kRed),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              fontSize: isLarge ? 16 : 14,
            ),
          );
        },
      ),

      body: BlocConsumer<PickingBloc, PickingState>(
        listener: (context, state) {
          if (state.status == StatusPicking.failedReadyPreparation) {
            context.popExt();
            context.showSnackbar(
              state.message ?? 'Failed completed pick list',
              backgroundColor: AppColors.kRed,
            );
          }
          if (state.status == StatusPicking.successReadyPreparation) {
            totalBoxC.clear();
            temporaryLocationC.clear();
            context.popExt();
            context.showSnackbar(state.message ?? 'Successfully picking');
          }
        },
        builder: (context, state) {
          if (state.status == StatusPicking.loading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.kBase),
            );
          }
          final preparation = state.preparation;
          final preparationDetails = state.preparationDetails;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SizedBox(
                  width: context.deviceWidth,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.deviceWidth / 1.3 - 36,
                        child: _descriptionItem(
                          'Destination',
                          preparation?.destination,
                          isLarge,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: _descriptionItem(
                            'Notes',
                            preparation?.notes,
                            isLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSpace.vertical(16),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: preparationDetails?.length,
                  itemBuilder: (context, index) {
                    final preparationDetail = preparationDetails![index];
                    return AppCardItem(
                      onTap: () {
                        context.read<PickingBloc>().add(
                          OnFindItemPickingDetail(preparationDetail.id!),
                        );
                        context.pushExt(PickingItemView());
                      },
                      fontSize: isLarge ? 14 : 12,
                      title: preparationDetail.assetModel,
                      leading: preparationDetail.status,
                      subtitle:
                          '${preparationDetail.assetCategory} - ${preparationDetail.assetType}',
                      descriptionLeft:
                          'Picked : ${preparationDetail.quantityPicked}',
                      descriptionRight:
                          'Target : ${preparationDetail.quantityTarget}',
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
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
