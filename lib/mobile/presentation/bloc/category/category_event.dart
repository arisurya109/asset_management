part of 'category_bloc.dart';

class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class OnFindCategoryByQuery extends CategoryEvent {
  final String params;

  const OnFindCategoryByQuery(this.params);
}

class OnCreateCategory extends CategoryEvent {
  final AssetCategory params;

  const OnCreateCategory(this.params);
}

class OnClearAll extends CategoryEvent {}
