import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/picking/picking.dart';
import 'package:asset_management/domain/entities/picking/picking_request.dart';
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
  void dispose() {
    _locationNameC.dispose();
    _totalBoxC.dispose();
    _locationFn.dispose();
    _totalBoxFn.dispose();
    super.dispose();
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
      body: BlocListener<PickingBloc, PickingState>(
        listener: (context, state) {
          if (state.status == StatusPicking.loading) {
            context.dialogLoading();
            context.popExt();
          }
          if (state.status == StatusPicking.failure) {
            context.popExt();
            context.showSnackbar(state.message ?? '');
          }
          if (state.status == StatusPicking.completedSuccess) {
            context.popExt();
            context.showSnackbar(state.message ?? '');
            context.popExt();
            context.popExt();
          }
        },
        child: BlocBuilder<PickingDetailBloc, PickingDetailState>(
          builder: (context, state) {
            if (state.status == StatusPickingDetail.loading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.kBase),
              );
            }

            if (state.response?.items == null ||
                state.response!.items!.isEmpty) {
              final picking = state.response?.pickingHeader;
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
                      onSubmitted: (_) =>
                          _submit(isLarge: isLarge, picking: picking),
                    ),
                    AppSpace.vertical(32),
                    AppButton(
                      title: 'Submit',
                      fontSize: isLarge ? 14 : 12,
                      height: 30,
                      width: context.deviceWidth,
                      onPressed: () =>
                          _submit(isLarge: isLarge, picking: picking),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: state.response?.items?.length,
              padding: EdgeInsets.fromLTRB(16, 5, 16, 8),
              itemBuilder: (context, index) {
                final item = state.response?.items?[index];
                return AppCardItem(
                  title: item?.model,
                  leading: item?.status,
                  subtitle: '${item?.type} - ${item?.category}',
                  onTap: () => context.pushExt(
                    PickingDetailItemView(
                      params: item!,
                      preparationId: state.response!.pickingHeader!.id!,
                    ),
                  ),
                  noDescription: true,
                );
              },
            );
          },
        ),
      ),
    );
  }

  _submit({bool isLarge = true, Picking? picking}) async {
    final locations = await context.read<DatasCubit>().getLocations();

    final location = locations
        .where((element) => element.name == _locationNameC.value.text.trim())
        .firstOrNull;

    final isNumber = _totalBoxC.value.text.trim().isNumber();

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
      context.showDialogConfirm(
        title: 'Submit Picking',
        content:
            'Location : ${location.name}\nTotal Box : ${_totalBoxC.value.text}',
        fontSize: isLarge ? 14 : 12,
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onCancel: () => context.popExt(),
        onConfirm: () {
          context.read<PickingBloc>().add(
            OnUpdateStatusPickingEvent(
              params: PickingRequest(
                preparationId: picking?.id,
                locationReadydId: location.id,
                totalBox: int.parse(_totalBoxC.value.text),
                status: 'READY',
              ),
            ),
          );
          context.popExt();
        },
      );
    }
  }
}
