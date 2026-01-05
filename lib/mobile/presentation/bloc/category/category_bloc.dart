import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/usecases/master/create_asset_category_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_asset_category_by_query_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CreateAssetCategoryUseCase _create;
  final FindAssetCategoryByQueryUseCase _findQuery;

  CategoryBloc(this._create, this._findQuery) : super(CategoryState()) {
    on<OnCreateCategory>((event, emit) async {
      emit(state.copyWith(status: StatusCategory.loading));

      final failureOrCategory = await _create(event.params);

      return failureOrCategory.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusCategory.failure,
            message: failure.message,
          ),
        ),
        (_) => emit(state.copyWith(status: StatusCategory.success)),
      );
    });

    on<OnFindCategoryByQuery>((event, emit) async {
      emit(state.copyWith(status: StatusCategory.loading));

      final failureOrCategories = await _findQuery(event.params);

      return failureOrCategories.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusCategory.failure,
            message: failure.message,
          ),
        ),
        (categories) => emit(
          state.copyWith(
            status: StatusCategory.success,
            categories: categories,
          ),
        ),
      );
    });

    on<OnClearAll>((event, emit) async {
      emit(state.copyWith(clearAll: true));
    });
  }
}
