// ignore_for_file: public_member_api_docs

import 'package:asset_management/data/model/preparation/preparation_document_model.dart';
import 'package:asset_management/data/model/preparation/preparation_model.dart';
import 'package:asset_management/data/model/preparation/preparation_pagination_model.dart';
import 'package:asset_management/domain/entities/preparation/preparation_request.dart';

abstract class PreparationRemoteDataSource {
  Future<List<String>> getPreparationTypes();
  Future<PreparationModel> createPreparation({
    required PreparationRequest params,
  });
  Future<PreparationPaginationModel> findPreparationByPagination({
    required int page,
    required int limit,
    String? query,
  });
  Future<PreparationModel> updatePreparationStatus({
    required PreparationRequest params,
  });
  Future<PreparationDocumentModel> dataExportPreparation({
    required int preparationId,
  });
}
