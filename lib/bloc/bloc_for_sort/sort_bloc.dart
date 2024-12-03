import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/bloc/bloc_for_sort/sort_event.dart';
import 'package:video/bloc/bloc_for_sort/sort_state.dart';



// Define Bloc
class SortBloc extends HydratedBloc<SortEvent, SortState> {
  SortBloc() : super(const InitialSortState(Strings.defaultStringValue)) {
    on<SortWayChangedEvent>((event, emit) {
      emit(SortWayChangedState(event.sortBy));
    });
  }

  @override
  SortState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey('sortBy')) {
      return InitialSortState.fromJson(json);
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(SortState state) {
    return state.toJson();
  }
}
