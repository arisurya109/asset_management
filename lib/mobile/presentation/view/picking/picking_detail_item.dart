import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/picking/picking_detail.dart';
import 'package:asset_management/mobile/presentation/bloc/picking_detail/picking_detail_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_text_field_locking.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickingDetailItemView extends StatefulWidget {
  final int preparationId;
  final PickingDetail params;

  const PickingDetailItemView({
    super.key,
    required this.params,
    required this.preparationId,
  });

  @override
  State<PickingDetailItemView> createState() => _PickingDetailItemViewState();
}

class _PickingDetailItemViewState extends State<PickingDetailItemView> {
  late TextEditingController _locationC;
  late TextEditingController _assetCodeC;
  late TextEditingController _categoryC;
  late TextEditingController _modelC;
  late TextEditingController _quantityC;

  @override
  void initState() {
    _locationC = TextEditingController(text: widget.params.location);
    _assetCodeC = TextEditingController(text: widget.params.assetCode);
    _categoryC = TextEditingController(text: widget.params.category);
    _modelC = TextEditingController(text: widget.params.model);
    _quantityC = TextEditingController(text: widget.params.quantity.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePickingDetailItem(),
      mobileMScaffold: _mobilePickingDetailItem(isLarge: false),
    );
  }

  Widget _mobilePickingDetailItem({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Picking Detail Item')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 12),
        child: Column(
          children: [
            AppTextFieldLocking(
              controller: _categoryC,
              fontSize: isLarge ? 14 : 12,
              readOnly: true,
            ),
            AppSpace.vertical(16),
            AppTextFieldLocking(
              controller: _modelC,
              fontSize: isLarge ? 14 : 12,
              readOnly: true,
            ),
            AppSpace.vertical(16),
            widget.params.isConsumable == 1
                ? AppTextFieldLocking(
                    controller: _quantityC,
                    fontSize: isLarge ? 14 : 12,
                    readOnly: true,
                  )
                : AppTextFieldLocking(
                    controller: _assetCodeC,
                    fontSize: isLarge ? 14 : 12,
                    readOnly: true,
                  ),
            AppSpace.vertical(16),
            AppTextFieldLocking(
              controller: _locationC,
              fontSize: isLarge ? 14 : 12,
              readOnly: true,
            ),
            Spacer(),
            BlocConsumer<PickingDetailBloc, PickingDetailState>(
              listener: (context, state) {
                if (state.status == StatusPickingDetail.failure) {
                  context.popExt();
                  context.showSnackbar(
                    state.message ?? '',
                    backgroundColor: AppColors.kRed,
                    fontSize: isLarge ? 14 : 12,
                  );
                  context.read<PickingDetailBloc>().add(OnSetInitialStatus());
                }

                if (state.status == StatusPickingDetail.addSuccess) {
                  context.popExt();
                  context.showSnackbar(
                    state.message ?? '',
                    fontSize: isLarge ? 14 : 12,
                  );
                  context.read<PickingDetailBloc>().add(OnSetInitialStatus());
                  context.popExt();
                }
              },
              builder: (context, state) {
                return AppButton(
                  title: 'PICK',
                  height: 28,
                  width: context.deviceWidth,
                  fontSize: isLarge ? 14 : 12,
                  onPressed: () {
                    context.read<PickingDetailBloc>().add(
                      OnPickAssetEvent(widget.params, widget.preparationId),
                    );
                    context.dialogLoading();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
