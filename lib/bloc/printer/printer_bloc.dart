// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../usecases/printer/get_ip_printer_use_case.dart';
import '../../usecases/printer/set_default_printer_use_case.dart';
import '../../core/utils/enum.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  final SetDefaultPrinterUseCase _setDefaultPrinterUseCase;
  final GetIpPrinterUseCase _getIpPrinterUseCase;

  PrinterBloc(this._setDefaultPrinterUseCase, this._getIpPrinterUseCase)
    : super(PrinterState()) {
    on<OnGetIpPrinter>(_getIpPrinter);
    on<OnSetDefaultPrinter>(_setDefaultPrinter);
    on<OnSetStatusInitialPrinter>(_setStatusInitial);
  }

  void _setStatusInitial(
    OnSetStatusInitialPrinter event,
    Emitter<PrinterState> emit,
  ) async {
    emit(state.copyWith(status: StatusPrinter.initial, message: null));
  }

  void _setDefaultPrinter(
    OnSetDefaultPrinter event,
    Emitter<PrinterState> emit,
  ) async {
    emit(state.copyWith(status: StatusPrinter.loading));

    final failureOrIpPrinter = await _setDefaultPrinterUseCase(event.ipPrinter);

    return failureOrIpPrinter.fold(
      (failure) => emit(
        state.copyWith(status: StatusPrinter.failed, message: failure.message),
      ),
      (ipPrinter) => emit(
        state.copyWith(status: StatusPrinter.success, ipPrinter: ipPrinter),
      ),
    );
  }

  void _getIpPrinter(OnGetIpPrinter event, Emitter<PrinterState> emit) async {
    emit(state.copyWith(status: StatusPrinter.loading));

    final failureOrIpPrinter = await _getIpPrinterUseCase();

    return failureOrIpPrinter.fold(
      (failure) => emit(
        state.copyWith(status: StatusPrinter.failed, message: failure.message),
      ),
      (ipPrinter) => emit(
        state.copyWith(status: StatusPrinter.success, ipPrinter: ipPrinter),
      ),
    );
  }
}
