import 'dart:convert';

import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/features/asset_category/data/model/asset_category_model.dart';
import 'package:asset_management/features/asset_category/data/source/asset_category_remote_data_source.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/api_helper.dart';
import '../../../../core/core.dart';

class AssetCategoryRemoteDataSourceImpl
    implements AssetCategoryRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  AssetCategoryRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<AssetCategoryModel> createAssetCategory(
    AssetCategoryModel params,
  ) async {
    final token = await _tokenHelper.getToken();

    final response = await _client.post(
      Uri.parse('${ApiHelper.baseUrl}/asset_category'),
      headers: ApiHelper.headersToken(token!),
      body: jsonEncode(params.toJson()),
    );

    if (response.statusCode == 201) {
      final body = jsonDecode(response.body);

      final datas = body['data'];

      return AssetCategoryModel.fromJson(datas);
    } else {
      final message = ApiHelper.getErrorMessage(response.body);
      throw CreateException(message: message);
    }
  }

  @override
  Future<List<AssetCategoryModel>> findAllAssetCategory() async {
    final token = await _tokenHelper.getToken();

    final response = await _client.get(
      Uri.parse('${ApiHelper.baseUrl}/asset_category'),
      headers: ApiHelper.headersToken(token!),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      final datas = body['data'] as List<dynamic>;

      return datas.map((e) => AssetCategoryModel.fromJson(e)).toList();
    } else {
      final message = ApiHelper.getErrorMessage(response.body);
      throw NotFoundException(message: message);
    }
  }
}
