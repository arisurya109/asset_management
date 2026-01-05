part of 'return_bloc.dart';

class ReturnEvent extends Equatable {
  const ReturnEvent();

  @override
  List<Object> get props => [];
}

class OnReturn extends ReturnEvent {
  final Movement params;

  const OnReturn(this.params);
}
