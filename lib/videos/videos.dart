import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/bloc/bloc_for_sort/sort_bloc.dart';
import 'package:video/bloc/bloc_for_sort/sort_state.dart';
import 'package:video/bloc/selected_video/selected_video_bloc.dart';
import 'package:video/bloc/selected_video/selected_video_event.dart';
import 'package:video/bloc/videos_and_folders/bloc.dart';
import 'package:video/bloc/videos_and_folders/event.dart';
import 'package:video/constant/button.dart';
import 'package:video/constant/tabbar.dart';
import 'package:video/more/more.dart';
import 'package:video/search/search.dart';
import 'package:video/select/select.dart';
import 'package:video/video_details_plugin/video_details_plugin.dart';
import 'package:video/videos/folder_list.dart';
import 'package:video/videos/video_list.dart';

class Videos extends StatefulWidget {
  final int initialIndex;
  const Videos({super.key, required this.initialIndex});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  
  VideoManager object = VideoManager();
//lists all videos in the device
  late List<VideoFullDetails> videosList = [];
  bool isLoading = true; // Add this state variable

  @override
  void initState() {
    loadVideos();
    super.initState();

    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() {
        isLoading = false; // Set loading to false after data is loaded
      });
    });
  }

  Future<void> loadVideos() async {
    // Get all video paths
  
    final videoPaths = await object.getAllVideoDetails();
    setState(() {
      videosList = videoPaths;
    });

  }



  @override
  Widget build(BuildContext context) {
   
    final List<VideoFullDetails> sortByName = List.from(videosList)
      ..sort((a, b) => a.name.compareTo(b.name));
    final List<VideoFullDetails> sortBySize = List.from(videosList)
      ..sort((a, b) => b.size.compareTo(a.size));

    if (isLoading) {
      return Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
        ),
      );
    }

    return DefaultTabController(
      length: Strings.tabNumber,
      initialIndex: widget.initialIndex,
      child: DefaultTabControllerListener(
        onTabChanged: (value) async {
          context.read<VFBloc>().add(VFOnEvent(value));
        },
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              actions: [
                button(context, Icons.search_outlined, Strings.tooltipSearch,
                    () {
                  search(context, videosList);
                }),
                button(context, Icons.check_box_outlined, Strings.tooltipSelect,
                    () async {
                  Navigator.pushNamed(context, Select.selectName,
                      arguments: videosList);
                  context.read<SelectedVideoBloc>().add(OnSelectedVideoEvent(
                      List<bool>.filled(videosList.length, false)));
                  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
                  await prefs.remove(Strings.videoPathKeyValue);
                }),
                const More()
              ],
              leadingWidth: double.maxFinite,
              leading: appTabBar(context),
            ),
            body: BlocBuilder<SortBloc, SortState>(builder: (context, state) {
              if (state is InitialSortState) {
                if (state.sortBy == Strings.defaultStringValue) {
                  return TabBarView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        VideosList(
                          videos: videosList,
                        ),
                        FolderList(
                          videos: videosList,
                        )
                      ]);
                } else if (state.sortBy == Strings.nameStringValue) {
                  return TabBarView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        VideosList(
                          videos: sortByName,
                        ),
                        FolderList(
                          videos: videosList,
                        )
                      ]);
                } else if (state.sortBy == Strings.sizeStringValue) {
                  return TabBarView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        VideosList(
                          videos: sortBySize,
                        ),
                        FolderList(
                          videos: videosList,
                        )
                      ]);
                }
              } else if (state is SortWayChangedState) {
                if (state.sortBy == Strings.defaultStringValue) {
                  return TabBarView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        VideosList(
                          videos: videosList,
                        ),
                        FolderList(
                          videos: videosList,
                        )
                      ]);
                } else if (state.sortBy == Strings.nameStringValue) {
                  return TabBarView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        VideosList(
                          videos: sortByName,
                        ),
                        FolderList(
                          videos: videosList,
                        )
                      ]);
                } else if (state.sortBy == Strings.sizeStringValue) {
                  return TabBarView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        VideosList(
                          videos: sortBySize,
                        ),
                        FolderList(
                          videos: videosList,
                        )
                      ]);
                }
              }
              return const SizedBox();
            })),
      ),
    );
  }
}

class DefaultTabControllerListener extends StatefulWidget {
  const DefaultTabControllerListener({
    required this.onTabChanged,
    required this.child,
    super.key,
  });

  final ValueChanged<int> onTabChanged;

  final Widget child;

  @override
  State<DefaultTabControllerListener> createState() =>
      _DefaultTabControllerListenerState();
}

class _DefaultTabControllerListenerState
    extends State<DefaultTabControllerListener> {
  TabController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final TabController? defaultTabController =
        DefaultTabController.maybeOf(context);

    assert(() {
      if (defaultTabController == null) {
        throw FlutterError(
          'No DefaultTabController for ${widget.runtimeType}.\n'
          'When creating a ${widget.runtimeType}, you must ensure that there '
          'is a DefaultTabController above the ${widget.runtimeType}.',
        );
      }
      return true;
    }());
    if (defaultTabController != _controller) {
      _controller?.removeListener(_listener);
      _controller = defaultTabController;
      _controller?.addListener(_listener);
    }
  }

  void _listener() {
    final TabController? controller = _controller;

    if (controller == null || controller.indexIsChanging) {
      return;
    }

    widget.onTabChanged(controller.index);
  }

  @override
  void dispose() {
    _controller?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
