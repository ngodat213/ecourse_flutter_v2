import 'package:ecourse_flutter_v2/models/lesson_content_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:ecourse_flutter_v2/core/config/app_color.dart';
import 'package:ecourse_flutter_v2/services/streak_service.dart';
import 'dart:async';
import 'package:ecourse_flutter_v2/view_models/learning_streak_vm.dart';

mixin ChewiePlayerMixin<T extends StatefulWidget> on State<T> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  bool _isInitializing = false;
  bool _isFullScreen = false;
  bool _hasCalledOnFinish = false;

  StreakService? _streakService;
  int _currentVideoWatchDuration = 0;
  Timer? _streakTimer;

  Duration _lastPosition = Duration.zero;
  int _actualWatchedTime = 0;

  late final LearningStreakVM _streakVM;

  @override
  void initState() {
    super.initState();
    _streakVM = context.read<LearningStreakVM>();
    _initStreakService();
  }

  Future<void> _initStreakService() async {
    _streakService = await StreakService.getInstance();
  }

  Future<void> initializePlayer(
    LessonContentModel content,
    Function? onFinish,
  ) async {
    if (_isInitializing) return;

    _isInitializing = true;
    await disposeControllers();

    try {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(content.video!.url),
      );

      _addVideoListeners();

      videoPlayerController?.addListener(() {
        if (videoPlayerController?.value.isPlaying == true) {
          _trackWatchTime();
        }

        if (videoPlayerController?.value.isInitialized == true &&
            videoPlayerController?.value.position != null &&
            videoPlayerController?.value.duration != null &&
            videoPlayerController!.value.duration.inMilliseconds > 0) {
          final position = videoPlayerController!.value.position;
          final duration = videoPlayerController!.value.duration;
          final isNearEnd =
              position >= duration - const Duration(milliseconds: 500);

          if (isNearEnd && !videoPlayerController!.value.isPlaying) {
            if (!_hasCalledOnFinish) {
              _hasCalledOnFinish = true;
              onFinish?.call();
            }
          } else if (!isNearEnd) {
            _hasCalledOnFinish = false;
          }
        }
      });

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
                    onPressed: () => initializePlayer(content, onFinish),
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
        initializePlayer(content, onFinish);
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

  void _trackWatchTime() {
    videoPlayerController?.addListener(() {
      if (videoPlayerController?.value.isPlaying == true) {
        _streakVM.startTracking();
      } else {
        _streakVM.pauseTracking();
      }
    });
  }

  Future<void> _updateWatchDuration() async {
    if (_actualWatchedTime > 0 && _streakService != null) {
      await _streakService!.addWatchDuration(_actualWatchedTime);
    }
  }

  // Thêm listener cho việc seek video
  void _addVideoListeners() {
    videoPlayerController?.addListener(() {
      if (videoPlayerController?.value.isPlaying == true) {
        _trackWatchTime();
      }

      // Kiểm tra nếu user seek video
      final currentPosition = videoPlayerController?.value.position;
      if (currentPosition != null &&
          (currentPosition - _lastPosition).abs() >
              const Duration(seconds: 2)) {
        // Reset last position nếu user seek
        _lastPosition = currentPosition;
      }
    });
  }

  @override
  void dispose() {
    _streakVM.pauseTracking();
    _streakTimer?.cancel();
    disposeControllers();
    super.dispose();
  }

  Future<void> disposeControllers() async {
    // Update lần cuối trước khi dispose
    await _updateWatchDuration();

    _lastPosition = Duration.zero;
    _actualWatchedTime = 0;

    _streakTimer?.cancel();
    _streakTimer = null;
    _currentVideoWatchDuration = 0;

    chewieController?.removeListener(_onFullScreenChanged);
    chewieController?.dispose();
    await videoPlayerController?.dispose();
    chewieController = null;
    videoPlayerController = null;
    _hasCalledOnFinish = false;

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }
}
