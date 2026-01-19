part of 'preparation_detail_desktop_bloc.dart';

class PreparationDetailDesktopEvent extends Equatable {
  const PreparationDetailDesktopEvent();

  @override
  List<Object> get props => [];
}

class OnAddPreparationDetailEvent extends PreparationDetailDesktopEvent {
  final PreparationDetailRequest params;

  const OnAddPreparationDetailEvent(this.params);
}

class OnDeletePreparationDetailEvent extends PreparationDetailDesktopEvent {
  final int id;
  final int preparationId;

  const OnDeletePreparationDetailEvent(this.id, this.preparationId);
}

class OnGetPreparationDetails extends PreparationDetailDesktopEvent {
  final int preparationId;

  const OnGetPreparationDetails(this.preparationId);
}
