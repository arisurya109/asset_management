part of 'model_bloc.dart';

class ModelEvent extends Equatable {
  const ModelEvent();

  @override
  List<Object> get props => [];
}

class OnCreateModel extends ModelEvent {
  final AssetModel params;

  const OnCreateModel(this.params);
}

class OnFindModelByQuery extends ModelEvent {
  final String params;

  const OnFindModelByQuery(this.params);
}

class OnClearAll extends ModelEvent {}
