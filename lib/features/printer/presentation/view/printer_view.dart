import 'package:asset_management/features/printer/printer_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/printer/printer_bloc.dart';

class PrinterView extends StatefulWidget {
  const PrinterView({super.key});

  @override
  State<PrinterView> createState() => _PrinterViewState();
}

class _PrinterViewState extends State<PrinterView> {
  late TextEditingController controller;

  @override
  void initState() {
    final ip = context.read<PrinterBloc>().state.printer?.ipPrinter;

    if (ip != null) {
      controller = TextEditingController(text: ip);
    } else {
      controller = TextEditingController();
    }

    super.initState();
  }

  _onSubmit() {
    final newIp = controller.value.text.trim();
    final oldIp = context.read<PrinterBloc>().state.printer?.ipPrinter;
    if (!newIp.isFilled()) {
      context.showSnackbar(
        'IP address must not be empty.',
        backgroundColor: Colors.red,
      );
    } else if (newIp == oldIp) {
      context.showSnackbar(
        'Failed set printer, previous IP address is the same',
        backgroundColor: Colors.red,
      );
    } else if (!newIp.contains('10.110')) {
      context.showSnackbar('IP Not valid', backgroundColor: Colors.red);
    } else {
      context.read<PrinterBloc>().add(
        OnSetDefaultPrinter(Printer(ipPrinter: newIp, portPrinter: 9100)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Printer'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            AppTextField(
              title: 'IP Printer',
              hintText: 'Example : 10.110.117.95',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.go,
              controller: controller,
              onSubmitted: (_) => _onSubmit(),
            ),
            AppSpace.vertical(24),
            BlocListener<PrinterBloc, PrinterState>(
              listener: (context, state) {
                if (state.status == PrinterStatus.failed) {
                  context.showSnackbar(
                    state.message!,
                    backgroundColor: Colors.red,
                  );
                }

                if (state.status == PrinterStatus.loaded) {
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
