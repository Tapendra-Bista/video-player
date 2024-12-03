import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/delete/delete.dart';
import 'package:video/details/details.dart';
import 'package:video/share/share.dart';
import 'package:video/video_details_plugin/video_details_plugin.dart';

Future<dynamic> mybottomsheetfolder(BuildContext context, VideoFullDetails video) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    useSafeArea: true,
    context: context,
    backgroundColor: Theme.of(context).popupMenuTheme.color,
    builder: (BuildContext context) {
      return SizedBox(
        height: 70,
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                shareVideo([XFile(video.path)]);
              },
              child: SizedBox(
                height: 50,
                width: 75,
                child: ListTile(
                  subtitle: Text(
                    Strings.shareString,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 10,
                        ),
                  ),
                  title: Icon(Icons.share_outlined,
                      color: Theme.of(context).iconTheme.color),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
          
                FlutterMediaDelete.deleteMediaFile(video.path, context,1);
              },
              child: SizedBox(
                height: 50,
                width: 75,
                child: ListTile(
                  subtitle: Text(
                    Strings.deleteStringValue,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 10,
                        ),
                  ),
                  title: Icon(
                    Icons.delete_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => details(context, video),
              child: SizedBox(
                height: 50,
                width: 84,
                child: ListTile(
                  subtitle: Text(
                    Strings.detailsStringValue,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 10,
                        ),
                  ),
                  title: Icon(
                    Icons.file_open_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
