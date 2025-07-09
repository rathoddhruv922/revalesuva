import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';

class VideoMediaPlayer extends StatefulWidget {
  final String videoUrl;
  final Duration? startPoint;
  final Function(Duration position, Duration duration)? onProgressChanged;

  const VideoMediaPlayer({
    super.key,
    required this.videoUrl,
    this.startPoint,
    this.onProgressChanged,
  });

  @override
  State<VideoMediaPlayer> createState() => _VideoMediaPlayerState();
}

class _VideoMediaPlayerState extends State<VideoMediaPlayer> {
  late final Player _player;
  late final VideoController _controller;
  bool _hasSeekedToStartPoint = false;
  bool _isDisposed = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isBuffering = false;

  // Store subscriptions for cleanup
  late final StreamSubscription<Duration> _positionSub;
  late final StreamSubscription<Duration> _durationSub;
  late final StreamSubscription<bool> _bufferingSub;

  @override
  void initState() {
    super.initState();
    _player = Player(
      configuration: const PlayerConfiguration(
        bufferSize: 100 * 1024 * 1024,
        async: true,

      )
    );

    _controller = VideoController(_player,configuration: const VideoControllerConfiguration(
      hwdec: "auto"
    ));

    _player.open(Media(widget.videoUrl), play: true);

    _positionSub = _player.stream.position.listen((pos) {
      if (_isDisposed) return;
      setState(() {
        _position = pos;
      });
      if (widget.onProgressChanged != null) {
        widget.onProgressChanged!(
          pos,
          _duration,
        );
      }
    });

    _durationSub = _player.stream.duration.listen((duration) async {
      if (_isDisposed) return;
      setState(() {
        _duration = duration;
      });
      if (widget.startPoint != null && !_hasSeekedToStartPoint && duration > Duration.zero) {
        await _player.seek(widget.startPoint!);
        _hasSeekedToStartPoint = true;
      }
    });

    _bufferingSub = _player.stream.buffering.listen((isBuffering) {
      if (_isDisposed) return;
      setState(() {
        _isBuffering = isBuffering;
      });
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _positionSub.cancel();
    _durationSub.cancel();
    _bufferingSub.cancel();
    _player.dispose();
    super.dispose();
  }

  double _getAspectRatio() {
    final width = _player.state.width;
    final height = _player.state.height;
    if (width != null && height != null && width > 0 && height > 0) {
      return width / height;
    }
    return 16 / 9;
  }

  bool get _isInitialized {
    final width = _player.state.width;
    final height = _player.state.height;
    return width != null && height != null && width > 0 && height > 0;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(AppCorner.videoCard)
          ),
          child: const CircularProgressIndicator(
            color: AppColors.iconGreen,
          ),
        ),
      );
    }
    return AspectRatio(
      aspectRatio: _getAspectRatio(),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MaterialVideoControlsTheme(
            normal:  MaterialVideoControlsThemeData(
              buttonBarButtonSize: 20.0,
              buttonBarButtonColor: AppColors.iconTertiary,
              volumeGesture: true,
              brightnessGesture: true,
              seekGesture: true,
              padding: const EdgeInsets.all(10),
              displaySeekBar: true,
              automaticallyImplySkipNextButton: true,
              automaticallyImplySkipPreviousButton: true,
              gesturesEnabledWhileControlsVisible: true,
              controlsHoverDuration: const Duration(seconds: 2),
              visibleOnMount: true,
              seekOnDoubleTapForwardDuration: const Duration(seconds: 5),
              seekOnDoubleTapBackwardDuration: const Duration(seconds: 5),
              seekOnDoubleTapEnabledWhileControlsVisible: true,
              seekOnDoubleTap: true,
              bufferingIndicatorBuilder: (p0) {
                return const CircularProgressIndicator(
                  color: AppColors.iconTertiary,
                );
              },
            ),
            fullscreen: MaterialVideoControlsThemeData(
              buttonBarButtonSize: 20.0,
              buttonBarButtonColor: AppColors.iconTertiary,
              volumeGesture: true,
              brightnessGesture: true,
              seekGesture: true,
              padding: const EdgeInsets.all(10),
              displaySeekBar: true,
              automaticallyImplySkipNextButton: true,
              automaticallyImplySkipPreviousButton: true,
              gesturesEnabledWhileControlsVisible: true,
              controlsHoverDuration: const Duration(seconds: 2),
              visibleOnMount: true,
              seekOnDoubleTapForwardDuration: const Duration(seconds: 5),
              seekOnDoubleTapBackwardDuration: const Duration(seconds: 5),
              seekOnDoubleTapEnabledWhileControlsVisible: true,
              seekOnDoubleTap: true,
              bufferingIndicatorBuilder: (p0) {
                return const CircularProgressIndicator(
                  color: AppColors.iconTertiary,
                );
              },
            ),
            child: Scaffold(
              body: Video(
                controller: _controller,
                filterQuality: FilterQuality.medium,
                onEnterFullscreen: () async {
                  SystemChrome.setPreferredOrientations(
                      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.bottom,SystemUiOverlay.top]);
                },
                onExitFullscreen: () async {
                  SystemChrome.setPreferredOrientations(
                      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom,SystemUiOverlay.top]);
                  await SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                },
                wakelock: true,
                resumeUponEnteringForegroundMode: true,
                pauseUponEnteringBackgroundMode: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}