import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/printer/printer.dart';
import 'package:asset_management/main_export.dart';
import 'package:asset_management/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/responsive_layout.dart';

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

  _submit(bool isLarge) {
    final ip = ipC.value.text.trim();

    if (!ip.isFilled()) {
      context.showSnackbar(
        'IP cannot be empty',
        fontSize: isLarge ? 14 : 12,
        backgroundColor: AppColors.kRed,
      );
    } else {
      context.read<PrinterBloc>().add(
        OnSetDefaultPrinter(Printer(ipPrinter: ip, portPrinter: 9100)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobilePrinter(),
      mobileMScaffold: _mobilePrinter(isLarge: false),
    );
  }

  Widget _mobilePrinter({bool isLarge = true}) {
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
              fontSize: isLarge ? 14 : 12,
              hintText: 'Example : 10.110.117.95',
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submit(isLarge),
            ),
            AppSpace.vertical(48),
            BlocConsumer<PrinterBloc, PrinterState>(
              listener: (context, state) {
                if (state.status == PrinterStatus.failed) {
                  context.showSnackbar(
                    state.message ?? 'Failed set printer',
                    fontSize: isLarge ? 14 : 12,
                    backgroundColor: AppColors.kRed,
                  );
                }
                if (state.status == PrinterStatus.loaded) {
                  context.showSnackbar(
                    'Successfully set printer',
                    fontSize: isLarge ? 14 : 12,
                  );
                }
              },
              builder: (context, state) {
                return AppButton(
                  title: 'Submit',
                  fontSize: isLarge ? 16 : 14,
                  width: context.deviceWidth,
                  onPressed: () => _submit(isLarge),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
