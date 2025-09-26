import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/config/database_helper.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/enum.dart';
import '../model/asset_count_detail_model.dart';
import '../model/asset_count_model.dart';
import 'asset_count_source.dart';
import 'package:intl/intl.dart';

class AssetCountSourceImpl implements AssetCountSource {
  final DatabaseHelper _db;

  AssetCountSourceImpl(this._db);

  @override
  Future<AssetCountModel> createAssetCount(AssetCountModel params) async {
    final db = await _db.database;

    return await db.transaction((txn) async {
      final rawIdListMap = await txn.rawQuery(
        'SELECT MAX(id) AS id FROM t_asset_count',
      );

      int lastId;

      debugPrint(rawIdListMap.toString());

      if (rawIdListMap.first['id'] == null) {
        lastId = 1;
      } else {
        lastId = (rawIdListMap.first['id'] as int) + 1;
      }

      if (lastId < 10) {
        lastId = int.parse('000$lastId');
      } else if (lastId < 100) {
        lastId = int.parse('00$lastId');
      } else {
        lastId = int.parse('0$lastId');
      }

      final countCode =
          'AC${DateFormat('HHmmss').format(DateTime.now())}$lastId';

      final titleCheck = await txn.rawQuery(
        'SELECT * FROM t_asset_count WHERE title = ?',
        [params.title],
      );

      if (titleCheck.isNotEmpty) {
        throw CreateException(
          message: 'Failed to create asset count, title already to use',
        );
      } else {
        final inserted = await txn.rawInsert(
          '''
        INSERT INTO t_asset_count         
        (title, description, count_code, status, count_date)
        VALUES 
        (?, ?, ?, ?, ?)
        ''',
          [
            params.title,
            params.description,
            countCode,
            params.status == StatusCount.CREATED
                ? 'CREATED'
                : params.status == StatusCount.ONPROCESS
                ? 'ONPROCESS'
                : 'COMPLETED',
            DateTime.now().toIso8601String(),
          ],
        );

        final rawData = await txn.rawQuery(
          'SELECT * FROM t_asset_count WHERE id = ?',
          [inserted],
        );

        if (rawData.firstOrNull != null) {
          return AssetCountModel.fromMap(rawData.first);
        } else {
          throw CreateException(
            message: 'Failed to create Asset Count Document',
          );
        }
      }
    });
  }

  @override
  Future<void> deleteAssetCountDetail(int countId, String assetId) async {
    final db = await _db.database;

    final response = await db.rawDelete(
      'DELETE FROM t_asset_count_detail WHERE count_id = ? AND asset_id = ?',
      [countId, assetId],
    );

    if (response == 0) {
      throw DeleteException(message: 'Failed to delete asset');
    }

    return;
  }

