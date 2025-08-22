import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/service/printer_service.dart';

abstract class PrinterSource {
  Future<String> setDefaultPrinter(String ipPrinter, {int port = 9100});
  Future<String> getIpPrinter();
}

class PrinterSourceImpl implements PrinterSource {
  final PrinterServices _services;

  PrinterSourceImpl(this._services);

  @override
  Future<String> setDefaultPrinter(String ipPrinter, {int port = 9100}) async {
    try {
      final response = await _services.setPrinterDefault(ipPrinter, port: port);
      return response;
    } on FailedConnectedPrinterException catch (e) {
      throw FailedConnectedPrinterException(message: e.message);
    }
  }

  @override
  Future<String> getIpPrinter() async {
    try {
      final ipPrinter = await _services.getIpPrinter();
      return ipPrinter;
    } on FailedConnectedPrinterException catch (e) {
      throw FailedConnectedPrinterException(message: e.message);
    }
  }
}
