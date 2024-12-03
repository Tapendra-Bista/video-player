import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:video/bloc/bloc_for_switch/event.dart';
import 'package:video/bloc/bloc_for_switch/state.dart';

class SwitchBloc extends HydratedBloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(InitialState(false, false)) {
    on<SwitchOnEvent>((event, emit) {
      emit(SwitchOnState(event.forAutoplay, event.forLooping));
    });
  }

  @override
  SwitchState? fromJson(Map<String, dynamic> json) {
    try {
      return SwitchOnState(
        json['forAutoplay'] as bool? ?? false,
        json['forLooping'] as bool? ?? false,
      );
    } catch (_) {
      return null; // Return null if the JSON is invalid
    }
  }

  @override
  Map<String, dynamic>? toJson(SwitchState state) {
    if (state is SwitchOnState) {
      return {
        'forAutoplay': state.forAutoplay,
        'forLooping': state.forLooping,
      };
    }
    return null;
  }
}
