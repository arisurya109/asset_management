// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:asset_management/domain/entities/movement/movement.dart';
import 'package:asset_management/mobile/presentation/bloc/transfer/transfer_bloc.dart';
import 'package:asset_management/mobile/presentation/components/app_text_field_locking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asset_management/mobile/presentation/cubit/datas_cubit.dart';
import 'package:asset_management/mobile/responsive_layout.dart';

import '../../../../../../core/core.dart';

class TransferView extends StatefulWidget {
  const TransferView({super.key});

  @override
  State<TransferView> createState() => _TransferViewState();
}

class _TransferViewState extends State<TransferView> {
  late TextEditingController _destinationC;
  late TextEditingController _assetCodeC;
  late FocusNode _destinationFn;
  late FocusNode _assetCodeFn;

  bool _isLockDestination = false;

  @override
  void initState() {
    _destinationC = TextEditingController();
    _assetCodeC = TextEditingController();
    _destinationFn = FocusNode();
    _assetCodeFn = FocusNode();
    _destinationFn.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _destinationC.dispose();
    _assetCodeC.dispose();
    _destinationFn.dispose();
    _assetCodeFn.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileTransfer(),
      mobileMScaffold: _mobileTransfer(isLarge: false),
    );
  }

  Widget _mobileTransfer({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Transfer')),
      body: BlocBuilder<DatasCubit, void>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Destination',
                  style: TextStyle(
                    fontSize: isLarge ? 14 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSpace.vertical(5),
                AppTextFieldLocking(
                  controller: _destinationC,
                  focusNode: _destinationFn,
                  textInputAction: TextInputAction.next,
                  hintText: 'Example : NW.04.01.01',
                  fontSize: isLarge ? 14 : 12,
                  readOnly: _isLockDestination,
                  onSubmitted: (value) async {
                    if (value.isFilled()) {
                      _assetCodeFn.requestFocus();
                    }
                  },
                  isLocked: () => setState(() {
                    _isLockDestination = !_isLockDestination;
                  }),
                ),
                AppSpace.vertical(16),
                Text(
                  'Asset Code',
                  style: TextStyle(
                    fontSize: isLarge ? 14 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSpace.vertical(5),
                AppTextFieldLocking(
                  controller: _assetCodeC,
                  focusNode: _assetCodeFn,
                  textInputAction: TextInputAction.search,
                  hintText: 'Example : AST-CPU-2601010001',
                  fontSize: isLarge ? 14 : 12,
                  onSubmitted: (value) => _onSubmit(isLarge),
                ),
                AppSpace.vertical(32),
                BlocConsumer<TransferBloc, TransferState>(
                  listener: (context, state) {
                    if (state.status == StatusTransfer.loading) {
                      context.dialogLoading();
                    }
                    if (state.status == StatusTransfer.failure) {
                      context.popExt();
                      context.showSnackbar(
                        state.message ?? '',
                        backgroundColor: AppColors.kRed,
                        fontSize: isLarge ? 14 : 12,
                      );
                      _assetCodeC.clear();
                      _assetCodeFn.requestFocus();
                    }
                    if (state.status == StatusTransfer.loaded) {
                      context.popExt();
                      final destination = _destinationC.value.text.trim();
                      context.showDialogConfirm(
                        title: 'Are your sure transfer asset ?',
                        content:
                            'Destination : $destination\nAsset Code : ${state.asset?.assetCode}\nLocation : ${state.asset?.locationDetail}\nCategory : ${state.asset?.category}\nModel : ${state.asset?.model}',
                        onCancelText: 'No',
                        onConfirmText: 'Yes',
                        fontSize: isLarge ? 14 : 12,
                        onCancel: () => Navigator.pop(context),
                        onConfirm: () {
                          context.read<TransferBloc>().add(
                            OnTransferAsset(
                              Movement(
                                assetId: state.asset?.id,
                                destination: destination,
                                fromLocation: state.asset?.locationDetail,
                                type: 'TRANSFER',
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        },
                      );
                    }
                    if (state.status == StatusTransfer.success) {
                      context.popExt();
                      context.showSnackbar(
                        state.message ?? '',
                        fontSize: isLarge ? 14 : 12,
                      );
                      _assetCodeC.clear();
                      _assetCodeFn.requestFocus();
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      title: state.status == StatusTransfer.loading
                          ? 'Loading...'
                          : 'Transfer',
                      onPressed: state.status == StatusTransfer.loading
                          ? null
                          : () => _onSubmit(isLarge),
                      fontSize: isLarge ? 14 : 12,
                      height: 35,
                      width: context.deviceWidth,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _onSubmit(bool isLarge) async {
    final params = _assetCodeC.value.text.trim();
    final destination = _destinationC.value.text.trim();
    FocusManager.instance.primaryFocus?.unfocus();

    if (!destination.isFilled()) {
      context.showSnackbar(
        'Destination cannot be empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (!params.isFilled()) {
      context.showSnackbar(
        'Asset Code cannot be empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else {
      context.read<TransferBloc>().add(OnGetAssetByAssetCode(params));
    }
  }
}
