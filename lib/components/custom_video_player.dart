/*

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:video_player/video_player.dart';

import '../utils/app_corner.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({
    super.key,
    required this.videoUrl,
    this.onProgressChanged,
    this.startPoint = 0,
  });

  final String videoUrl;
  final int startPoint;
  final Function(Duration position, Duration duration)? onProgressChanged;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isLoading = true; // Track loading state
  bool _isBuffering = false; // Track buffering state

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
        allowBackgroundPlayback: false,
      ),
    );

    _controller.addListener(_videoListener);
    _controller.setLooping(false);
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    await _controller.initialize();
    _duration = _controller.value.duration;
    _controller.seekTo(Duration(seconds: widget.startPoint));

    // Pre-buffering: Play and immediately pause to buffer some data
    await _controller.play();
    await Future.delayed(const Duration(milliseconds: 300)); // Let it buffer a bit
    await _controller.pause();

    setState(() {
      _isLoading = false; // Set loading to false after initialization
      _isBuffering = _controller.value.isBuffering;
    });
  }

  void _videoListener() {
    if (!mounted) return;

    final newPosition = _controller.value.position;
    final isBufferingNow = _controller.value.isBuffering;

    if (_position != newPosition) {
      setState(() {
        _position = newPosition;
      });

      widget.onProgressChanged?.call(_position, _duration);
    }

    if (_isBuffering != isBufferingNow) {
      setState(() {
        _isBuffering = isBufferingNow;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Colors.black, // Set background color to black
          borderRadius: BorderRadius.all(
            Radius.circular(AppCorner.videoCard),
          ),
        ),
        child: Stack(
          children: [
            if (_isLoading) // Show loader when loading
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            else
              VideoPlayer(_controller),
            // Show loader when buffering (but not during initial loading)
            if (!_isLoading && _isBuffering)
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            // Controls overlay handles tap-to-show/hide and play/pause
            if (!_isLoading)
              _ControlsOverlay(
                controller: _controller,
                position: _position,
                duration: _duration,
                isBuffering: _isBuffering,
              ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(
                  Icons.fullscreen,
                  color: AppColors.surfaceTertiary,
                ),
                onPressed: () {
                  Get.to(
                    FullScreenVideoPlayer(
                      controller: _controller,
                      position: _position,
                      duration: _duration,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({
    required this.controller,
    required this.position,
    required this.duration,
    this.isBuffering = false,
  });

  final VideoPlayerController controller;
  final Duration position;
  final Duration duration;
  final bool isBuffering;

  @override
  State<_ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<_ControlsOverlay> {
  bool _showControls = false;
  late Duration _lastPosition;
  late Duration _duration;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _lastPosition = widget.position;
    _duration = widget.duration;
  }

  @override
  void didUpdateWidget(covariant _ControlsOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    _lastPosition = widget.position;
    _duration = widget.duration;
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _onTap() {
    if (widget.isBuffering) return; // Don't show controls while buffering
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _startHideTimer();
    } else {
      _hideTimer?.cancel();
    }
  }

  void _onPlayPause() {
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
    } else {
      widget.controller.play();
    }
    setState(() {});
    _startHideTimer();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return duration.inHours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If buffering, hide controls (loader is shown by parent)
    if (widget.isBuffering) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Stack(
        children: <Widget>[
          // Controls overlay
          AnimatedOpacity(
            opacity: _showControls || !widget.controller.value.isPlaying ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              color: Colors.black26,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      iconSize: 60,
                      icon: widget.controller.value.isPlaying
                          ? const Icon(Icons.pause, color: AppColors.surfaceTertiary)
                          : const ImageIcon(
                              AssetImage(Assets.iconsIcVideoPlay),
                              color: AppColors.surfaceTertiary,
                              size: 60,
                              semanticLabel: 'Play',
                            ),
                      onPressed: _onPlayPause,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${_formatDuration(widget.position)} / ${_formatDuration(widget.duration)}',
                      style: const TextStyle(
                        color: AppColors.surfaceTertiary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Progress indicator at bottom (always visible)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 4,
              child: LinearProgressIndicator(
                value: widget.duration.inSeconds > 0
                    ? widget.position.inSeconds / widget.duration.inSeconds
                    : 0,
                backgroundColor: Colors.grey.withOpacity(0.5),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.surfaceTertiary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenVideoPlayer extends StatefulWidget {
  const FullScreenVideoPlayer(
      {super.key, required this.controller, required this.position, required this.duration});

  final VideoPlayerController controller;
  final Duration position;
  final Duration duration;

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isBuffering = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _position = widget.position;
    _duration = widget.duration;
    widget.controller.addListener(_videoListener);
    _isBuffering = widget.controller.value.isBuffering;
  }

  void _videoListener() {
    if (!mounted) return;
    final isBufferingNow = widget.controller.value.isBuffering;
    if (_isBuffering != isBufferingNow) {
      setState(() {
        _isBuffering = isBufferingNow;
      });
    }
    setState(() {
      _position = widget.controller.value.position;
      _duration = widget.controller.value.duration;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_videoListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(widget.controller),
              if (_isBuffering)
                const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              if (!_isLoading)
                _ControlsOverlay(
                  controller: widget.controller,
                  position: _position,
                  duration: _duration,
                  isBuffering: _isBuffering,
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Reset preferred orientations when exiting full-screen mode
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          Navigator.of(context).pop();
        },
        backgroundColor: AppColors.surfaceGreen,
        child: const Icon(Icons.fullscreen_exit),
      ),
    );
  }
}

class CustomVideoThumbnail extends StatefulWidget {
  final String videoUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Function()? onTap;

  const CustomVideoThumbnail({
    super.key,
    required this.videoUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.onTap,
  });

  @override
  State<CustomVideoThumbnail> createState() => _CustomVideoThumbnailState();
}

class _CustomVideoThumbnailState extends State<CustomVideoThumbnail> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );
    try {
      await _controller.initialize();
      // Seek to the first frame to use as thumbnail
      await _controller.seekTo(Duration.zero);
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: Container(
          width: widget.width,
          height: widget.height,
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Video thumbnail
              if (_isInitialized)
                FittedBox(
                  fit: widget.fit,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                )
              else
                Container(
                  color: Colors.grey[900],
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              // Overlay with play button
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black26,
                ),
                child: const Center(
                  child: ImageIcon(
                    AssetImage(Assets.iconsIcVideoPlay),
                    color: AppColors.surfaceTertiary,
                    size: 40,
                    semanticLabel: 'Play',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
