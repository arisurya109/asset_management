import 'dart:convert';

import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/features/asset_brand/data/model/asset_brand_model.dart';
import 'package:asset_management/features/asset_brand/data/source/asset_brand_remote_data_source.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/api_helper.dart';
import '../../../../core/core.dart';

class AssetBrandRemoteDataSourceImpl implements AssetBrandRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  AssetBrandRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<AssetBrandModel> createAssetBrand(AssetBrandModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/asset_brand'),
        body: jsonEncode(params.toJson()),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final data = body['data'];

        return AssetBrandModel.fromJson(data);
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<List<AssetBrandModel>> findAllAssetBrand() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_brand'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List data = body['data'];

        return data.map((e) => AssetBrandModel.fromJson(e)).toList();
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
