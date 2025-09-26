import 'reprint_source.dart';
import '../../../../core/core.dart';
import '../../../../services/printer_service.dart';

class ReprintSourceImpl implements ReprintSource {
  final PrinterServices _printerService;

  ReprintSourceImpl(this._printerService);

  @override
  Future<void> reprintAssetIdLarge(String params) async {
    try {
      final printer = await _printerService.getConnectionPrinter();

      final command = ConfigLabel.AssetIdLarge(params);

      printer.write(command);
      await printer.flush();
      await printer.close();
      return;
    } on FailedConnectedPrinterException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> reprintAssetIdLargeBySerialNumber(String params) {
    // TODO: implement reprintAssetIdLargeBySerialNumber
    throw UnimplementedError();
  }

  @override
  Future<void> reprintAssetIdNormal(String params) async {
    try {
      final printer = await _printerService.getConnectionPrinter();

      final command = ConfigLabel.AssetIdNormal(params);

      printer.write(command);
      await printer.flush();
      await printer.close();
      return;
    } on FailedConnectedPrinterException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> reprintAssetIdNormalBySerialNumber(String params) {
    // TODO: implement reprintAssetIdNormalBySerialNumber
    throw UnimplementedError();
  }

  @override
  Future<void> reprintLocation(String params) async {
    try {
      final printer = await _printerService.getConnectionPrinter();

      final command = ConfigLabel.Location(params);

      printer.write(command);
      await printer.flush();
      await printer.close();
      return;
    } on FailedConnectedPrinterException catch (_) {
      rethrow;
    }
  }
}
