// ignore_for_file: depend_on_referenced_packages

import 'package:asset_management/features/printer/domain/entities/printer.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PrinterModel extends Equatable {
  String? ipPrinter;
  int? port;

  PrinterModel(this.ipPrinter, this.port);

  Printer toEntity() => Printer(ipPrinter, port);

  factory PrinterModel.fromEntity(Printer e) {
    return PrinterModel(e.ipPrinter, e.portPrinter);
  }

  @override
  List<Object?> get props => [ipPrinter, port];
}
