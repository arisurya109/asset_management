import 'dart:io';

import 'package:asset_management/features/printer/data/model/printer_model.dart';

abstract class PrinterLocalDataSource {
  Future<String> setDefaultPrinter(PrinterModel params);
  Future<String> getIpPrinter();
  Future<Socket> getConnectionPrinter();
}
