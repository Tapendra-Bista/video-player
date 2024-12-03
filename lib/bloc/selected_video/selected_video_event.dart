abstract class SelectedVideoEvent {}
 
class OnSelectedVideoEvent extends SelectedVideoEvent {
final List<bool> selectVideo;
OnSelectedVideoEvent(this.selectVideo);
}
