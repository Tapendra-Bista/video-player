import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/videos/videos.dart';

class FlutterMediaDelete {
  static const MethodChannel _channel = MethodChannel('flutter_media_delete');

  static Future<String> deleteMediaFile(
      String filePath, context, int initialIndex) async {
    try {
      final String result = await _channel
          .invokeMethod('deleteMediaFile', {'filePath': filePath});
      debugPrint("ressult string : $result");
      if (result == Strings.deletedValue) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Videos(
                      initialIndex: initialIndex,
                    )));
      }
      return result;
    } catch (e) {
      debugPrint("Unexpected error: $e");
      return "error";
      
    }
  }
}
