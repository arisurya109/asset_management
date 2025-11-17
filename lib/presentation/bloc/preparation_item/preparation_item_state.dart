// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'preparation_item_bloc.dart';

enum StatusPreparationItem { initial, loading, failed, success }

// ignore: must_be_immutable
class PreparationItemState extends Equatable {
  StatusPreparationItem? status;
  List<PreparationItem>? preparationItems;
  List<PreparationItem>? preparationItem;
  String? message;

  PreparationItemState({
    this.status = StatusPreparationItem.initial,
    this.preparationItems,
    this.preparationItem,
    this.message,
  });

  @override
  List<Object?> get props => [
    status,
    preparationItems,
    preparationItem,
    message,
  ];

  PreparationItemState copyWith({
    StatusPreparationItem? status,
    List<PreparationItem>? preparationItems,
    List<PreparationItem>? preparationItem,
    String? message,
  }) {
    return PreparationItemState(
      status: status ?? this.status,
      preparationItems: preparationItems ?? this.preparationItems,
      preparationItem: preparationItem ?? this.preparationItem,
      message: message ?? this.message,
    );
  }
}
