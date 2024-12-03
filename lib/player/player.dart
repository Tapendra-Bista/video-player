import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:ellipsized_text/ellipsized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/bloc/bloc_for_switch/bloc.dart';
import 'package:video/bloc/bloc_for_switch/state.dart';
import 'package:video/constant/button.dart';
import 'package:video/custom_controll/controll.dart';
import 'package:video/mediaquery/mq.dart';
import 'package:video/video_details_plugin/video_details_plugin.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final List<VideoFullDetails> video;
  final int index;
  const VideoPlayer({super.key, required this.video, required this.index});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
    initialization();
  }

  void _handlePreviousVideo() async {
    if (_currentIndex > 0) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        _currentIndex--;

        _videoPlayerController.dispose();
        // Dispose previous controller
        initialization();
      });
    }
  }

  void _handleNextVideo() async {
    if (_currentIndex < widget.video.length - 1) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        _currentIndex++;

        _videoPlayerController.dispose();
        // Dispose previous controller
        initialization();
      });
    }
  }

  void initialization() async {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video[_currentIndex].path));

    try {
      await _videoPlayerController.initialize();

      if (mounted) {
        setState(() {
          final switchState = context.read<SwitchBloc>().state;
          final isAutoplay =
              switchState is SwitchOnState && switchState.forAutoplay;
          final isLooping =
              switchState is SwitchOnState && switchState.forLooping;
          _chewieController = ChewieController(
            hideControlsTimer: const Duration(seconds: 2),
            allowFullScreen: true,
            zoomAndPan: true,
            draggableProgressBar: true,
            autoPlay: isAutoplay,
            looping: isLooping,
            showOptions: true,
            showControls: true,
            customControls: CustomControls(
                previousVideo: _handlePreviousVideo,
                nextVideo: _handleNextVideo,
                showPlayButton: true,
                backgroundColor: Colors.black,
                iconColor: Colors.white),
            fullScreenByDefault: false,
            videoPlayerController: _videoPlayerController,
          );
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _disposeControllers() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const SizedBox(
          height: 45,
        ),
        appBar: AppBar(
          leadingWidth: double.maxFinite,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              button(context, Icons.arrow_back_ios_outlined, Strings.backString,
                  () {
                Navigator.pop(context);
              }),
              SizedBox(
                width: mediaQuery(context).width / 1.2,
                child: EllipsizedText(
                  widget.video[widget.index].name,
                  ellipsis: Strings.ellipsisString,
                  type: EllipsisType.middle,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 15,
                      ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: _chewieController != null
              ? Chewie(controller: _chewieController!)
              : const CircularProgressIndicator(),
        ));
  }
}
