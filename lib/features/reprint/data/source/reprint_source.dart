import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/service/printer_service.dart';

abstract class ReprintSource {
  Future<void> reprintByAssetId(String assetId);
  Future<void> reprintBySerialNumber(String serialNumber);
  Future<void> reprintLocation(String locations);
}

class ReprintSourceImpl implements ReprintSource {
  final PrinterServices _services;

  ReprintSourceImpl(this._services);

  @override
  Future<void> reprintByAssetId(String assetId) async {
    try {
      final printer = await _services.getConnectionPrinter();

      final command =
          '''
      ^XA
      ^PW530
      ^LL530
      ^MD30
      ^PS3

      // Barcode atas
      ^FO30,20
      ^BY2,3,150
      ^BCN,90,N,N,N
      ^FD$assetId^FS

      // Text di bawah barcode atas
      ^FO130,120
      ^A0N,25,25
      ^FD$assetId^FS

      // Barcode tengah
      ^FO30,200
      ^BY2,3,150
      ^BCN,90,N,N,N
      ^FD$assetId^FS

      // Text di tengah barcode tengah
      ^FO130,305
      ^A0N,25,25
      ^FD$assetId^FS

      // Barcode bawah
      ^FO30,380
      ^BY2,3,150
      ^BCN,90,N,N,N
      ^FD$assetId^FS

      // Text di bawah barcode bawah
      ^FO130,485
      ^A0N,25,25
      ^FD$assetId^FS

      ^XZ
      ''';

      printer.write(command);
      await printer.flush();
      await printer.close();
    } on FailedConnectedPrinterException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // NEED API CALL
  @override
  Future<void> reprintBySerialNumber(String serialNumber) {
    // TODO: implement reprintBySerialNumber
    throw UnimplementedError();
  }

  @override
  Future<void> reprintLocation(String location) async {
    try {
      final printer = await _services.getConnectionPrinter();

      final command =
          '''
      ^XA
      ^PW530
      ^LL530
      ^MD30
      ^PS3

      // Barcode atas
      ^FO30,20
      ^BY3,3,150
      ^BCN,450,N,N,N
      ^FD$location^FS

      // Text di bawah barcode atas
      ^FO135,490
      ^A0N,50,50
      ^FD$location^FS

      ^XZ
      ''';

      printer.write(command);
      await printer.flush();
      await printer.close();
    } on FailedConnectedPrinterException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
