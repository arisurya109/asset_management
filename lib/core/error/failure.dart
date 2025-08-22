// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

class CreateFailure extends Failure {
  const CreateFailure(super.message);
}

class UpdateFailure extends Failure {
  const UpdateFailure(super.message);
}

class DeleteFailure extends Failure {
  const DeleteFailure(super.message);
}
