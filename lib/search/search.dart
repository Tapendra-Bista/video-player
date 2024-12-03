import 'package:ellipsized_text/ellipsized_text.dart';
import 'package:flutter/material.dart';
import 'package:list_all_videos/thumbnail/ThumbnailTile.dart';
import 'package:search_page/search_page.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/mediaquery/mq.dart';
import 'package:video/player/player.dart';
import 'package:video/video_details_plugin/video_details_plugin.dart';

void search(context, videosList) {
  showSearch(
      context: context,
      delegate: SearchPage<VideoFullDetails>(
          barTheme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none),
              useMaterial3: true,
              scaffoldBackgroundColor:
                  Theme.of(context).scaffoldBackgroundColor,
              appBarTheme: AppBarTheme(
                iconTheme:
                    IconThemeData(color: Theme.of(context).iconTheme.color),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              )),
          searchStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 12,
              ),
          searchLabel: Strings.searchLabel,
          failure: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Strings.noResultImg,
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  Strings.noResultString,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 12,
                      ),
                ),
              ],
            ),
          ),
          builder: (video) {
            final int index = videosList.indexWhere((v) => v == video);

            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => VideoPlayer(
                            video: videosList,
                            index: index,
                          ))),
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
                              child: Center(
                                child: EllipsizedText(
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
          },
          filter: (video) => [video.name],
          items: videosList));
}
