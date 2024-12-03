 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video/bloc/videos_and_folders/event.dart';
import 'package:video/bloc/videos_and_folders/state.dart';

class VFBloc extends Bloc<VFEvent,VFState> {
  VFBloc():super ((InitialState(0))
  ){
on<VFOnEvent>((event,emit){
emit(VFOnState(event.indexValue));
});



  }

}