import 'package:asset_management/core/widgets/app_text_field.dart';
import 'package:asset_management/features/asset_preparation/asset_preparation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_space.dart';
import '../../../asset_master/presentation/bloc/asset_master/asset_master_bloc.dart';

class AssetPreparationNonIdView extends StatefulWidget {
  final AssetPreparation preparation;
  const AssetPreparationNonIdView({super.key, required this.preparation});

  @override
  State<AssetPreparationNonIdView> createState() =>
      _AssetPreparationNonIdViewState();
}

class _AssetPreparationNonIdViewState extends State<AssetPreparationNonIdView> {
  late TextEditingController quantity;
  late TextEditingController location;
  late TextEditingController box;
  String? asset;

  @override
  void initState() {
    quantity = TextEditingController();
    location = TextEditingController();
    box = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpace.vertical(8),
        AppTextField(
          controller: location,
          hintText: 'For Example : LD.01.01.01',
          title: 'Location',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
        AppSpace.vertical(12),
        AppTextField(
          controller: box,
          hintText: 'For Example : BOX-JARINGAN',
          title: 'Box',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
        AppSpace.vertical(12),
        BlocBuilder<AssetMasterBloc, AssetMasterState>(
          builder: (context, state) {
            return AppDropDown(
              hintText: 'Selected Asset',
              items: state.assets?.map((e) => e.name).toList(),
              title: 'Asset',
              value: asset,
              onSelected: (value) => setState(() {
                asset = value;
              }),
            );
          },
        ),
        AppSpace.vertical(12),
        AppTextField(
          controller: quantity,
          hintText: 'For Example : 12',
          title: 'Quantity',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.go,
        ),
      ],
    );
  }
}
