import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/model/master/asset_brand_model.dart';
import 'package:asset_management/data/model/master/asset_category_model.dart';
import 'package:asset_management/data/model/master/asset_model_model.dart';
import 'package:asset_management/data/model/master/asset_type_model.dart';
import 'package:asset_management/data/model/master/location_model.dart';
import 'package:asset_management/data/model/master/preparation_template_item_model.dart';
import 'package:asset_management/data/model/master/preparation_template_model.dart';
import 'package:asset_management/data/model/master/vendor_model.dart';
import 'package:asset_management/data/source/master/master_remote_data_source.dart';
import 'package:http/http.dart' as http;

class MasterRemoteDataSourceImpl implements MasterRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  MasterRemoteDataSourceImpl(this._client, this._tokenHelper);

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
        final bodyResponse = jsonDecode(response.body);
        final datas = bodyResponse['data'];

        return AssetBrandModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<AssetCategoryModel> createAssetCategory(
    AssetCategoryModel params,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/asset_category'),
        body: jsonEncode(params.toJson()),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 201) {
        final bodyResponse = jsonDecode(response.body);
        final datas = bodyResponse['data'];

        return AssetCategoryModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<AssetModelModel> createAssetModel(AssetModelModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/asset_model'),
        body: jsonEncode(params.toJson()),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 201) {
        final bodyResponse = jsonDecode(response.body);
        final datas = bodyResponse['data'];

        return AssetModelModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<AssetTypeModel> createAssetType(AssetTypeModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/asset_type'),
        body: jsonEncode(params.toJson()),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 201) {
        final bodyResponse = jsonDecode(response.body);
        final datas = bodyResponse['data'];

        return AssetTypeModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<LocationModel> createLocation(LocationModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/location'),
        body: jsonEncode(params.toAPI()),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 201) {
        final bodyResponse = jsonDecode(response.body);
        final datas = bodyResponse['data'];

        return LocationModel.fromAPI(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<VendorModel> createVendor(VendorModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/vendor'),
        body: jsonEncode(params.toJson()),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 201) {
        final bodyResponse = jsonDecode(response.body);
        final datas = bodyResponse['data'];

        return VendorModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<List<AssetBrandModel>> findAllAssetBrand() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_brand'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final bodyResponse = jsonDecode(response.body);
        List datas = bodyResponse['data'];

        return datas.map((e) => AssetBrandModel.fromJson(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    }
  }

  @override
  Future<List<AssetCategoryModel>> findAllAssetCategory() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_category'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final bodyResponse = jsonDecode(response.body);
        List datas = bodyResponse['data'];

        return datas.map((e) => AssetCategoryModel.fromJson(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    }
  }

  @override
  Future<List<AssetModelModel>> findAllAssetModel() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_model'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final bodyResponse = jsonDecode(response.body);
        List datas = bodyResponse['data'];

        return datas.map((e) => AssetModelModel.fromJson(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    }
  }

  @override
  Future<List<AssetTypeModel>> findAllAssetType() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_type'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final bodyResponse = jsonDecode(response.body);
        List datas = bodyResponse['data'];

        return datas.map((e) => AssetTypeModel.fromJson(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    }
  }

  @override
  Future<List<LocationModel>> findAllLocation() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/location'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final bodyResponse = jsonDecode(response.body);
        List datas = bodyResponse['data'];

        return datas.map((e) => LocationModel.fromAPI(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    }
  }

  @override
  Future<List<VendorModel>> findAllVendor() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/vendor'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final bodyResponse = jsonDecode(response.body);
        List datas = bodyResponse['data'];

        return datas.map((e) => VendorModel.fromJson(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    }
  }

  @override
  Future<PreparationTemplateModel> createPreparationTemplate(
    PreparationTemplateModel params,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/preparation_template'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return PreparationTemplateModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<List<PreparationTemplateItemModel>> createPreparationTemplateItem(
    List<PreparationTemplateItemModel> params,
    int templateId,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/preparation_template/$templateId'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode({'data': params.map((e) => e.toJson()).toList()}),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        List datas = body['data'];

        return datas
            .map((e) => PreparationTemplateItemModel.fromJson(e))
            .toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<String> deletePreparationTemplate(int params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.delete(
        Uri.parse('${ApiHelper.baseUrl}/preparation_template/$params'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        String datas = body['message'];

        return datas;
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw DeleteException(message: message);
      }
    }
  }

  @override
  Future<List<PreparationTemplateModel>> findAllPreparationTemplate() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation_template'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List datas = body['data'];

        return datas.map((e) => PreparationTemplateModel.fromJson(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    }
  }

  @override
  Future<List<PreparationTemplateItemModel>>
  findAllPreparationTemplateItemByTemplateId(int params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation_template/$params'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List datas = body['data'];

        return datas
            .map((e) => PreparationTemplateItemModel.fromJson(e))
            .toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    }
  }
}
