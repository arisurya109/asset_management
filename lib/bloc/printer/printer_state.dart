// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'printer_bloc.dart';

// ignore: must_be_immutable
class PrinterState extends Equatable {
  StatusPrinter? status;
  String? message;
  String? ipPrinter;

  PrinterState({
    this.status = StatusPrinter.initial,
    this.message,
    this.ipPrinter,
  });

  PrinterState copyWith({
    StatusPrinter? status,
    String? message,
    String? ipPrinter,
  }) {
    return PrinterState(
      status: status ?? this.status,
      message: message ?? this.message,
      ipPrinter: ipPrinter ?? this.ipPrinter,
    );
  }

  @override
  List<Object?> get props => [status, message, ipPrinter];
}
