import 'package:asset_management/features/printer/domain/usecases/get_ip_printer_use_case.dart';
import 'package:asset_management/features/printer/domain/usecases/set_default_printer_use_case.dart';
import 'package:bloc/bloc.dart';

class PrinterCubit extends Cubit<String> {
  final SetDefaultPrinterUseCase _useCase;
  final GetIpPrinterUseCase _getIpPrinterUseCase;

  PrinterCubit(this._useCase, this._getIpPrinterUseCase) : super('');

  void onGetIpPrinter() async {
    final failureOrSuccess = await _getIpPrinterUseCase();

    return failureOrSuccess.fold(
      (failure) => emit(failure.message!),
      (success) => emit(success),
    );
  }

  void onSetDefaultPrinter(String ip) async {
    final failureOrSuccess = await _useCase(ip);

    return failureOrSuccess.fold(
      (failure) => emit(failure.message!),
      (success) => emit(success),
    );
  }
}
