class SelectState {

}

class SelectInitialState extends SelectState {}
class OnTapSelectState extends SelectState {
  final  bool isTap ;
  OnTapSelectState(this.isTap);
}