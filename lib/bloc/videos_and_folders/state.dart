abstract class VFState {}

class InitialState extends VFState {
    final int indexValue ;
 
 
  
    InitialState(this.indexValue);

}
class VFOnState extends VFState{
  final int indexValue ;
  VFOnState(this.indexValue);
}

