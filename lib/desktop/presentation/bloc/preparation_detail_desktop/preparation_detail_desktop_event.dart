part of 'preparation_detail_desktop_bloc.dart';

class PreparationDetailDesktopEvent extends Equatable {
  const PreparationDetailDesktopEvent();

  @override
  List<Object> get props => [];
}

class OnAddPreparationDetailEvent extends PreparationDetailDesktopEvent {
  final PreparationDetail params;

  const OnAddPreparationDetailEvent(this.params);
}

class OnGetPreparationDetails extends PreparationDetailDesktopEvent {
  final int preparationId;

  const OnGetPreparationDetails(this.preparationId);
}
