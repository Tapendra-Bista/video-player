import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video/bloc/bloc_for_select/select_event.dart';
import 'package:video/bloc/bloc_for_select/select_state.dart';

class SelectBloc extends Bloc<SelectEvent,SelectState> {
  SelectBloc():super((SelectInitialState())){
on<OnTapSelectEvent>((event,emit){
  emit(OnTapSelectState(event.isTap));
});
  }
}