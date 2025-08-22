// ignore_for_file: must_be_immutable

// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

class Printer extends Equatable {
  String? ipPrinter;
  int? portPrinter;

  Printer(this.ipPrinter, this.portPrinter);

  @override
  List<Object?> get props => [ipPrinter, portPrinter];
}
