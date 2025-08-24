part of 'printer_bloc.dart';

sealed class PrinterEvent extends Equatable {
  const PrinterEvent();

  @override
  List<Object> get props => [];
}

class OnGetIpPrinter extends PrinterEvent {}

class OnSetDefaultPrinter extends PrinterEvent {
  final String ipPrinter;

  const OnSetDefaultPrinter(this.ipPrinter);
}

class OnSetStatusInitialPrinter extends PrinterEvent {}
