import 'package:asset_management/core/config/config_label.dart';
import 'package:asset_management/features/printer/domain/entities/printer.dart';
import 'package:asset_management/features/printer/domain/usecases/get_connection_printer_use_case.dart';
import 'package:asset_management/features/printer/domain/usecases/get_ip_printer_use_case.dart';
import 'package:asset_management/features/printer/domain/usecases/set_default_printer_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  final SetDefaultPrinterUseCase _setDefaultPrinterUseCase;
  final GetIpPrinterUseCase _getIpPrinterUseCase;
  final GetConnectionPrinterUseCase _getConnectionPrinterUseCase;

  PrinterBloc(
    this._setDefaultPrinterUseCase,
    this._getIpPrinterUseCase,
    this._getConnectionPrinterUseCase,
  ) : super(PrinterState()) {
    on<OnSetDefaultPrinter>((event, emit) async {
      emit(state.copyWith(status: PrinterStatus.loading));

      final failureOrSuccess = await _setDefaultPrinterUseCase(event.params);

      return failureOrSuccess.fold(
        (failure) => emit(
          state.copyWith(
            status: PrinterStatus.failed,
            message: failure.message,
          ),
        ),
        (message) => emit(
          state.copyWith(status: PrinterStatus.loaded, message: message),
        ),
      );
    });

    on<OnGetIpPrinter>((event, emit) async {
      emit(state.copyWith(status: PrinterStatus.loading));

      final failureOrSuccess = await _getIpPrinterUseCase();

      return failureOrSuccess.fold(
        (failure) => emit(
          state.copyWith(
            status: PrinterStatus.failed,
            message: failure.message,
          ),
        ),
        (ip) => emit(
          state.copyWith(
            status: PrinterStatus.loaded,
            printer: Printer(ipPrinter: ip, portPrinter: 9100),
          ),
        ),
      );
    });

    on<OnPrintAssetId>((event, emit) async {
      final failureOrPrinter = await _getConnectionPrinterUseCase();

      return failureOrPrinter.fold(
        (failure) => emit(
          state.copyWith(
            status: PrinterStatus.failed,
            message: failure.message,
          ),
        ),
        (conn) async {
          final command = ConfigLabel.AssetIdNormal(event.params);
          final command1 = ConfigLabel.AssetIdLarge(event.params);

          conn.write(command);
          conn.write(command1);

          await conn.flush();
          await conn.close();

          emit(state.copyWith(status: PrinterStatus.success));
        },
      );
    });
    on<OnPrintLocation>((event, emit) async {
      final failureOrPrinter = await _getConnectionPrinterUseCase();

      return failureOrPrinter.fold(
        (failure) => emit(
          state.copyWith(
            status: PrinterStatus.failed,
            message: failure.message,
          ),
        ),
        (conn) async {
          final command = ConfigLabel.Location(event.params);

          conn.write(command);

          await conn.flush();
          await conn.close();

          emit(state.copyWith(status: PrinterStatus.success));
        },
      );
    });
  }
}
