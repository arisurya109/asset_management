part of 'picking_bloc.dart';

class PickingEvent extends Equatable {
  const PickingEvent();

  @override
  List<Object> get props => [];
}

class OnFindAllPickingTask extends PickingEvent {
  final int userId;

  const OnFindAllPickingTask(this.userId);
}

class OnFindPickingTaskDetail extends PickingEvent {
  final int preparationId;

  const OnFindPickingTaskDetail(this.preparationId);
}

class OnFindItemPickingDetail extends PickingEvent {
  final int preparationDetailId;

  const OnFindItemPickingDetail(this.preparationDetailId);
}

class OnInsertItemPicking extends PickingEvent {
  final PreparationItem params;

  const OnInsertItemPicking(this.params);
}

class OnFindAssetByAssetCodeAndLocation extends PickingEvent {
  final String assetCode;
  final String location;

  const OnFindAssetByAssetCodeAndLocation(this.assetCode, this.location);
}

class OnDeleteItemPicking extends PickingEvent {
  final PreparationItem preparationItem;
  final PreparationDetail preparationDetail;

  const OnDeleteItemPicking(this.preparationItem, this.preparationDetail);
}

class OnUpdateStatusCompletedPreparationDetail extends PickingEvent {
  final int id;

  const OnUpdateStatusCompletedPreparationDetail(this.id);
}

class OnSubmitReadyPreparation extends PickingEvent {
  final int preparationId;
  final int locationId;
  final int totalBox;
  final int userId;

  const OnSubmitReadyPreparation(
    this.preparationId,
    this.locationId,
    this.totalBox,
    this.userId,
  );
}

class OnStartPicking extends PickingEvent {
  final int preparationId;

  const OnStartPicking(this.preparationId);
}
