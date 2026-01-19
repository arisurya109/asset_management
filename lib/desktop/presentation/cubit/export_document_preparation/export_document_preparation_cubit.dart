import 'dart:io';

import 'package:asset_management/desktop/presentation/components/app_pdf.dart';
import 'package:asset_management/domain/usecases/preparation/data_export_preparation_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'export_document_preparation_state.dart';

class ExportDocumentPreparationCubit
    extends Cubit<ExportDocumentPreparationState> {
  final DataExportPreparationUseCase _useCase;

  ExportDocumentPreparationCubit(this._useCase)
    : super(ExportDocumentPreparationState());

  void setInitialState() {
    emit(state.copyWith(status: StatusExport.initial));
  }

  void exportDocument(int params) async {
    emit(state.copyWith(status: StatusExport.loading));

    final failureOrDocs = await _useCase(preparationId: params);

    return failureOrDocs.fold(
      (failure) => emit(
        state.copyWith(status: StatusExport.failure, message: failure.message),
      ),
      (docs) async {
        final Directory? downloadsDir = await getDownloadsDirectory();
        if (downloadsDir == null) {
          emit(
            state.copyWith(
              status: StatusExport.failure,
              message:
                  'An error occurred, unable to access the Downloads folder',
            ),
          );
        }

        String fileName = '${docs.code}.pdf';
        String filePath = p.join(downloadsDir!.path, fileName);

        File file = File(filePath);
        if (await file.exists()) {
          final String timestamp = DateFormat(
            'yyyyMMdd_HHmmss',
          ).format(DateTime.now());
          fileName = '${docs.code}_$timestamp.pdf';
          filePath = p.join(downloadsDir.path, fileName);
          file = File(filePath);
        }

        final fileBytes = await AppPdf.generateDocuments(docs, docs.items!);

        final res = await file.writeAsBytes(fileBytes);

        emit(state.copyWith(status: StatusExport.success, path: res.path));
      },
    );
  }
}
