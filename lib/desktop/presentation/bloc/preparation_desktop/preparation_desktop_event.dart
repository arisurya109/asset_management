part of 'preparation_desktop_bloc.dart';

class PreparationDesktopEvent extends Equatable {
  const PreparationDesktopEvent();

  @override
  List<Object> get props => [];
}

class OnFindPreparationPaginationEvent extends PreparationDesktopEvent {
  final int page;
  final int limit;
  final String? query;

  const OnFindPreparationPaginationEvent({
    required this.page,
    required this.limit,
    this.query,
  });
}
