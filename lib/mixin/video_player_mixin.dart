import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';

mixin ChewiePlayerMixin<T extends StatefulWidget> on State<T> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  bool _isInitializing = false;
  bool _isFullScreen = false;

  Future<void> initializePlayer(String videoUrl) async {
    if (_isInitializing) return;

    _isInitializing = true;
    await disposeControllers();

    try {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
      );

      await videoPlayerController?.initialize();

      if (mounted && videoPlayerController != null) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          autoPlay: false,
          looping: false,
          aspectRatio: videoPlayerController!.value.aspectRatio,
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: AppColor.error, size: 30),
                  const SizedBox(height: 8),
                  Text(
                    'Không thể phát video',
                    style: TextStyle(color: AppColor.error),
                  ),
                  TextButton(
                    onPressed: () => initializePlayer(videoUrl),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          },
          placeholder: Center(
            child: CircularProgressIndicator(color: AppColor.primary),
          ),
          allowFullScreen: true,
          fullScreenByDefault: false,
          deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
          systemOverlaysAfterFullScreen: SystemUiOverlay.values,
          allowedScreenSleep: false,
          showControlsOnInitialize: true,
          showControls: true,
          allowMuting: true,
          isLive: false,
          allowPlaybackSpeedChanging: true,
          draggableProgressBar: true,
          hideControlsTimer: const Duration(seconds: 3),
          customControls: const MaterialDesktopControls(showPlayButton: true),
        );

        chewieController?.addListener(_onFullScreenChanged);

        setState(() {});
      }
    } on PlatformException catch (e) {
      debugPrint('Platform error: ${e.message}');
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        initializePlayer(videoUrl);
      }
    } catch (e) {
      debugPrint('Error initializing video player: $e');
      if (mounted) {
        setState(() {
          chewieController = null;
          videoPlayerController = null;
        });
      }
    } finally {
      _isInitializing = false;
    }
  }

  void _onFullScreenChanged() {
    if (chewieController?.isFullScreen != _isFullScreen) {
      _isFullScreen = chewieController?.isFullScreen ?? false;

      if (!_isFullScreen) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: SystemUiOverlay.values,
        );
      }
    }
  }

  Widget buildVideoPlayer() {
    if (_isInitializing || chewieController == null) {
      return Center(child: CircularProgressIndicator(color: AppColor.primary));
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Chewie(controller: chewieController!),
      ),
    );
  }

  Future<void> disposeControllers() async {
    if (chewieController != null) {
      chewieController?.removeListener(_onFullScreenChanged);
      chewieController?.dispose();
      chewieController = null;
    }

    if (videoPlayerController != null) {
      await videoPlayerController?.dispose();
      videoPlayerController = null;
    }

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }
}
