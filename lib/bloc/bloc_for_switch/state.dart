abstract class SwitchState {}

class InitialState extends SwitchState {
  final bool forAutoplay;
  final bool forLooping;

  InitialState(this.forAutoplay, this.forLooping);
}

class SwitchOnState extends SwitchState {
  final bool forAutoplay;
  final bool forLooping;

  SwitchOnState(this.forAutoplay, this.forLooping);
}