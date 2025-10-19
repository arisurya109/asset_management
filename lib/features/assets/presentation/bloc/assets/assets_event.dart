part of 'assets_bloc.dart';

class AssetsEvent extends Equatable {
  const AssetsEvent();

  @override
  List<Object> get props => [];
}

class OnGetAllAssets extends AssetsEvent {}

class OnSearchAssets extends AssetsEvent {
  final String params;

  const OnSearchAssets(this.params);
}
