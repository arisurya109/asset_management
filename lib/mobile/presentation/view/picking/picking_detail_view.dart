import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/mobile/presentation/bloc/picking/picking_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/picking_detail/picking_detail_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_card_item.dart';
import 'package:asset_management/mobile/presentation/cubit/datas_cubit.dart';
import 'package:asset_management/mobile/presentation/view/picking/picking_detail_item.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickingDetailView extends StatefulWidget {
  const PickingDetailView({super.key});

  @override
  State<PickingDetailView> createState() => _PickingDetailViewState();
}

class _PickingDetailViewState extends State<PickingDetailView> {
  late TextEditingController _locationNameC;
  late TextEditingController _totalBoxC;

  late FocusNode _locationFn;
  late FocusNode _totalBoxFn;

  @override
  void initState() {
    _locationNameC = TextEditingController();
    _totalBoxC = TextEditingController();
    _locationFn = FocusNode();
    _totalBoxFn = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePickingDetail(),
      mobileMScaffold: _mobilePickingDetail(isLarge: false),
    );
  }

  Widget _mobilePickingDetail({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Picking Detail')),
      body: BlocBuilder<PickingDetailBloc, PickingDetailState>(
        builder: (context, state) {
          if (state.status == StatusPickingDetail.loading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.kBase),
            );
          }

          if (state.response?.pickingDetail == null ||
              state.response!.pickingDetail!.isEmpty) {
            final picking = state.response?.picking;
            return Padding(
              padding: EdgeInsets.fromLTRB(16, 5, 16, 8),
              child: Column(
                children: [
                  AppTextField(
                    controller: _locationNameC,
                    focusNode: _locationFn,
                    fontSize: isLarge ? 14 : 12,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    title: 'Location',
                    hintText: 'Example : LD.01.01.01',
                    onSubmitted: (value) => _totalBoxFn.requestFocus(),
                  ),
                  AppSpace.vertical(16),
                  AppTextField(
                    controller: _totalBoxC,
                    focusNode: _totalBoxFn,
                    fontSize: isLarge ? 14 : 12,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.number,
                    title: 'Total Box',
                    hintText: 'Example : 20',
                    onSubmitted: (value) => submit(isLarge: isLarge),
                  ),
                  AppSpace.vertical(32),
                  BlocConsumer<PickingBloc, PickingState>(
                    listener: (context, state) {
                      context.popExt();
                      if (state.status == StatusPicking.completedSuccess) {
                        context.showSnackbar(state.message ?? '');
                        context.popExt();
                      }
                    },
                    builder: (context, state) {
                      return AppButton(
                        title: 'Submit',
                        fontSize: isLarge ? 14 : 12,
                        height: 30,
                        width: context.deviceWidth,
                        onPressed: () async {
                          final location = await submit(isLarge: isLarge);

                          final isNumber = _totalBoxC.value.text
                              .trim()
                              .isNumber();

                          if (!isNumber) {
                            context.showSnackbar(
                              'Total box not valid',
                              backgroundColor: AppColors.kRed,
                              fontSize: isLarge ? 14 : 12,
                            );
                          } else if (location == null) {
                            context.showSnackbar(
                              'Location not found',
                              backgroundColor: AppColors.kRed,
                              fontSize: isLarge ? 14 : 12,
                            );
                          } else {
                            context.read<PickingBloc>().add(
                              OnUpdateStatusPickingEvent(
                                id: picking!.id!,
                                params: 'READY',
                                locationId: location.id,
                                totalBox: int.parse(
                                  _totalBoxC.value.text.trim(),
                                ),
                              ),
                            );
                            context.dialogLoading();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: state.response?.pickingDetail?.length,
            padding: EdgeInsets.fromLTRB(16, 5, 16, 8),
            itemBuilder: (context, index) {
              final item = state.response?.pickingDetail?[index];
              return item?.isConsumable == 1
                  ? AppCardItem(
                      title: item?.model,
                      leading: item?.status,
                      subtitle: item?.location,
                      onTap: () => context.pushExt(
                        PickingDetailItemView(
                          params: item!,
                          preparationId: state.response!.picking!.id!,
                        ),
                      ),
                      noDescription: true,
                    )
                  : AppCardItem(
                      title: item?.assetCode,
                      leading: item?.status,
                      subtitle: item?.location,
                      onTap: () => context.pushExt(
                        PickingDetailItemView(
                          params: item!,
                          preparationId: state.response!.picking!.id!,
                        ),
                      ),
                      noDescription: true,
                    );
            },
          );
        },
      ),
    );
  }

  Future<Location?> submit({bool isLarge = true}) async {
    final locations = await context.read<DatasCubit>().getLocations();

    final location = locations
        .where((element) => element.name == _locationNameC.value.text.trim())
        .firstOrNull;

    return location;
  }
}
