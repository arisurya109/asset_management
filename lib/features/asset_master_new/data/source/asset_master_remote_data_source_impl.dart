import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_master_new/data/models/asset_brand_model.dart';
import 'package:asset_management/features/asset_master_new/data/models/asset_category_model.dart';
import 'package:asset_management/features/asset_master_new/data/models/asset_model_model.dart';
import 'package:asset_management/features/asset_master_new/data/models/asset_type_model.dart';
import 'package:asset_management/features/asset_master_new/data/source/asset_master_remote_data_source.dart';
import 'package:http/http.dart' as _http;

class AssetMasterRemoteDataSourceImpl implements AssetMasterRemoteDataSource {
  final _http.Client _client;
  final TokenHelper _tokenHelper;

  AssetMasterRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<AssetBrandModel> createAssetBrand(AssetBrandModel params) async {
    final token = await _tokenHelper.getToken();

    final response = await _client.post(
      Uri.parse('${ApiHelper.baseUrl}/asset_brand'),
      headers: ApiHelper.headersToken(token!),
      body: jsonEncode(params.toJson()),
    );

    if (response.statusCode == 201) {
      final body = jsonDecode(response.body);

      final datas = body['data'];

      return AssetBrandModel.fromJson(datas);
    } else {
      final message = ApiHelper.getErrorMessage(response.body);
      throw CreateException(message: message);
    }
  }

  @override
  Future<AssetCategoryModel> createAssetCategory(
    AssetCategoryModel params,
  ) async {
    try {
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
    } catch (e) {
      throw CreateException(message: e.toString());
    }
  }

  @override
  Future<AssetModelModel> createAssetModel(AssetModelModel params) async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/asset_model'),
        headers: ApiHelper.headersToken(token!),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return AssetModelModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    } catch (e) {
      throw CreateException(message: e.toString());
    }
  }

  @override
  Future<AssetTypeModel> createAssetType(AssetTypeModel params) async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/asset_type'),
        headers: ApiHelper.headersToken(token!),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return AssetTypeModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    } catch (e) {
      throw CreateException(message: e.toString());
    }
  }

  @override
  Future<List<AssetBrandModel>> findAllAssetBrand() async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_brand'),
        headers: ApiHelper.headersToken(token!),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final datas = body['data'] as List<dynamic>;

        return datas.map((e) => AssetBrandModel.fromJson(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<List<AssetCategoryModel>> findAllAssetCategory() async {
    try {
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
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<List<AssetModelModel>> findAllAssetModel() async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_model'),
        headers: ApiHelper.headersToken(token!),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final datas = body['data'] as List<dynamic>;

        return datas.map((e) => AssetModelModel.fromJson(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<List<AssetTypeModel>> findAllAssetType() async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_type'),
        headers: ApiHelper.headersToken(token!),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final datas = body['data'] as List<dynamic>;

        return datas.map((e) => AssetTypeModel.fromJson(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<AssetBrandModel> findByIdAssetBrand(int params) async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_brand/$params'),
        headers: ApiHelper.headersToken(token!),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final datas = body['data'] as Map<String, dynamic>;

        return AssetBrandModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<AssetCategoryModel> findByIdAssetCategory(int params) async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_category/$params'),
        headers: ApiHelper.headersToken(token!),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final datas = body['data'] as Map<String, dynamic>;

        return AssetCategoryModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<AssetModelModel> findByIdAssetModel(int params) async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_model/$params'),
        headers: ApiHelper.headersToken(token!),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final datas = body['data'] as Map<String, dynamic>;

        return AssetModelModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<AssetTypeModel> findByIdAssetType(int params) async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_type/$params'),
        headers: ApiHelper.headersToken(token!),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final datas = body['data'] as Map<String, dynamic>;

        return AssetTypeModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<AssetBrandModel> updateAssetBrand(AssetBrandModel params) async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.put(
        Uri.parse('${ApiHelper.baseUrl}/asset_brand/${params.id}'),
        headers: ApiHelper.headersToken(token!),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final datas = body['data'] as Map<String, dynamic>;

        return AssetBrandModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<AssetCategoryModel> updateAssetCategory(
    AssetCategoryModel params,
  ) async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.put(
        Uri.parse('${ApiHelper.baseUrl}/asset_category/${params.id}'),
        headers: ApiHelper.headersToken(token!),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final datas = body['data'] as Map<String, dynamic>;

        return AssetCategoryModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<AssetModelModel> updateAssetModel(AssetModelModel params) async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.put(
        Uri.parse('${ApiHelper.baseUrl}/asset_model/${params.id}'),
        headers: ApiHelper.headersToken(token!),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final datas = body['data'] as Map<String, dynamic>;

        return AssetModelModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<AssetTypeModel> updateAssetType(AssetTypeModel params) async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.put(
        Uri.parse('${ApiHelper.baseUrl}/asset_type/${params.id}'),
        headers: ApiHelper.headersToken(token!),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final datas = body['data'] as Map<String, dynamic>;

        return AssetTypeModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }
}
