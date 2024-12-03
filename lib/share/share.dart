import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video/app_strings/strings.dart';

void shareVideo(List<XFile> videoPathlist) async {
  try {
    if (videoPathlist.isNotEmpty) {
      await Share.shareXFiles(
        videoPathlist,
        text: Strings.checkVideo,
      );
    } else {
      debugPrint('No videos to share.');
    }
  } catch (e) {
    debugPrint('Error sharing video: $e');
  }
}

