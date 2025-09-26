import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/config/database_helper.dart';
import '../model/asset_preparation_detail_model.dart';
import '../model/asset_preparation_model.dart';
import 'asset_preparation_source.dart';

class AssetPreparationSourceImpl implements AssetPreparationSource {
  final DatabaseHelper _db;

  AssetPreparationSourceImpl(this._db);

  @override
  Future<AssetPreparationModel> createPreparation(
    AssetPreparationModel params,
  ) async {
    final db = await _db.database;

    return db.transaction((txn) async {
      final rawIdListMap = await txn.rawQuery(
        'SELECT MAX(id) AS id FROM t_asset_preparations',
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

      final preparationCode =
          'AP${DateFormat('HHmmss').format(DateTime.now())}$lastId';

      params.preparationCode = preparationCode;

      final id = await txn.rawInsert(
        '''
        INSERT INTO t_asset_preparations (preparation_code, store_name, store_code, store_initial, status, type, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?)
        ''',
        [
          preparationCode,
          params.storeName,
          params.storeCode,
          params.storeInitial,
          params.status,
          params.type,
          params.createdAt,
        ],
      );

      params.id = id;

      return params;
    });
  }

  @override
  Future<String> deleteAssetPreparation(
    int preparationId,
    String params,
  ) async {
    final db = await _db.database;

    final response = await db.delete(
      't_asset_preparation_details',
      where: 'asset_preparation_id = ? AND asset = ?',
      whereArgs: [preparationId, params],
    );

    if (response > 0) {
      return 'Successfully Deleted $params';
    } else {
      throw DeleteException(message: 'Failed to delete $params');
    }
  }

  @override
  Future<String> exportPreparation(int preparationId) async {
    try {
      final db = await _db.database;

      final preparationsDetails = await db.rawQuery(
        '''
      SELECT
        tp.store_name AS store_name,
        tp.store_initial AS store_initial,
        tp.preparation_code AS preparation_code,
        tp.store_code AS store_code,
        tp.type AS store_type,
        tp.created_at AS created_at,
        tp.updated_at AS updated_at,
        tp.total_box AS total_box,
        td.asset AS asset,
        td.quantity AS quantity,
        td.location AS location,
        td.box AS box,
        td.type AS type
      FROM
        t_asset_preparation_details AS td
      LEFT JOIN
        t_asset_preparations AS tp ON td.asset_preparation_id = tp.id
      WHERE
        td.asset_preparation_id = ?
      ''',
        [preparationId],
      );

      if (preparationsDetails.firstOrNull == null) {
        debugPrint('Masuk sini');
        throw CreateException(message: 'Failed to export, please try again');
      }

      final rawData = preparationsDetails.first;

      final rawDataList = preparationsDetails;

      debugPrint(rawData.toString());

      String fileName = rawData['preparation_code'] as String;

      final excel = Excel.createExcel();

      final sheet = excel[fileName];

      sheet.merge(CellIndex.indexByString('A1'), CellIndex.indexByString('F3'));

      final cell = sheet.cell(CellIndex.indexByString('A1'));
      cell.value = TextCellValue('${rawData['preparation_code']}');

      cell.cellStyle = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
        fontFamily: getFontFamily(FontFamily.Calibri),
      );

      var a5 = sheet.cell(CellIndex.indexByString('A5'));
      var b5 = sheet.cell(CellIndex.indexByString('B5'));
      a5.value = TextCellValue('Name :');
      b5.value = TextCellValue(rawData['store_name'] as String);

      var a6 = sheet.cell(CellIndex.indexByString('A6'));
      var b6 = sheet.cell(CellIndex.indexByString('B6'));
      a6.value = TextCellValue('Initial :');
      b6.value = TextCellValue(rawData['store_initial'] as String);

      var a7 = sheet.cell(CellIndex.indexByString('A7'));
      var b7 = sheet.cell(CellIndex.indexByString('B7'));
      a7.value = TextCellValue('Code :');
      b7.value = IntCellValue(rawData['store_code'] as int);

      var e5 = sheet.cell(CellIndex.indexByString('E5'));
      var f5 = sheet.cell(CellIndex.indexByString('F5'));
      e5.value = TextCellValue('Type :');
      f5.value = TextCellValue(rawData['store_type'] as String);

      var e6 = sheet.cell(CellIndex.indexByString('E6'));
      var f6 = sheet.cell(CellIndex.indexByString('F6'));
      e6.value = TextCellValue('Created :');
      f6.value = TextCellValue(
        DateFormat(
          'HH:mm  dd-MMMM-yyyy',
        ).format(DateTime.parse(rawData['created_at'] as String)),
      );

      var e7 = sheet.cell(CellIndex.indexByString('E7'));
      var f7 = sheet.cell(CellIndex.indexByString('F7'));
      e7.value = TextCellValue('Completed :');
      f7.value = TextCellValue(
        DateFormat(
          'HH:mm  dd-MMMM-yyyy',
        ).format(DateTime.parse(rawData['updated_at'] as String)),
      );

      var a8 = sheet.cell(CellIndex.indexByString('A8'));
      var b8 = sheet.cell(CellIndex.indexByString('B8'));
      a8.value = TextCellValue('Total Box :');
      b8.value = IntCellValue(rawData['total_box'] as int);

      sheet.cell(CellIndex.indexByString('A9'));
      sheet.cell(CellIndex.indexByString('B9'));
      sheet.cell(CellIndex.indexByString('A9'));
      sheet.cell(CellIndex.indexByString('B9'));

      const headerStartRow = 10;
      const dataStartRow = headerStartRow + 1;

      final headers = ['No', 'Asset', 'Type', 'Quantity', 'Location', 'Box'];
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

      // Data mulai dari baris ke-10
      for (var i = 0; i < rawDataList.length; i++) {
        final rowIndex = dataStartRow + i;
        final rowData = [
          IntCellValue(i + 1),
          TextCellValue(rawDataList[i]['asset'] as String),
          TextCellValue(rawDataList[i]['type'] as String),
          IntCellValue(rawDataList[i]['quantity'] as int),
          TextCellValue(rawDataList[i]['location'] as String),
          TextCellValue(rawDataList[i]['box'] as String),
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
      final filePath = '${directory!.path}/$fileName.xlsx';

      final file = File(filePath);
      await file.create(recursive: true);
      await file.writeAsBytes(fileBytes!);

      debugPrint(file.path);

      return file.path;
    } catch (e) {
      debugPrint('Masuk Sini : $e');
      throw CreateException(message: 'Failed to exported, please try again');
    }
  }

  @override
  Future<List<AssetPreparationDetailModel>> findAllAssetPreparation(
    int preparationId,
  ) async {
    final db = await _db.database;

    final result = await db.query(
      't_asset_preparation_details',
      where: 'asset_preparation_id = ?',
      whereArgs: [preparationId],
    );

    return result
        .map((e) => AssetPreparationDetailModel.fromDatabase(e))
        .toList();
  }

  @override
  Future<List<AssetPreparationModel>> findAllPreparations() async {
    final db = await _db.database;

    final result = await db.query('t_asset_preparations');

    return result.map((e) => AssetPreparationModel.fromDatabase(e)).toList();
  }

  @override
  Future<AssetPreparationDetailModel> insertAssetPreparation(
    AssetPreparationDetailModel params,
  ) async {
    final db = await _db.database;

    return await db.transaction((txn) async {
      final isCheckAssetAlreadyExists = await txn.rawQuery(
        'SELECT * FROM t_asset_preparation_details WHERE asset_preparation_id = ? AND asset = UPPER(?) LIMIT 1',
        [params.preparationId, params.asset?.toUpperCase()],
      );

      if (isCheckAssetAlreadyExists.isNotEmpty) {
        throw CreateException(
          message:
              'Asset already exist, ${isCheckAssetAlreadyExists.first['location']}',
        );
      }

      await txn.insert('t_asset_preparation_details', params.toDatabase());

      return params;
    });
  }

  @override
  Future<AssetPreparationModel> updateStatusPreparation(
    AssetPreparationModel params,
  ) async {
    final db = await _db.database;

    if (params.status == PreparationStatus.inprogress) {
      await db.rawUpdate(
        'UPDATE t_asset_preparations SET status = ? WHERE id = ?',
        [params.status, params.id],
      );
    } else {
      await db.rawUpdate(
        'UPDATE t_asset_preparations SET status = ?, total_box = ?, updated_at = ? WHERE id = ?',
        [params.status, params.totalBox, params.updatedAt, params.id],
      );
    }

    final newPreparation = await db.rawQuery(
      'SELECT * FROM t_asset_preparations WHERE id = ? LIMIT 1',
      [params.id],
    );

    return AssetPreparationModel.fromDatabase(newPreparation.first);
  }

  @override
  Future<AssetPreparationModel> findPreparationById(int id) async {
    final db = await _db.database;

    final result = await db.query(
      't_asset_preparations',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      throw NotFoundException(message: 'Not Found Preparation');
    } else {
      return AssetPreparationModel.fromDatabase(result.first);
    }
  }
}
