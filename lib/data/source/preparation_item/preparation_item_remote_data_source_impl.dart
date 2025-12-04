import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/model/preparation_item/preparation_item_model.dart';
import 'package:asset_management/data/source/preparation_item/preparation_item_remote_data_source.dart';
import 'package:http/http.dart' as http;

class PreparationItemRemoteDataSourceImpl
    implements PreparationItemRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  PreparationItemRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<PreparationItemModel> createPreparationItem({
    required PreparationItemModel params,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/preparation_item'),
        body: jsonEncode(params.toJson()),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        final data = decoded['data'];

        return PreparationItemModel.fromJson(data);
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<String> deletePreparationItem({required int id}) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw DeleteException(message: 'Token expired');
    } else {
      final response = await _client.delete(
        Uri.parse('${ApiHelper.baseUrl}/preparation_item/$id'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final status = decoded['status'];

        return status;
      } else {
        throw DeleteException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<List<PreparationItemModel>>
  findAllPreparationItemByPreparationDetailId({required int id}) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation_detail/$id/item'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        List data = decoded['data'];

        return data.map((e) => PreparationItemModel.fromJson(e)).toList();
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<List<PreparationItemModel>> findAllPreparationItemByPreparationId({
    required int id,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation/$id/item'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        List data = decoded['data'];

        return data.map((e) => PreparationItemModel.fromJson(e)).toList();
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
