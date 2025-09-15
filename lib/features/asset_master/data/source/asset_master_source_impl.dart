import 'package:asset_management/core/config/database_helper.dart';
import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/features/asset_master/data/model/asset_master_model.dart';
import 'package:asset_management/features/asset_master/data/source/asset_master_source.dart';

class AssetMasterSourceImpl implements AssetMasterSource {
  final DatabaseHelper _db;

  AssetMasterSourceImpl(this._db);

  @override
  Future<List<AssetMasterModel>> findAllAssetMaster() async {
    final db = await _db.database;

    final response = await db.rawQuery('SELECT * FROM t_asset_non_id');

    return response.map((e) => AssetMasterModel.fromDatabase(e)).toList();
  }

  @override
  Future<AssetMasterModel> insertAssetMaster(AssetMasterModel params) async {
    final db = await _db.database;

    return await db.transaction((txn) async {
      final checkAssetName = await txn.rawQuery(
        'SELECT * FROM t_asset_non_id WHERE name = UPPER(?)',
        [params.name?.toUpperCase()],
      );

      if (checkAssetName.isNotEmpty) {
        throw CreateException(
          message: 'Failed to insert new asset, Asset already exist',
        );
      }

      final inserted = await txn.insert('t_asset_non_id', params.toDatabase());

      final rawNewAsset = await txn.query(
        't_asset_non_id',
        where: 'id = ?',
        limit: 1,
        whereArgs: [inserted],
      );

      if (rawNewAsset.isEmpty) {
        throw CreateException(
          message: 'Failed to insert new asset, please try again',
        );
      }

      return AssetMasterModel.fromDatabase(rawNewAsset.first);
    });
  }

  @override
  Future<AssetMasterModel> updateAssetMaster(AssetMasterModel params) async {
    final db = await _db.database;

    final response = await db.rawUpdate(
      '''
      UPDATE t_asset_non_id
      SET name = ?, type = ?
      WHERE id = ?
      ''',
      [params.name, params.type, params.id],
    );

    if (response == 0) {
      throw UpdateException(message: 'Error occurred, failed to update asset');
    } else {
      final result = await db.rawQuery(
        'SELECT * FROM t_asset_non_id WHERE id = ? LIMIT 1',
        [params.id],
      );

      return AssetMasterModel.fromDatabase(result.first);
    }
  }
}
