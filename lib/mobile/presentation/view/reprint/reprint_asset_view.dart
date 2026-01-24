import 'package:asset_management/core/core.dart';
import 'package:asset_management/mobile/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_text_field_locking.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReprintAssetView extends StatefulWidget {
  const ReprintAssetView({super.key});

  @override
  State<ReprintAssetView> createState() => _ReprintAssetViewState();
}

class _ReprintAssetViewState extends State<ReprintAssetView> {
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
      mobileLScaffold: _mobileAssetReprint(),
      mobileMScaffold: _mobileAssetReprint(isLarge: false),
    );
  }

  Widget _mobileAssetReprint({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Reprint Asset')),
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
                context.showSnackbar('Successfully Reprint Asset');
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
                  hintText: 'Asset Code Or Serial Number',
                  textInputAction: TextInputAction.go,
                  onSubmitted: (_) => _reprint(isLarge: isLarge),
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
        'Asset Code Or SN cannot empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else {
      context.read<PrinterBloc>().add(OnPrintAssetId(params));
    }
  }
}
