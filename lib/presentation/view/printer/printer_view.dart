import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_space.dart';
import 'package:asset_management/domain/entities/printer/printer.dart';
import 'package:asset_management/main_export.dart';
import 'package:asset_management/presentation/bloc/printer/printer_bloc.dart';
import 'package:flutter/material.dart';

class PrinterView extends StatefulWidget {
  const PrinterView({super.key});

  @override
  State<PrinterView> createState() => _PrinterViewState();
}

class _PrinterViewState extends State<PrinterView> {
  late TextEditingController ipC;

  @override
  void initState() {
    final ipPrinter = context.read<PrinterBloc>().state.printer?.ipPrinter;
    ipC = TextEditingController(text: ipPrinter);
    super.initState();
  }

  _submit() {
    final ip = ipC.value.text.trim();

    if (!ip.isFilled()) {
      context.showSnackbar('IP cannot be empty');
    }
    {
      context.read<PrinterBloc>().add(
        OnSetDefaultPrinter(Printer(ipPrinter: ip, portPrinter: 9100)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Printer')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            AppSpace.vertical(16),
            AppTextField(
              controller: ipC,
              title: 'IP Printer',
              hintText: 'Example : 10.110.117.95',
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submit(),
            ),
            AppSpace.vertical(48),
            BlocConsumer<PrinterBloc, PrinterState>(
              listener: (context, state) {
                if (state.status == PrinterStatus.failed) {
                  context.showSnackbar(state.message ?? 'Failed set printer');
                }
                if (state.status == PrinterStatus.loaded) {
                  context.showSnackbar('Successfully set printer');
                }
              },
              builder: (context, state) {
                return AppButton(
                  title: 'Submit',
                  width: context.deviceWidth,
                  onPressed: _submit,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
