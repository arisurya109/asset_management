import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../reprint.dart';

class ReprintLocationView extends StatefulWidget {
  const ReprintLocationView({super.key});

  @override
  State<ReprintLocationView> createState() => _ReprintLocationViewState();
}

class _ReprintLocationViewState extends State<ReprintLocationView> {
  late TextEditingController locationC;

  @override
  void initState() {
    locationC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    locationC.clear();
    locationC.dispose();
    super.dispose();
  }

  _onSubmit() {
    if (locationC.value.text.isFilled()) {
      context.showDialogConfirm(
        title: 'Reprint Location ?',
        content:
            'Are you sure you want to reprint the \n${locationC.value.text.trim()}?',
        onCancelText: 'Cancel',
        onConfirmText: 'Yes',
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          context.read<ReprintBloc>().add(
            OnReprintLocation(locationC.value.text.trim()),
          );
          Navigator.pop(context);
          locationC.clear();
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
        title: Text('REPRINT LOCATION'),
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
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            AppTextField(
              controller: locationC,
              hintText: 'Example : LD.01.01.01',
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.go,
              title: 'Location',
              onSubmitted: (_) => _onSubmit(),
            ),
            AppSpace.vertical(24),
            BlocListener<ReprintBloc, ReprintState>(
              listener: (context, state) {
                if (state.status == StatusReprint.failed) {
                  context.showSnackbar(
                    state.message!,
                    backgroundColor: Colors.red,
                  );
                }

                if (state.status == StatusReprint.success) {
                  context.showSnackbar('Successfully reprint Location');
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
