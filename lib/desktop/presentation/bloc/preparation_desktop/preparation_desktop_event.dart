part of 'preparation_desktop_bloc.dart';

class PreparationDesktopEvent extends Equatable {
  const PreparationDesktopEvent();

  @override
  List<Object> get props => [];
}

class OnFindAllPreparation extends PreparationDesktopEvent {}

class OnCreatePreparation extends PreparationDesktopEvent {
  final Preparation params;

  const OnCreatePreparation(this.params);
}
