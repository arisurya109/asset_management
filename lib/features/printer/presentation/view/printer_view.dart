import 'package:asset_management/core/extension/context_ext.dart';
import 'package:asset_management/core/extension/string_ext.dart';
import 'package:asset_management/features/printer/presentation/cubit/printer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_space.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';

class PrinterView extends StatefulWidget {
  const PrinterView({super.key});

  @override
  State<PrinterView> createState() => _PrinterViewState();
}

class _PrinterViewState extends State<PrinterView> {
  late TextEditingController controller;

  @override
  void initState() {
    context.read<PrinterCubit>().onGetIpPrinter();
    print('eksekusi');
    super.initState();
    final ipPrinter = context.read<PrinterCubit>().state;
    print(ipPrinter);
    controller = TextEditingController(text: ipPrinter);

    controller.addListener(() => ipPrinter);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          AppTextField(
            hintText: 'IP PRINTER',
            controller: controller,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.go,
          ),
          AppSpace.vertical(24),
          BlocListener<PrinterCubit, String>(
            listener: (context, state) {
              if (state.contains('10.110')) {
                return;
              }

              context.showSnackbar(state);
            },
            child: AppButton(
              title: 'Selected',
              onPressed: () {
                if (controller.value.text.isFilled()) {
                  context.read<PrinterCubit>().onSetDefaultPrinter(
                    controller.value.text.trim(),
                  );
                }
                context.showSnackbar('Please insert ip printer');
              },
            ),
          ),
        ],
      ),
    );
  }
}
