import 'dart:io';

import 'package:asset_management/data/model/printer/printer_model.dart';
import 'package:asset_management/data/source/printer/printer_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';

class PrinterLocalDataSourceImpl implements PrinterLocalDataSource {
  final SharedPreferences _preferences;

  PrinterLocalDataSourceImpl(this._preferences);

  @override
  Future<Socket> getConnectionPrinter() async {
    try {
      final ipPrinter = _preferences.getString('ip_printer');
      final portPrinter = _preferences.getInt('port_printer');

      if (!ipPrinter.isFilled() && portPrinter == null) {
        throw FailedConnectedPrinterException(
          message: 'Failed to connect printer, please insert default printer',
        );
      }
      final socket = await Socket.connect(
        ipPrinter,
        portPrinter!,
        timeout: Duration(seconds: 5),
      );
      return socket;
    } catch (e) {
      throw FailedConnectedPrinterException(message: e.toString());
    }
  }

  @override
  Future<String> getIpPrinter() async {
    final ipPrinter = _preferences.getString('ip_printer');

    if (ipPrinter.isFilled()) {
      return ipPrinter!;
    } else {
      throw FailedConnectedPrinterException(
        message: 'Please set default printer',
      );
    }
  }

  @override
  Future<String> setDefaultPrinter(PrinterModel params) async {
    try {
      final ipIsSaved = await _preferences.setString(
        'ip_printer',
        params.ipPrinter!,
      );
      final portIsSaved = await _preferences.setInt(
        'port_printer',
        params.portPrinter!,
      );

      if (!ipIsSaved && !portIsSaved) {
        throw FailedConnectedPrinterException(
          message: 'Failed to set default printer, please try again',
        );
      }

      return 'Success set default printer';
    } catch (e) {
      throw FailedConnectedPrinterException(message: e.toString());
    }
  }
}
