import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/model/asset/asset_detail_model.dart';
import 'package:asset_management/data/model/asset/asset_model.dart';
import 'package:asset_management/data/source/asset/asset_remote_data_source.dart';
import 'package:http/http.dart' as http;

class AssetRemoteDataSourceImpl implements AssetRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  AssetRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<AssetsModel> createAsset(AssetsModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/assets'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return AssetsModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<List<AssetsModel>> findAllAsset() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/assets/'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List datas = body['data'];

        return datas.map((e) => AssetsModel.fromJson(e)).toList();
      } else {
        print(jsonDecode(response.body));
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<List<AssetDetailModel>> findAssetDetailById(int params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/assets/$params'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List datas = body['data'];

        return datas.map((e) => AssetDetailModel.fromJson(e)).toList();
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<AssetsModel> createAssetTransfer({
    required int assetId,
    required String movementType,
    required int fromLocationId,
    required int toLocationId,
    int quantity = 1,
    String? notes,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/assets/$assetId/transfer'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode({
          'movement_type': movementType,
          'from_location_id': fromLocationId,
          'to_location_id': toLocationId,
          'quantity': quantity,
          'notes': notes,
        }),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return AssetsModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }
}
