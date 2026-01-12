import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/picking/picking_detail_response.dart';
import 'package:asset_management/domain/repositories/picking/picking_repository.dart';
import 'package:dartz/dartz.dart';

class FindPickingDetailUseCase {
  final PickingRepository _repository;

  FindPickingDetailUseCase(this._repository);

  Future<Either<Failure, PickingDetailResponse>> call({required int id}) async {
    return _repository.findPickingDetail(id: id);
  }
}
