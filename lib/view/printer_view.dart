import 'package:asset_management/bloc/printer/printer_bloc.dart';
import 'package:asset_management/core/extension/context_ext.dart';
import 'package:asset_management/core/extension/string_ext.dart';
import 'package:asset_management/core/widgets/app_button.dart';
import 'package:asset_management/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/colors.dart';
import '../core/utils/enum.dart';
import '../core/widgets/app_space.dart';

class PrinterView extends StatefulWidget {
  const PrinterView({super.key});

  @override
  State<PrinterView> createState() => _PrinterViewState();
}

class _PrinterViewState extends State<PrinterView> {
  late TextEditingController controller;

  @override
  void dispose() {
    super.dispose();
    controller.clear();
    controller.dispose();
  }

  @override
  void initState() {
    final ipPrinter = context.read<PrinterBloc>().state.ipPrinter;
    super.initState();
    controller = TextEditingController(text: ipPrinter);
  }

  _onSubmit() {
    final ipPrinter = context.read<PrinterBloc>().state.ipPrinter;

    if (!controller.value.text.isFilled()) {
      context.showSnackbar(
        'Nothing should be empty',
        backgroundColor: Colors.red,
      );
    } else if (!controller.value.text.trim().contains('10.110.')) {
      context.showSnackbar('IP Not valid', backgroundColor: Colors.red);
    } else if (controller.value.text.trim() == ipPrinter) {
      context.showSnackbar(
        'No changes to the printer',
        backgroundColor: Colors.red,
      );
    } else {
      context.read<PrinterBloc>().add(
        OnSetDefaultPrinter(controller.value.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PRINTER'),
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
            AppTextField(
              title: 'IP Printer',
              hintText: 'Example : 10.110.117.101',
              controller: controller,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.go,
              onSubmitted: (_) => _onSubmit(),
            ),
            AppSpace.vertical(24),
            BlocListener<PrinterBloc, PrinterState>(
              listener: (context, state) {
                if (state.status == StatusPrinter.failed) {
                  context.showSnackbar(
                    state.message!,
                    backgroundColor: Colors.red,
                  );
                }

                if (state.status == StatusPrinter.success) {
                  context.showSnackbar('Successfully set default printer');
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
