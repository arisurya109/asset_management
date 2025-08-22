import 'dart:io';

import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/extension/string_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PrinterServices {
  Future<String> setPrinterDefault(String ip, {int port = 9100});
  Future<Socket> getConnectionPrinter();
  Future<String> getIpPrinter();
}

class PrinterServiceImpl implements PrinterServices {
  final SharedPreferences _preferences;

  PrinterServiceImpl(this._preferences);

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

      return await Socket.connect(ipPrinter, portPrinter!);
    } catch (e) {
      throw FailedConnectedPrinterException(message: e.toString());
    }
  }

  @override
  Future<String> setPrinterDefault(String ip, {int port = 9100}) async {
    try {
      final ipIsSaved = await _preferences.setString('ip_printer', ip);
      final portIsSaved = await _preferences.setInt('port_printer', port);

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

  @override
  Future<String> getIpPrinter() async {
    try {
      final ipPrinter = _preferences.getString('ip_printer');
      if (ipPrinter.isFilled()) {
        return ipPrinter!;
      }
      throw FailedConnectedPrinterException(
        message: 'Please set default printer',
      );
    } catch (e) {
      throw FailedConnectedPrinterException(message: e.toString());
    }
  }
}