  @override
  Future<String> exportAssetCountId(int params) async {
    try {
      final db = await _db.database;

      final assetsCountDetails = await db.rawQuery(
        '''
      SELECT
        tc.count_code AS code,
        tc.title AS title,
        tc.description AS description,
        tc.count_date AS date,
        td.asset_id AS asset_id,
        td.asset_name AS asset_name,
        td.location AS location,
        td.box AS box,
        td.condition AS condition,
        td.quantity AS quantity
      FROM
        t_asset_count_detail AS td
      LEFT JOIN
        t_asset_count AS tc ON td.count_id = tc.id
      WHERE
        td.count_id = ?
      ''',
        [params],
      );

      debugPrint(assetsCountDetails.toString());

      if (assetsCountDetails.firstOrNull == null) {
        throw CreateException(message: 'Failed to export, please try again');
      }

      final rawData = assetsCountDetails.first;

      final code = '${rawData['code']}';
      final title = '${rawData['title']}';
      final description = '${rawData['description']}';
      final countDate = '${rawData['date']}';

      final excel = Excel.createExcel();

      final sheet = excel[code];

      sheet.merge(CellIndex.indexByString('A1'), CellIndex.indexByString('D3'));

      final cell = sheet.cell(CellIndex.indexByString('A1'));
      cell.value = TextCellValue('Title : $title');

      cell.cellStyle = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
        fontFamily: getFontFamily(FontFamily.Calibri),
      );

      var a4 = sheet.cell(CellIndex.indexByString('A4'));
      var b4 = sheet.cell(CellIndex.indexByString('B4'));
      a4.value = TextCellValue('Description :');
      b4.value = TextCellValue(description);

      var a5 = sheet.cell(CellIndex.indexByString('A5'));
      var b5 = sheet.cell(CellIndex.indexByString('B5'));
      a5.value = TextCellValue('Date :');
      b5.value = TextCellValue(countDate);

      sheet.cell(CellIndex.indexByString('A7'));
      sheet.cell(CellIndex.indexByString('B7'));
      sheet.cell(CellIndex.indexByString('A8'));
      sheet.cell(CellIndex.indexByString('B8'));
      sheet.cell(CellIndex.indexByString('A9'));
      sheet.cell(CellIndex.indexByString('B9'));

      const headerStartRow = 9;
      const dataStartRow = headerStartRow + 1;

      final headers = [
        'no',
        'asset',
        'asset_name',
        'location',
        'box',
        'condition',
        'quantity',
      ];

      for (var col = 0; col < headers.length; col++) {
        final cell = sheet.cell(
          CellIndex.indexByColumnRow(
            columnIndex: col,
            rowIndex: headerStartRow,
          ),
        );

        cell.value = TextCellValue(headers[col]);
        cell.cellStyle = CellStyle(
          horizontalAlign: HorizontalAlign.Center,
          bold: true,
        );
      }

      for (var i = 0; i < assetsCountDetails.length; i++) {
        final rowIndex = dataStartRow + i;
        final rowData = [
          IntCellValue(i + 1),
          TextCellValue(assetsCountDetails[i]['asset_id'] as String? ?? ''),
          TextCellValue(assetsCountDetails[i]['asset_name'] as String? ?? ''),
          TextCellValue(assetsCountDetails[i]['location'] as String? ?? ''),
          TextCellValue(assetsCountDetails[i]['box'] as String? ?? ''),
          TextCellValue(assetsCountDetails[i]['condition'] as String? ?? ''),
          IntCellValue(assetsCountDetails[i]['quantity'] as int),
        ];

        for (var col = 0; col < rowData.length; col++) {
          final cell = sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: col, rowIndex: rowIndex),
          );

          cell.value = rowData[col];
          cell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);
        }
      }

      final fileBytes = excel.save();

      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/$code.xlsx';

      final file = File(filePath);
      await file.create(recursive: true);
      await file.writeAsBytes(fileBytes!);

      debugPrint(file.path);

      return file.path;
    } catch (e) {
      debugPrint('error : $e');
      throw CreateException(message: 'Failed to exported, please try again');
    }
  }

  @override
  Future<List<AssetCountModel>> findAllAssetCount() async {
    final db = await _db.database;

    final response = await db.rawQuery('SELECT * FROM t_asset_count');

    return response.map((e) => AssetCountModel.fromMap(e)).toList();
  }

  @override
  Future<List<AssetCountDetailModel>> findAllAssetCountDetailByIdCount(
    int params,
  ) async {
    final db = await _db.database;

    final response = await db.rawQuery(
      'SELECT * FROM t_asset_count_detail WHERE count_id = ?',
      [params],
    );
    debugPrint('Response DB : ${response}');
    return response.map((e) => AssetCountDetailModel.fromMap(e)).toList();
  }

  @override
  Future<AssetCountDetailModel> insertAssetCountDetail(
    AssetCountDetailModel params,
  ) async {
    final db = await _db.database;

    return await db.transaction((txn) async {
      final assetId = params.assetId;
      final countId = params.countId;

      if (params.quantity == 1) {
        final assetIdCheck = await txn.rawQuery(
          'SELECT * FROM t_asset_count_detail WHERE count_id = ? AND asset_id = ?',
          [countId, assetId],
        );
        if (assetIdCheck.firstOrNull != null) {
          throw CreateException(
            message:
                'Asset already accounted, Location : ${assetIdCheck.first['location']}',
          );
        }
      }

      final checkAssetLocationAndBox = await txn.rawQuery(
        'SELECT * FROM t_asset_count_detail WHERE count_id = ? AND asset_id = ? AND location = ? AND box = ?',
        [countId, assetId, params.location, params.box],
      );

      print('Check Asset Location : $checkAssetLocationAndBox');

      if (checkAssetLocationAndBox.firstOrNull != null ||
          checkAssetLocationAndBox.isNotEmpty) {
        throw CreateException(
          message:
              'Asset already counted, Location : ${checkAssetLocationAndBox.first['location']}, Box : ${checkAssetLocationAndBox.first['box']}',
        );
      }

      final response = await txn.rawInsert(
        '''
        INSERT INTO t_asset_count_detail 
          (count_id, asset_id, serial_number, asset_name, location, status, condition, quantity)
        VALUES
          (?, ?, ?, ?, ?, ?, ?, ?)
        ''',
        [
          countId,
          assetId,
          params.serialNumber,
          params.assetName,
          params.location,
          params.status,
          params.condition,
          params.quantity,
        ],
      );

      if (response == 0) {
        throw CreateException(message: 'Failed to add asset');
      }

      return params;
    });
  }

  @override
  Future<AssetCountModel> updateStatusAssetCount(
    int id,
    StatusCount params,
  ) async {
    final db = await _db.database;

    final response = await db
        .rawUpdate('UPDATE t_asset_count SET status = ? WHERE id = ?', [
          params == StatusCount.CREATED
              ? 'CREATED'
              : params == StatusCount.ONPROCESS
              ? 'ONPROCESS'
              : 'COMPLETED',
          id,
        ]);

    if (response == 0) {
      throw UpdateException(message: 'Failed to update status count');
    }

    final result = await db.rawQuery(
      'SELECT * FROM t_asset_count WHERE id = ?',
      [id],
    );

    return AssetCountModel.fromMap(result.first);
  }
}
