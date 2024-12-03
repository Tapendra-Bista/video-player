import 'package:ellipsized_text/ellipsized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_all_videos/thumbnail/ThumbnailTile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/bloc/selected_video/selected_video_bloc.dart';
import 'package:video/bloc/selected_video/selected_video_event.dart';
import 'package:video/bloc/selected_video/selected_video_state.dart';
import 'package:video/mediaquery/mq.dart';

class SelectFolder extends StatefulWidget {
  const SelectFolder({super.key, required this.videos});
  final List videos;

  @override
  State<SelectFolder> createState() => _SelectFolderState();
}

class _SelectFolderState extends State<SelectFolder> {
  List<String> path = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedVideoBloc, SelectedVideoState>(
        builder: (context, state) {
      if (state is OnSelectedVideoState) {
        return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: widget.videos.length,
            itemBuilder: (context, index) {
              var video = widget.videos[index];
 {
                return InkWell(
                  onTap: () async {
                    setState(() {
                      // Toggle the selection state
                      state.selectVideo[index] = !state.selectVideo[index];

                      // Add or remove the video path based on the new selection state
                      if (state.selectVideo[index]) {
                        // Add the video path if the item is selected
                        if (!path
                            .contains(widget.videos[index].path)) {
                          path.add(widget.videos[index].path);
                        }
                      } else {
                        // Remove the video path if the item is deselected
                        path.remove(widget.videos[index].path);
                      }
                    });

                    // Debug logs to verify behavior
                    debugPrint(state.selectVideo.toString());

                    context
                        .read<SelectedVideoBloc>()
                        .add(OnSelectedVideoEvent(state.selectVideo));

                    final SharedPreferencesAsync prefs =
                        SharedPreferencesAsync();
                    // Dispatch the updated state to the bloc
                    await prefs.setStringList(
                        Strings.videoPathKeyValue, path);

                    debugPrint(path.toString());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 75,
                        width: double.maxFinite,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                state.selectVideo[index]
                                    ? Icons.check_box_outlined
                                    : Icons.check_box_outline_blank_outlined,
                              ),
                            ),
                            ThumbnailTile(
                                width: 80,
                                height: 80,
                                thumbnailController: video.thumbnailController),
                            SizedBox(
                              width: mediaQuery(context).width / 1.58,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    EllipsizedText(
                                      ellipsis: Strings.ellipsisString,
                                      RegExp(Strings.regExpValue)
                                          .firstMatch(video.path)!
                                          .group(1)!,
                                      type: EllipsisType.end,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            fontSize: 20,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      video.size,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            fontSize: 10,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: mediaQuery(context).width / 1.7,
                                      child: EllipsizedText(
                                        ellipsis: Strings.ellipsisString,
                                        video.path
                                            .split("/${video.name}")
                                            .first,
                                        type: EllipsisType.end,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                              fontSize: 11,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 105,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                );
              }
            });
      }

      return const SizedBox();
    });
  }
}
