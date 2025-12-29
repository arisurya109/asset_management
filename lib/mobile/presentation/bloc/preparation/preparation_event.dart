part of 'preparation_bloc.dart';

class PreparationEvent extends Equatable {
  const PreparationEvent();

  @override
  List<Object> get props => [];
}

class OnCreatePreparation extends PreparationEvent {
  final Preparation preparation;
  final List<PreparationDetail> preparationDetail;

  const OnCreatePreparation(this.preparation, this.preparationDetail);
}

class OnFindAllPreparation extends PreparationEvent {}

class OnFindPreparationById extends PreparationEvent {
  final int id;

  const OnFindPreparationById(this.id);
}

class OnUpdateStatusPreparation extends PreparationEvent {
  final int id;
  final String params;

  const OnUpdateStatusPreparation(this.id, this.params);
}

class OnCompletedPreparation extends PreparationEvent {
  final int id;
  final PlatformFile file;

  const OnCompletedPreparation(this.id, this.file);
}

class OnFindItemByPreparationDetail extends PreparationEvent {
  final int preparationDetailId;

  const OnFindItemByPreparationDetail(this.preparationDetailId);
}
