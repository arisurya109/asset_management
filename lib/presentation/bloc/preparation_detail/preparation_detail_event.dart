part of 'preparation_detail_bloc.dart';

class PreparationDetailEvent extends Equatable {
  const PreparationDetailEvent();

  @override
  List<Object> get props => [];
}

class OnCreatePreparationDetail extends PreparationDetailEvent {
  final int preparationId;
  final List<PreparationDetail> params;

  const OnCreatePreparationDetail(this.preparationId, this.params);
}

class OnFindAllPreparationDetailByPreparationId extends PreparationDetailEvent {
  final int params;

  const OnFindAllPreparationDetailByPreparationId(this.params);
}

class OnFindPreparationDetailById extends PreparationDetailEvent {
  final int params;
  final int preparationId;

  const OnFindPreparationDetailById(this.params, this.preparationId);
}

class OnUpdatePreparationDetail extends PreparationDetailEvent {
  final PreparationDetail params;

  const OnUpdatePreparationDetail(this.params);
}
