import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_by_inforce/models/cat.dart';
import 'package:test_task_by_inforce/repositories/cat_repository.dart';
import 'cat_event.dart';
import 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final CatRepository catRepository;

  CatBloc(this.catRepository) : super(CatInitial()) {
    on<FetchCats>((event, emit) async {
      emit(CatLoading());
      try {
        final cats = await catRepository.fetchCats();
        emit(CatLoaded(cats));
      } catch (e) {
        emit(const CatError('Failed to fetch cats'));
      }
    });

    on<AddCat>((event, emit) {
      if (state is CatLoaded) {
        final updatedCats = List<Cat>.from((state as CatLoaded).cats)..add(event.cat);
        emit(CatLoaded(updatedCats));
      }
    });

    on<RemoveCat>((event, emit) {
      if (state is CatLoaded) {
        final updatedCats = List<Cat>.from((state as CatLoaded).cats)..remove(event.cat);
        emit(CatLoaded(updatedCats));
      }
    });
    on<SortCat>((event, emit) {
      if (state is CatLoaded) {
        final updatedCats = _sortCats((state as CatLoaded).cats, event.order);

        emit(CatLoaded(updatedCats));
      }
    });
  }
}



 List<Cat> _sortCats(List<Cat> cats, String sortCriteria ) {
    if (sortCriteria == 'alphabet') {
      cats.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortCriteria == 'id') {
      cats.sort((a, b) => a.id.compareTo(b.id)); // Use count logic if available
    }
    return cats;
  }
