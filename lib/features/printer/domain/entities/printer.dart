// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Printer extends Equatable {
  String? ipPrinter;
  int? portPrinter;

  Printer({this.ipPrinter, this.portPrinter});

  @override
  List<Object?> get props => [ipPrinter, portPrinter];
}
