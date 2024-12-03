import 'package:ellipsized_text/ellipsized_text.dart';
import 'package:flutter/material.dart';
import 'package:list_all_videos/thumbnail/ThumbnailTile.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/mediaquery/mq.dart';
import 'package:video/video_details_plugin/video_details_plugin.dart';

Future<dynamic> details(BuildContext context, VideoFullDetails video) {
  return showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Theme.of(context).popupMenuTheme.color,
                borderRadius: BorderRadius.circular(12)),
            height: 255,
            width: mediaQuery(context).width / 1.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.detailsStringValue,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: ThumbnailTile(
                          thumbnailController: video.thumbnailController),
                    ),
                    SizedBox(
                      width: 200,
                      child: EllipsizedText(
                        video.name,
                        ellipsis: Strings.ellipsisString,
                        type: EllipsisType.middle,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  Strings.videoTypeValue,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  maxLines: 2,
                  Strings.videoPathValue + video.path,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  Strings.videoSizeValue + video.size,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () { Navigator.pop(context);
                       Navigator.pop(context);
                      },
                      child: Text(
                        Strings.confirmValue,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                fontSize: 15, color: const Color(0xffd15353)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
