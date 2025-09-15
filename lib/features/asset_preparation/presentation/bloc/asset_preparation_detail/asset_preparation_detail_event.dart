part of 'asset_preparation_detail_bloc.dart';

class AssetPreparationDetailEvent extends Equatable {
  const AssetPreparationDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnInsertPreparationDetails extends AssetPreparationDetailEvent {
  final AssetPreparationDetail params;

  const OnInsertPreparationDetails(this.params);
}

class OnDeletedPreparationDetails extends AssetPreparationDetailEvent {
  final AssetPreparationDetail params;

  const OnDeletedPreparationDetails(this.params);
}

class OnFindAllPreparationDetails extends AssetPreparationDetailEvent {
  final int preparationId;

  const OnFindAllPreparationDetails(this.preparationId);
}
