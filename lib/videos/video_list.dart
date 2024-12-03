import 'package:ellipsized_text/ellipsized_text.dart';
import 'package:flutter/material.dart';
import 'package:list_all_videos/thumbnail/ThumbnailTile.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/constant/bottom_sheet_video.dart';
import 'package:video/constant/no_result.dart';
import 'package:video/mediaquery/mq.dart';
import 'package:video/player/player.dart';
import 'package:video/video_details_plugin/video_details_plugin.dart';

class VideosList extends StatefulWidget {
  const VideosList({
    super.key,
    required this.videos,
  });
  final List<VideoFullDetails> videos;
  @override
  State<VideosList> createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  

  @override
  Widget build(BuildContext context) {
    return widget.videos.isEmpty
        ? noResult(context)
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: widget.videos.length,
            itemBuilder: (context, index) {
              var video = widget.videos[index];

              return InkWell(
                onLongPress: () => mybottomsheetvideo(context, video),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => VideoPlayer(
                                video: widget.videos,
                                index: index,
                              )));
                  debugPrint(video.path);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                      video.name,
                                      type: EllipsisType.end,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            fontSize: 15,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                       Strings.videoTypeValue.split(':').last,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                fontSize: 10,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        Text(
                                          video.size,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                fontSize: 10,
                                              ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              );
            });
  }
}
