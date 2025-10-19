part of 'registration_bloc.dart';

class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class OnRegistrationAssetNonConsumable extends RegistrationEvent {
  final Registration params;

  const OnRegistrationAssetNonConsumable(this.params);
}

class OnRegistrationAssetConsumable extends RegistrationEvent {
  final Registration params;

  const OnRegistrationAssetConsumable(this.params);
}
