import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/model/preparation/preparation_detail_model.dart';
import 'package:asset_management/data/model/preparation/preparation_item_model.dart';
import 'package:asset_management/data/model/preparation/preparation_model.dart';
import 'package:asset_management/data/source/preparation/preparation_remote_data_source.dart';
import 'package:http/http.dart' as http;

class PreparationRemoteDataSourceImpl implements PreparationRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  PreparationRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<PreparationModel> createPreparation(PreparationModel params) async {
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
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return PreparationModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
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
        final body = jsonDecode(response.body);

        List datas = body['data'];

        return datas.map((e) => PreparationModel.fromJson(e)).toList();
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<PreparationModel> findPreparationById(int params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation/$params'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        Map<String, dynamic> datas = body['data'];

        return PreparationModel.fromJson(datas);
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<PreparationModel> updatePreparation(PreparationModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.put(
        Uri.parse('${ApiHelper.baseUrl}/preparation/${params.id}'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        Map<String, dynamic> datas = body['data'];

        return PreparationModel.fromJson(datas);
      } else {
        throw UpdateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<PreparationDetailModel> createPreparationDetail(
    PreparationDetailModel params,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse(
          '${ApiHelper.baseUrl}/preparation/${params.preparationId}/detail',
        ),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return PreparationDetailModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<PreparationItemModel> createPreparationItem(
    PreparationItemModel params,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse(
          '${ApiHelper.baseUrl}/preparation/${params.preparationId}/detail/${params.preparationDetailId}/item',
        ),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return PreparationItemModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<List<PreparationDetailModel>> findAllPreparationDetailByPreparationId(
    int params,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation/$params/detail'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List datas = body['data'];

        return datas.map((e) => PreparationDetailModel.fromJson(e)).toList();
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<List<PreparationItemModel>>
  findAllPreparationItemByPreparationDetailId(
    int params,
    int preparationId,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse(
          '${ApiHelper.baseUrl}/preparation/$preparationId/detail/$params/item',
        ),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List datas = body['data'];

        return datas.map((e) => PreparationItemModel.fromJson(e)).toList();
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<List<PreparationItemModel>> findAllPreparationItemByPreparationId(
    int params,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation/$params/items'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List datas = body['data'];

        return datas.map((e) => PreparationItemModel.fromJson(e)).toList();
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<PreparationDetailModel> findPreparationDetailById(
    int params,
    int preparationId,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse(
          '${ApiHelper.baseUrl}/preparation/$preparationId/detail/$params',
        ),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        Map<String, dynamic> datas = body['data'];

        return PreparationDetailModel.fromJson(datas);
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<PreparationDetailModel> updatePreparationDetail(
    PreparationDetailModel params,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.put(
        Uri.parse(
          '${ApiHelper.baseUrl}/preparation/${params.preparationId}/detail/${params.id}',
        ),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        Map<String, dynamic> datas = body['data'];

        return PreparationDetailModel.fromJson(datas);
      } else {
        throw UpdateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
