import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/model/preparation/preparation_model.dart';
import 'package:asset_management/data/model/preparation/preparation_pagination_model.dart';
import 'package:asset_management/data/source/preparation/preparation_remote_data_source.dart';
import 'package:http/http.dart' as http;

class PreparationRemoteDataSourceImpl implements PreparationRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  PreparationRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<PreparationModel> createPreparation({
    required PreparationModel params,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/preparation/'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.createToJson()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return PreparationModel.fromEntity(datas);
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<PreparationPaginationModel> findPreparationByPagination({
    required int page,
    required int limit,
    String? query,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      String path = 'limit=$limit&page=$page';
      if (query.isFilled()) {
        path = '$path&query=$query';
      }
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation?$path'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        return PreparationPaginationModel.fromJson(body);
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<List<String>> getPreparationTypes() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation?query=TYPES'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final datas = (body['data'] as List).map((e) => e.toString()).toList();

        return datas;
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<PreparationModel> updatePreparationStatus({
    required int id,
    required String params,
    int? totalBox,
    int? temporaryLocationId,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      Map<String, dynamic> paramsJson = {'status': params};

      if (totalBox != null) {
        paramsJson.addAll({'total_box': totalBox});
      } else if (temporaryLocationId != null) {
        if (totalBox != null) {
          paramsJson.addAll({'temporary_location_id': temporaryLocationId});
        }
      }
      final response = await _client.patch(
        Uri.parse('${ApiHelper.baseUrl}/preparation/$id/'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(paramsJson),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        return body;
      } else {
        throw UpdateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
