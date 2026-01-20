import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/model/preparation/preparation_document_model.dart';
import 'package:asset_management/data/model/preparation/preparation_model.dart';
import 'package:asset_management/data/model/preparation/preparation_pagination_model.dart';
import 'package:asset_management/data/source/preparation/preparation_remote_data_source.dart';
import 'package:asset_management/domain/entities/preparation/preparation_request.dart';
import 'package:http/http.dart' as http;

class PreparationRemoteDataSourceImpl implements PreparationRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  PreparationRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<PreparationModel> createPreparation({
    required PreparationRequest params,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/preparation/'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJsonCreate()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return PreparationModel.fromJson(datas);
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
    required PreparationRequest params,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    }

    try {
      final response = await _client
          .patch(
            Uri.parse('${ApiHelper.baseUrl}/preparation/${params.id}'),
            headers: ApiHelper.headersToken(token),
            body: jsonEncode(params.toJsonUpdate()),
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['data'] == null) {
          throw UpdateException(message: 'Data not found in server response');
        }

        return PreparationModel.fromJson(body['data']);
      } else {
        throw UpdateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    } on SocketException {
      throw UpdateException(
        message: 'Connection lost. Server is taking too long to process.',
      );
    } on TimeoutException {
      throw UpdateException(
        message:
            'The waiting time is over. Please check the data status periodically.',
      );
    } catch (e) {
      if (e is UpdateException) rethrow;
      throw UpdateException(message: 'An error has occurred: ${e.toString()}');
    }
  }

  @override
  Future<PreparationDocumentModel> dataExportPreparation({
    required int preparationId,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation/$preparationId/document'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        return PreparationDocumentModel.fromJson(body['data']);
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
