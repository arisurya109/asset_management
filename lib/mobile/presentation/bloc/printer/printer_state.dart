// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'printer_bloc.dart';

enum PrinterStatus { initial, loading, failed, success, loaded }

// ignore: must_be_immutable
class PrinterState extends Equatable {
  PrinterStatus? status;
  Printer? printer;
  String? message;

  PrinterState({
    this.status = PrinterStatus.initial,
    this.printer,
    this.message,
  });

  @override
  List<Object?> get props => [status, printer, message];

  PrinterState copyWith({
    PrinterStatus? status,
    Printer? printer,
    String? message,
  }) {
    return PrinterState(
      status: status ?? this.status,
      printer: printer ?? this.printer,
      message: message ?? this.message,
    );
  }
}
