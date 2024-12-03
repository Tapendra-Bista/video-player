import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/bloc/videos_and_folders/bloc.dart';
import 'package:video/bloc/videos_and_folders/state.dart';
import 'package:video/mediaquery/mq.dart';
import 'package:video/share/share.dart';

BottomAppBar appBottomAppBar(BuildContext context) {
  return BottomAppBar(
      padding: const EdgeInsets.all(0),
      height: mediaQuery(context).width / 5,
      color: Theme.of(context).popupMenuTheme.color,
      child: BlocBuilder<VFBloc, VFState>(builder: (context, state) {
        if (state is InitialState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
                  // Retrieve the list of paths from SharedPreferences
                  final List<String>? temp =
                      await prefs.getStringList(Strings.videoPathKeyValue);

                  // Initialize the list of XFiles
                  final List<XFile> shareFile = [];
                  if (temp != null) {
                    for (final i in temp) {
                      shareFile.add(XFile(i)); // Add each file to the list
                    }
                    // Share the videos
                    if (shareFile.isNotEmpty) {
                      shareVideo(shareFile);
                    } else {
                      debugPrint(Strings.noFileError);
                    }
                  } else {
                    debugPrint(Strings.nopathFound);
                  }
                },
                child: SizedBox(
                  height: 50,
                  width: 75,
                  child: ListTile(
                    subtitle: Text(
                      Strings.shareString,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 10,
                              ),
                    ),
                    title: Icon(Icons.share_outlined,
                        color: Theme.of(context).iconTheme.color),
                  ),
                ),
              ),
          
            ],
          );
        } else if (state is VFOnState) {
          if (state.indexValue == 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    final SharedPreferencesAsync prefs =
                        SharedPreferencesAsync();
                    // Retrieve the list of paths from SharedPreferences
                    final List<String>? temp =
                        await prefs.getStringList(Strings.videoPathKeyValue);

                    // Initialize the list of XFiles
                    final List<XFile> shareFile = [];
                    if (temp != null) {
                      for (final i in temp) {
                        shareFile.add(XFile(i)); // Add each file to the list
                      }
                      // Share the videos
                      if (shareFile.isNotEmpty) {
                        shareVideo(shareFile);
                      } else {
                        debugPrint(Strings.noFileError);
                      }
                    } else {
                      debugPrint(Strings.nopathFound);
                    }

                    debugPrint("Total paths in temp: $temp");
                    debugPrint("XFiles to share: $shareFile");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 75,
                    child: ListTile(
                      subtitle: Text(
                        Strings.shareString,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontSize: 10,
                            ),
                      ),
                      title: Icon(Icons.share_outlined,
                          color: Theme.of(context).iconTheme.color),
                    ),
                  ),
                ),
               
              ],
            );
          } else if (state.indexValue == 1) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    final SharedPreferencesAsync prefs =
                        SharedPreferencesAsync();
                    // Retrieve the list of paths from SharedPreferences
                    final List<String>? temp =
                        await prefs.getStringList(Strings.videoPathKeyValue);

                    // Initialize the list of XFiles
                    final List<XFile> shareFile = [];
                    if (temp != null) {
                      for (final i in temp) {
                        shareFile.add(XFile(i)); // Add each file to the list
                      }
                      // Share the videos
                      if (shareFile.isNotEmpty) {
                        shareVideo(shareFile);
                      } else {
                        debugPrint(Strings.noFileError);
                      }
                    } else {
                      debugPrint(Strings.nopathFound);
                    }

                    debugPrint("Total paths in temp: $temp");
                    debugPrint("XFiles to share: $shareFile");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 75,
                    child: ListTile(
                      subtitle: Text(
                        Strings.shareString,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontSize: 10,
                            ),
                      ),
                      title: Icon(Icons.share_outlined,
                          color: Theme.of(context).iconTheme.color),
                    ),
                  ),
                ),
               
              ],
            );
          }
        }
        return const SizedBox();
      }));
}
