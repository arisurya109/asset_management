import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../reprint.dart';

class ReprintAssetIdView extends StatefulWidget {
  const ReprintAssetIdView({super.key});

  @override
  State<ReprintAssetIdView> createState() => _ReprintAssetIdViewState();
}

class _ReprintAssetIdViewState extends State<ReprintAssetIdView> {
  late TextEditingController assetC;

  @override
  void initState() {
    assetC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    assetC.clear();
    assetC.dispose();
    super.dispose();
  }

  List<String> type = ['NORMAL', 'LARGE'];
  String selectedType = 'NORMAL';

  _onSubmit() {
    if (assetC.value.text.isFilled()) {
      context.showDialogConfirm(
        title: 'Reprint Asset ID ?',
        content:
            'Are you sure you want to reprint the \n${assetC.value.text.trim()}?',
        onCancelText: 'Cancel',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          if (selectedType == 'NORMAL') {
            context.read<ReprintBloc>().add(
              OnReprintAssetIdNormal(assetC.value.text.trim()),
            );
            Navigator.pop(context);
            assetC.clear();
          } else {
            context.read<ReprintBloc>().add(
              OnReprintAssetIdLarge(assetC.value.text.trim()),
            );
            Navigator.pop(context);
            assetC.clear();
          }
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
    return Scaffold(
      appBar: AppBar(
        title: Text('REPRINT ASSET'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppSegmentedButton(
              options: type,
              selected: selectedType,
              onSelectionChanged: (value) => setState(() {
                selectedType = value.first;
                debugPrint(selectedType);
              }),
            ),
            AppSpace.vertical(12),
            AppTextField(
              controller: assetC,
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
      ),
    );
  }
}
