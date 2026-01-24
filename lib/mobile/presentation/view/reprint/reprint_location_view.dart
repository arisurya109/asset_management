import 'package:asset_management/core/core.dart';
import 'package:asset_management/mobile/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_text_field_locking.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReprintLocationView extends StatefulWidget {
  const ReprintLocationView({super.key});

  @override
  State<ReprintLocationView> createState() => _ReprintLocationViewState();
}

class _ReprintLocationViewState extends State<ReprintLocationView> {
  late TextEditingController _paramsC;
  late FocusNode _paramsFn;

  @override
  void initState() {
    _paramsC = TextEditingController();
    _paramsFn = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _paramsFn.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileLocationReprint(),
      mobileMScaffold: _mobileLocationReprint(isLarge: false),
    );
  }

  Widget _mobileLocationReprint({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Reprint Location')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 24, 16),
        child: SingleChildScrollView(
          child: BlocListener<PrinterBloc, PrinterState>(
            listener: (context, state) {
              if (state.status == PrinterStatus.loading) {
                context.dialogLoading();
              }
              if (state.status == PrinterStatus.success) {
                context.popExt();
                context.showSnackbar('Successfully Reprint Location');
                _paramsC.clear();
                _paramsFn.requestFocus();
              }
            },
            child: Column(
              children: [
                AppTextFieldLocking(
                  controller: _paramsC,
                  focusNode: _paramsFn,
                  fontSize: isLarge ? 14 : 12,
                  hintText: 'Location',
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) => _reprint(isLarge: isLarge),
                ),
                AppSpace.vertical(32),
                AppButton(
                  title: 'Reprint',
                  fontSize: isLarge ? 14 : 12,
                  width: context.deviceWidth,
                  onPressed: () => _reprint(isLarge: isLarge),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _reprint({bool isLarge = true}) {
    final params = _paramsC.value.text.trim();

    if (!params.isFilled()) {
      context.showSnackbar(
        'Location cannot empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else {
      context.read<PrinterBloc>().add(OnPrintLocation(params));
    }
  }
}
