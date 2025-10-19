// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/features/printer/domain/entities/printer.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PrinterModel extends Equatable {
  String? ipPrinter;
  int? portPrinter;

  PrinterModel({this.ipPrinter, this.portPrinter});

  factory PrinterModel.fromEntity(Printer params) {
    return PrinterModel(
      ipPrinter: params.ipPrinter,
      portPrinter: params.portPrinter,
    );
  }

  @override
  List<Object?> get props => [ipPrinter, portPrinter];
}
