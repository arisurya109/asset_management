// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'category_bloc.dart';

enum StatusCategory { initial, loading, failure, success }

class CategoryState extends Equatable {
  StatusCategory? status;
  List<AssetCategory>? categories;
  String? message;

  CategoryState({
    this.status = StatusCategory.initial,
    this.categories,
    this.message,
  });

  @override
  List<Object?> get props => [status, categories, message];

  CategoryState copyWith({
    StatusCategory? status,
    List<AssetCategory>? categories,
    bool clearAll = false,

    String? message,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: clearAll ? null : (categories ?? this.categories),
      message: message ?? this.message,
    );
  }
}
