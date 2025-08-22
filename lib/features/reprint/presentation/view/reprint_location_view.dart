import 'package:asset_management/core/extension/context_ext.dart';
import 'package:asset_management/core/extension/string_ext.dart';
import 'package:asset_management/core/widgets/app_button.dart';
import 'package:asset_management/core/widgets/app_space.dart';
import 'package:asset_management/core/widgets/app_text_field.dart';
import 'package:asset_management/features/reprint/presentation/bloc/reprint_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReprintLocationView extends StatefulWidget {
  const ReprintLocationView({super.key});

  @override
  State<ReprintLocationView> createState() => _ReprintLocationViewState();
}

class _ReprintLocationViewState extends State<ReprintLocationView> {
  late TextEditingController controllerAsset;

  @override
  void initState() {
    controllerAsset = TextEditingController();
    super.initState();
  }

  void _onSubmit() {
    if (controllerAsset.value.text.isFilled()) {
      context.read<ReprintBloc>().add(
        OnReprintLocation(controllerAsset.value.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          AppTextField(
            controller: controllerAsset,
            hintText: 'Location',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.go,
          ),
          AppSpace.vertical(20),
          BlocListener<ReprintBloc, ReprintState>(
            listener: (context, state) {
              if (state.status == StatusReprint.success) {
                context.showSnackbar('Success reprint asset');
              }
            },
            child: AppButton(onPressed: _onSubmit, title: 'Reprint'),
          ),
        ],
      ),
    );
  }
}
