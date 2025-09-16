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

    final id = await db.insert('t_asset_preparations', params.toDatabase());

    params.id = id;

    return params;
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
  Future<String> exportPreparation(int preparationId) {
    // TODO: implement exportPreparation
    throw UnimplementedError();
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
}
