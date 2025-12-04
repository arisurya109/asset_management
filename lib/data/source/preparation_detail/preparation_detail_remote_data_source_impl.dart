import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/data/model/preparation_detail/preparation_detail_model.dart';
import 'package:asset_management/data/source/preparation_detail/preparation_detail_remote_data_source.dart';
import 'package:http/http.dart' as http;

class PreparationDetailRemoteDataSourceImpl
    implements PreparationDetailRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  PreparationDetailRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<PreparationDetailModel> createPreparationDetail({
    required PreparationDetailModel params,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/preparation_detail'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        final data = decoded['data'];

        return PreparationDetailModel.fromJson(data);
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<List<PreparationDetailModel>> findAllPreparationDetailByPreparationId({
    required int id,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation/$id/detail'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        List data = decoded['data'];

        return data.map((e) => PreparationDetailModel.fromJson(e)).toList();
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<PreparationDetailModel> findPreparationDetailById({
    required int id,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation_detail/$id'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final data = decoded['data'];

        return PreparationDetailModel.fromJson(data);
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<PreparationDetailModel> updatePreparationDetail({
    required PreparationDetailModel params,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw UpdateException(message: 'Token expired');
    } else {
      final response = await _client.put(
        Uri.parse('${ApiHelper.baseUrl}/preparation_detail/${params.id}'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final data = decoded['data'];

        return PreparationDetailModel.fromJson(data);
      } else {
        throw UpdateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<PreparationDetailModel> updateStatusPreparationDetail({
    required int id,
    required String params,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw UpdateException(message: 'Token expired');
    } else {
      final response = await _client.patch(
        Uri.parse('${ApiHelper.baseUrl}/preparation_detail/$id?status=$params'),
        headers: ApiHelper.headersToken(token),
      );

      print(response.body);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final data = decoded['data'];

        return PreparationDetailModel.fromJson(data);
      } else {
        throw UpdateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
