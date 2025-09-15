part of 'asset_preparation_bloc.dart';

class AssetPreparationEvent extends Equatable {
  const AssetPreparationEvent();

  @override
  List<Object?> get props => [];
}

class OnFindAllPreparation extends AssetPreparationEvent {}

class OnCreatePreparation extends AssetPreparationEvent {
  final AssetPreparation params;

  const OnCreatePreparation(this.params);
}

class OnUpdateStatusPreparaion extends AssetPreparationEvent {
  final AssetPreparation params;

  const OnUpdateStatusPreparaion(this.params);
}

class OnExportPreparation extends AssetPreparationEvent {
  final int preparationId;

  const OnExportPreparation(this.preparationId);
}

class OnSelectedPreparation extends AssetPreparationEvent {
  final AssetPreparation params;

  const OnSelectedPreparation(this.params);
}
