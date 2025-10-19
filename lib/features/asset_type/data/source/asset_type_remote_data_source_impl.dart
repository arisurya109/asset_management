import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_type/data/model/asset_type_model.dart';
import 'package:asset_management/features/asset_type/data/source/asset_type_remote_data_source.dart';
import 'package:http/http.dart' as http;

class AssetTypeRemoteDataSourceImpl implements AssetTypeRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  AssetTypeRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<AssetTypeModel> createAssetType(AssetTypeModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/asset_type'),
        body: jsonEncode(params.toJson()),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final data = body['data'];

        return AssetTypeModel.fromJson(data);
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<List<AssetTypeModel>> findAllAssetType() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_type'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List data = body['data'];

        return data.map((e) => AssetTypeModel.fromJson(e)).toList();
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
