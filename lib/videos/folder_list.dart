import 'package:ellipsized_text/ellipsized_text.dart';
import 'package:flutter/material.dart';
import 'package:list_all_videos/thumbnail/ThumbnailTile.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/constant/bottom_sheet_folder.dart';
import 'package:video/constant/no_result.dart';
import 'package:video/mediaquery/mq.dart';
import 'package:video/player/player.dart';
import 'package:video/video_details_plugin/video_details_plugin.dart';

class FolderList extends StatelessWidget {
  const FolderList({super.key, required this.videos,});
  final List<VideoFullDetails> videos;

  @override
  Widget build(BuildContext context) {  

    return videos.isEmpty
        ? 
        noResult(context)
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              var video = videos[index];

 
  
              return InkWell(
                onLongPress: () => mybottomsheetfolder(context, video),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => VideoPlayer(
                                video: videos,
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
                                height: 80,
                                width: 80,
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
                                      RegExp(Strings.regExpValue).firstMatch(video.path)!.group(1)!,
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
                                    EllipsizedText(
                                      ellipsis: Strings.ellipsisString,
                                      video.path.split( "/${video.name}" ).first,
                                      type: EllipsisType.end,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            fontSize: 11,
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
                ),
              );
            });
  }
}
