import 'package:equatable/equatable.dart';
import 'package:test_task_by_inforce/models/cat.dart';

abstract class CatEvent extends Equatable {
  const CatEvent();

  @override
  List<Object> get props => [];
}

class FetchCats extends CatEvent {}

class AddCat extends CatEvent {
  final Cat cat;

  const AddCat(this.cat);

  @override
  List<Object> get props => [cat];
}

class RemoveCat extends CatEvent {
  final Cat cat;

  const RemoveCat(this.cat);

  @override
  List<Object> get props => [cat];
}

class SortCat extends CatEvent {
  final String order;

  const SortCat(this.order);

  @override
  List<Object> get props => [order];
}
