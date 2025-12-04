// ignore_for_file: implementation_imports

import 'dart:convert';
import 'dart:io';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/data/model/preparation/preparation_model.dart';
import 'package:asset_management/data/source/preparation/preparation_remote_data_source.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:http/http.dart' as http;

import '../../../core/error/exception.dart';

class PreparationRemoteDataSourceImpl implements PreparationRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  PreparationRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<PreparationModel> completedPreparation({
    required int id,
    required PlatformFile file,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw UpdateException(message: 'Token expired');
    } else {
      final fileBytes = await File(file.path!).readAsBytes();
      final fileBase64 = base64Encode(fileBytes);

      final body = {"file_name": file.name, "file_base64": fileBase64};

      final response = await _client.patch(
        Uri.parse('${ApiHelper.baseUrl}/preparation/$id?status=COMPLETED'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final data = decoded['data'];

        return PreparationModel.fromJson(data);
      } else {
        throw UpdateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<PreparationModel> createPreparation({
    required PreparationModel params,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/preparation'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201) {
        final decoded = jsonDecode(response.body);

        final data = decoded['data'];

        return PreparationModel.fromJson(data);
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<List<PreparationModel>> findAllPreparation() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final bodyResponse = jsonDecode(response.body);
        List datas = bodyResponse['data'];

        return datas.map((e) => PreparationModel.fromJson(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    }
  }

  @override
  Future<PreparationModel> findPreparationById({required int id}) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation/$id'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final bodyResponse = jsonDecode(response.body);
        final data = bodyResponse['data'];

        return PreparationModel.fromJson(data);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    }
  }

  @override
  Future<PreparationModel> updateStatusPreparation({
    required int id,
    required String params,
    int? locationId,
    int? totalBox,
  }) async {
    final token = await _tokenHelper.getToken();

    print(
      jsonEncode(<String, dynamic>{
        'location_id': locationId,
        'total_box': totalBox,
      }),
    );

    if (token == null) {
      throw UpdateException(message: 'Token expired');
    } else {
      if (locationId != null && totalBox != null) {
        final response = await _client.patch(
          Uri.parse('${ApiHelper.baseUrl}/preparation/$id?status=$params'),
          body: jsonEncode(<String, dynamic>{
            'location_id': locationId,
            'total_box': totalBox,
          }),
          headers: ApiHelper.headersToken(token),
        );

        if (response.statusCode == 200) {
          final bodyResponse = jsonDecode(response.body);
          final data = bodyResponse['data'];

          return PreparationModel.fromJson(data);
        } else {
          final message = ApiHelper.getErrorMessage(response.body);
          throw UpdateException(message: message);
        }
      } else {
        final response = await _client.patch(
          Uri.parse('${ApiHelper.baseUrl}/preparation/$id?status=$params'),
          headers: ApiHelper.headersToken(token),
        );

        if (response.statusCode == 200) {
          final bodyResponse = jsonDecode(response.body);
          final data = bodyResponse['data'];

          return PreparationModel.fromJson(data);
        } else {
          final message = ApiHelper.getErrorMessage(response.body);
          throw UpdateException(message: message);
        }
      }
    }
  }
}
