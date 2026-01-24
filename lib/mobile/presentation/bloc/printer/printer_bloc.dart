import 'package:asset_management/core/config/config_label.dart';
import 'package:asset_management/domain/entities/printer/printer.dart';
import 'package:asset_management/domain/usecases/printer/get_connection_printer_use_case.dart';
import 'package:asset_management/domain/usecases/printer/get_ip_printer_use_case.dart';
import 'package:asset_management/domain/usecases/printer/set_default_printer_use_case.dart';
import 'package:asset_management/domain/usecases/reprint/reprint_asset_or_location_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  final SetDefaultPrinterUseCase _setDefaultPrinterUseCase;
  final GetIpPrinterUseCase _getIpPrinterUseCase;
  final GetConnectionPrinterUseCase _getConnectionPrinterUseCase;
  final ReprintAssetOrLocationUseCase _useCase;

  PrinterBloc(
    this._setDefaultPrinterUseCase,
    this._getIpPrinterUseCase,
    this._getConnectionPrinterUseCase,
    this._useCase,
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
      emit(state.copyWith(status: PrinterStatus.loading));

      final failureOrAsset = await _useCase(
        type: 'ASSET',
        params: event.params,
      );

      return failureOrAsset.fold(
        (failure) => emit(
          state.copyWith(
            status: PrinterStatus.failed,
            message: failure.message,
          ),
        ),
        (asset) async {
          final failureOrPrinter = await _getConnectionPrinterUseCase();

          return failureOrPrinter.fold(
            (failure) => emit(
              state.copyWith(
                status: PrinterStatus.failed,
                message: failure.message,
              ),
            ),
            (conn) async {
              final command = ConfigLabel.AssetIdNormal(asset['asset_code']);
              final command1 = ConfigLabel.AssetIdLarge(asset['asset_code']);

              conn.write(command);
              conn.write(command1);

              await conn.flush();
              await conn.close();

              emit(state.copyWith(status: PrinterStatus.success));
            },
          );
        },
      );
    });
    on<OnPrintLocation>((event, emit) async {
      emit(state.copyWith(status: PrinterStatus.loading));

      final failureOrLocation = await _useCase(
        type: 'LOCATION',
        params: event.params,
      );

      return failureOrLocation.fold(
        (failure) => emit(
          state.copyWith(
            status: PrinterStatus.failed,
            message: failure.message,
          ),
        ),
        (location) async {
          final failureOrPrinter = await _getConnectionPrinterUseCase();

          return failureOrPrinter.fold(
            (failure) => emit(
              state.copyWith(
                status: PrinterStatus.failed,
                message: failure.message,
              ),
            ),
            (conn) async {
              final command = ConfigLabel.Location(location['name']);

              print(location);

              conn.write(command);

              await conn.flush();
              await conn.close();

              emit(state.copyWith(status: PrinterStatus.success));
            },
          );
        },
      );
    });
  }
}
