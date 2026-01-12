import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/picking/picking_detail_item.dart';
import 'package:asset_management/mobile/presentation/components/app_text_field_locking.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';

class PickingDetailItemView extends StatefulWidget {
  final PickingDetailItem params;
  const PickingDetailItemView({super.key, required this.params});

  @override
  State<PickingDetailItemView> createState() => _PickingDetailItemViewState();
}

class _PickingDetailItemViewState extends State<PickingDetailItemView> {
  late TextEditingController _locationC;
  late TextEditingController _assetCodeC;
  late TextEditingController _quantityC;

  @override
  void initState() {
    _locationC = TextEditingController(text: widget.params.location);
    _assetCodeC = TextEditingController(text: widget.params.assetCode);
    _quantityC = TextEditingController();
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
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 8),
        child: Column(
          children: [
            AppTextFieldLocking(
              controller: _locationC,
              fontSize: isLarge ? 14 : 12,
              readOnly: true,
            ),
            AppSpace.vertical(16),
            AppTextFieldLocking(
              controller: _assetCodeC,
              fontSize: isLarge ? 14 : 12,
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
