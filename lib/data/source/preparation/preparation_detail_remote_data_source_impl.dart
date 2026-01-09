// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/data/model/preparation/preparation_detail_model.dart';
import 'package:asset_management/data/model/preparation/preparation_detail_response_model.dart';
import 'package:asset_management/data/source/preparation/preparation_detail_remote_data_source.dart';
import 'package:http/http.dart' as http;

class PreparationDetailRemoteDataSourceImpl
    implements PreparationDetailRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  PreparationDetailRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<String> addPreparationDetail({
    required PreparationDetailModel params,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/preparation/${params.preparationId}'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        return body['status'];
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<PreparationDetailResponseModel> getPreparationDetails({
    required int preparationId,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation/$preparationId'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        return PreparationDetailResponseModel.fromJson(body['data']);
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
