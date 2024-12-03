abstract class SwitchEvent {}

class SwitchOnEvent extends SwitchEvent {
  final bool forAutoplay;
  final bool forLooping;

  SwitchOnEvent(this.forAutoplay, this.forLooping);
}

