import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reprint/reprint_bloc.dart';
import '../core/extension/context_ext.dart';
import '../core/extension/string_ext.dart';
import '../core/utils/enum.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_space.dart';
import '../core/widgets/app_text_field.dart';

class ReprintAssetIdView extends StatefulWidget {
  const ReprintAssetIdView({super.key});

  @override
  State<ReprintAssetIdView> createState() => _ReprintAssetIdViewState();
}

class _ReprintAssetIdViewState extends State<ReprintAssetIdView> {
  late TextEditingController controller;

  @override
  void dispose() {
    controller.clear();
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  _onSubmit() {
    if (controller.value.text.isFilled()) {
      context.showDialogConfirm(
        title: 'Reprint Asset ID ?',
        content:
            'Are you sure you want to reprint the \n${controller.value.text.trim()}?',
        onCancelText: 'Cancel',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<ReprintBloc>().add(
            OnReprintAssetIdByAssetId(controller.value.text.trim()),
          );
          Navigator.pop(context);
          controller.clear();
        },
      );
    } else {
      context.showSnackbar(
        'Nothing should be empty',
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          AppTextField(
            controller: controller,
            title: 'Asset ID',
            hintText: 'Contoh : AST-PRN-2508230001',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => _onSubmit(),
          ),
          AppSpace.vertical(24),
          BlocListener<ReprintBloc, ReprintState>(
            listener: (context, state) {
              debugPrint(state.status.toString());
              if (state.status == StatusReprint.failed) {
                context.showSnackbar(
                  state.message!,
                  backgroundColor: Colors.red,
                );
              }

              if (state.status == StatusReprint.success) {
                context.showSnackbar('Successfully reprint Asset ID');
              }
            },
            child: AppButton(title: 'Submit', onPressed: _onSubmit),
          ),
        ],
      ),
    );
  }
}
