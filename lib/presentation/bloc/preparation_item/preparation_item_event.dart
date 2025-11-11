// ignore_for_file: must_be_immutable

part of 'preparation_item_bloc.dart';

class PreparationItemEvent extends Equatable {
  const PreparationItemEvent();

  @override
  List<Object> get props => [];
}

class OnCreatePreparationItem extends PreparationItemEvent {
  final PreparationItem params;

  const OnCreatePreparationItem(this.params);
}

class OnFindAllPreparationItemsByPreparationId extends PreparationItemEvent {
  final int preparationId;

  const OnFindAllPreparationItemsByPreparationId(this.preparationId);
}

class OnFindAllPreparationItemsByPreparationDetailId
    extends PreparationItemEvent {
  final int preparationDetailId;
  final int preparationId;

  const OnFindAllPreparationItemsByPreparationDetailId(
    this.preparationDetailId,
    this.preparationId,
  );
}

class OnSelectedPreparationItem extends PreparationItemEvent {
  final PreparationItem params;

  const OnSelectedPreparationItem(this.params);
}
