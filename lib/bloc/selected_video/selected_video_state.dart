abstract class SelectedVideoState{}
 
 class  InitialSelectedVideoState extends SelectedVideoState{}
class OnSelectedVideoState extends SelectedVideoState {
final List<bool> selectVideo;
OnSelectedVideoState(this.selectVideo);
}