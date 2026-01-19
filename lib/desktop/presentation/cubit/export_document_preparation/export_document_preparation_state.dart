// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'export_document_preparation_cubit.dart';

enum StatusExport { initial, loading, failure, success }

// ignore: must_be_immutable
class ExportDocumentPreparationState extends Equatable {
  StatusExport? status;
  String? message;
  String? path;

  ExportDocumentPreparationState({this.status, this.message, this.path});

  @override
  List<Object?> get props => [status, message, path];

  ExportDocumentPreparationState copyWith({
    StatusExport? status,
    String? message,
    String? path,
  }) {
    return ExportDocumentPreparationState(
      status: status ?? this.status,
      message: message ?? this.message,
      path: path ?? this.path,
    );
  }
}
