part of 'printer_bloc.dart';

class PrinterEvent extends Equatable {
  const PrinterEvent();

  @override
  List<Object> get props => [];
}

class OnSetDefaultPrinter extends PrinterEvent {
  final Printer params;

  const OnSetDefaultPrinter(this.params);
}

class OnGetIpPrinter extends PrinterEvent {}

class OnPrintAssetId extends PrinterEvent {
  final String params;

  const OnPrintAssetId(this.params);
}

class OnPrintLocation extends PrinterEvent {
  final String params;

  const OnPrintLocation(this.params);
}
