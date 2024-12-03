import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/bloc/bloc_for_sort/sort_bloc.dart';
import 'package:video/bloc/bloc_for_sort/sort_state.dart';
import 'package:video/bloc/selected_video/selected_video_bloc.dart';
import 'package:video/bloc/selected_video/selected_video_event.dart';
import 'package:video/bloc/selected_video/selected_video_state.dart';
import 'package:video/bloc/videos_and_folders/bloc.dart';
import 'package:video/bloc/videos_and_folders/state.dart';
import 'package:video/constant/app_bottom_bar.dart';
import 'package:video/constant/divider.dart';
import 'package:video/select/select_folder.dart';
import 'package:video/select/select_video.dart';
import 'package:video/video_details_plugin/video_details_plugin.dart';

class Select extends StatefulWidget {
  static const selectName = Strings.selectRouteStrings;
  const Select({
    super.key,
  });

  @override
  State<Select> createState() => _VideosState();
}

class _VideosState extends State<Select> {
  int totalSelectedVideo = 0;
  bool isSelected = false;
  List<String> path = [];

  @override
  Widget build(BuildContext context) {
    final List<VideoFullDetails> args =
        ModalRoute.of(context)?.settings.arguments as List<VideoFullDetails>;
    final sortByName = List.from(args)
      ..sort((a, b) => a.name.compareTo(b.name));
    final sortBySize = List.from(args)
      ..sort((a, b) => a.size.compareTo(b.size));

    return BlocListener<SelectedVideoBloc, SelectedVideoState>(
        listener: (context, state) {
          if (state is OnSelectedVideoState) {
            setState(() {
              totalSelectedVideo =
                  state.selectVideo.where((value) => value).length;
            });
          }
        },
        child: Scaffold(
            bottomNavigationBar: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                appDivider(context),
                appBottomAppBar(context),
              ],
            ),
            appBar: AppBar(
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: appDivider(context)),
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      context.read<SelectedVideoBloc>().add(
                            OnSelectedVideoEvent(
                              List<bool>.filled(args.length, !isSelected),
                            ),
                          );
                      setState(() {
                        isSelected = !isSelected;
                      });
                      setState(() {
                        // Add the video path if the item is selected
                        for (final i in args) {
                          if (!path.contains(i.path)) {
                            path.add(i.path);
                          } else {
                            // Remove the video path if the item is deselected
                            path.remove(i.path);
                          }
                        }
                      });

                      final SharedPreferencesAsync prefs =
                          SharedPreferencesAsync();
                      // Dispatch the updated state to the bloc
                      await prefs.setStringList(
                          Strings.videoPathKeyValue, path);
                      debugPrint(path.toString());
                      debugPrint(path.length.toString());
                    },
                    child: Text(
                      Strings.selectAllString,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 18,
                              ),
                    ),
                  ),
                  Text(
                    totalSelectedVideo.toString(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      context.read<SelectedVideoBloc>().add(
                          OnSelectedVideoEvent(
                              List<bool>.filled(args.length, false)));
                      final SharedPreferencesAsync prefs =
                          SharedPreferencesAsync();
                      await prefs.remove(Strings.videoPathKeyValue);
                    },
                    child: Text(
                      Strings.cancelString,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 18,
                              ),
                    ),
                  )
                ],
              ),
              backgroundColor: Theme.of(context).popupMenuTheme.color,
            ),
            body: BlocBuilder<VFBloc, VFState>(builder: (context, state) {
              if (state is InitialState) {
                if (state.indexValue == 0) {
                  return BlocBuilder<SortBloc, SortState>(
                      builder: (context, state) {
                    if (state is InitialSortState) {
                      if (state.sortBy == Strings.defaultStringValue) {
                        return SelectVideo(videos: args);
                      } else if (state.sortBy == Strings.nameStringValue) {
                        return SelectVideo(videos: sortByName);
                      } else if (state.sortBy == Strings.sizeStringValue) {
                        return SelectVideo(videos: sortBySize);
                      }
                    } else if (state is SortWayChangedState) {
                      if (state.sortBy == Strings.defaultStringValue) {
                        return SelectVideo(videos: args);
                      } else if (state.sortBy == Strings.nameStringValue) {
                        return SelectVideo(videos: sortByName);
                      } else if (state.sortBy == Strings.sizeStringValue) {
                        return SelectVideo(videos: sortBySize);
                      }
                    }

                    return const SizedBox();
                  });
                } else if (state.indexValue == 1) {
                  return SelectFolder(videos: args);
                }
              } else if (state is VFOnState) {
                if (state.indexValue == 0) {
                  return BlocBuilder<SortBloc, SortState>(
                      builder: (context, state) {
                    if (state is InitialSortState) {
                      if (state.sortBy == Strings.defaultStringValue) {
                        return SelectVideo(videos: args);
                      } else if (state.sortBy == Strings.nameStringValue) {
                        return SelectVideo(videos: sortByName);
                      } else if (state.sortBy == Strings.sizeStringValue) {
                        return SelectVideo(videos: sortBySize);
                      }
                    } else if (state is SortWayChangedState) {
                      if (state.sortBy == Strings.defaultStringValue) {
                        return SelectVideo(videos: args);
                      } else if (state.sortBy == Strings.nameStringValue) {
                        return SelectVideo(videos: sortByName);
                      } else if (state.sortBy == Strings.sizeStringValue) {
                        return SelectVideo(videos: sortBySize);
                      }
                    }

                    return const SizedBox();
                  });
                } else if (state.indexValue == 1) {
                  return SelectFolder(videos: args);
                }
              }
              return const SizedBox();
            })));
  }
}
