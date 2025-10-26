import 'dart:io';

import 'package:asset_management/data/model/printer/printer_model.dart';

abstract class PrinterLocalDataSource {
  Future<String> setDefaultPrinter(PrinterModel params);
  Future<String> getIpPrinter();
  Future<Socket> getConnectionPrinter();
}
