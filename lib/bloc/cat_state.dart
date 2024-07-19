import 'package:equatable/equatable.dart';
import 'package:test_task_by_inforce/models/cat.dart';

abstract class CatState extends Equatable {
  const CatState();

  @override
  List<Object> get props => [];
}

class CatInitial extends CatState {}

class CatLoading extends CatState {}

class CatLoaded extends CatState {
  final List<Cat> cats;

  const CatLoaded(this.cats);

  @override
  List<Object> get props => [cats];
}

class CatError extends CatState {
  final String message;

  const CatError(this.message);

  @override
  List<Object> get props => [message];
}
