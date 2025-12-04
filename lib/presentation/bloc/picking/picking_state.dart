// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'picking_bloc.dart';

enum StatusPicking {
  initial,
  loading,
  failure,
  loaded,
  insertItem,
  failureInsertItem,
  deleteItem,
  failureDeleteItem,
  successFindAsset,
  failureFindAsset,
  loadingFindAsset,
  updateStatusPreparationDetail,
  failedUpdateStatusPreparationDetail,
  successReadyPreparation,
  failedReadyPreparation,
}

// ignore: must_be_immutable
class PickingState extends Equatable {
  StatusPicking? status;
  List<Preparation>? preparations;
  Preparation? preparation;
  List<PreparationDetail>? preparationDetails;
  PreparationDetail? preparationDetail;
  List<PreparationItem>? itemsPreparation;
  List<PreparationItem>? itemsDetail;
  AssetEntity? asset;
  String? message;

  PickingState({
    this.status = StatusPicking.initial,
    this.preparations,
    this.preparation,
    this.preparationDetails,
    this.preparationDetail,
    this.itemsPreparation,
    this.itemsDetail,
    this.asset,
    this.message,
  });

  @override
  List<Object?> get props => [
    status,
    preparations,
    preparation,
    preparationDetails,
    preparationDetail,
    itemsPreparation,
    itemsDetail,
    asset,
    message,
  ];

  PickingState copyWith({
    StatusPicking? status,
    List<Preparation>? preparations,
    Preparation? preparation,
    List<PreparationDetail>? preparationDetails,
    PreparationDetail? preparationDetail,
    List<PreparationItem>? itemsPreparation,
    List<PreparationItem>? itemsDetail,
    AssetEntity? asset,
    String? message,
  }) {
    return PickingState(
      status: status ?? this.status,
      preparations: preparations ?? this.preparations,
      preparation: preparation ?? this.preparation,
      preparationDetails: preparationDetails ?? this.preparationDetails,
      preparationDetail: preparationDetail ?? this.preparationDetail,
      itemsPreparation: itemsPreparation ?? this.itemsPreparation,
      itemsDetail: itemsDetail ?? this.itemsDetail,
      asset: asset ?? this.asset,
      message: message ?? this.message,
    );
  }
}
