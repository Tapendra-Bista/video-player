import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video/bloc/selected_video/selected_video_event.dart';
import 'package:video/bloc/selected_video/selected_video_state.dart';

class SelectedVideoBloc extends Bloc<SelectedVideoEvent,SelectedVideoState> {
  SelectedVideoBloc():super ((InitialSelectedVideoState())
  ){
on<OnSelectedVideoEvent>((event,  emit){
  emit(OnSelectedVideoState(event.selectVideo));
});
  }
}