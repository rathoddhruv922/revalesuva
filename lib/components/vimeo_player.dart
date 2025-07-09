import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class VimeoPlayer extends StatefulWidget {
  final String videoId;
  final Function(Duration position, Duration duration)? onProgressChanged;
  final Duration? startPoint;

  const VimeoPlayer({
    super.key,
    required this.videoId,
    this.onProgressChanged,
    this.startPoint,
  });

  @override
  State<VimeoPlayer> createState() => _VimeoPlayerState();
}

class _VimeoPlayerState extends State<VimeoPlayer> {
  bool isVideoLoading = true;
  InAppWebViewController? webViewController;

  @override
  void dispose() {
    webViewController?.dispose();
    super.dispose();
  }

  void _injectJavaScriptListeners() async {
    final startPointInSeconds = widget.startPoint?.inSeconds ?? 0;
    // This JS listens for time update, duration change, and fullscreen events and posts them to Flutter
    final js = """
      (function() {
        var player = document.querySelector('iframe');
        if (!player) return;
        var vimeoPlayer = new window.Vimeo.Player(player);
        var startPoint = $startPointInSeconds;

        function sendProgress() {
          vimeoPlayer.getCurrentTime().then(function(seconds) {
            vimeoPlayer.getDuration().then(function(duration) {
              window.flutter_inappwebview.callHandler('onProgressChanged', seconds, duration);
            });
          });
        }

        vimeoPlayer.on('timeupdate', sendProgress);
        vimeoPlayer.on('durationchange', sendProgress);

        vimeoPlayer.on('loaded', function() {
          sendProgress();
          if (startPoint > 0) {
            vimeoPlayer.setCurrentTime(startPoint).then(function() {
              return vimeoPlayer.play();
            }).catch(function(error) {
              console.error('Error setting start time or playing:', error.name, error.message);
            });
          }
        });

        vimeoPlayer.on('fullscreenchange', function(data) {
          window.flutter_inappwebview.callHandler('onFullScreenChanged', data.fullscreen);
        });
      })();
    """;
    await webViewController?.evaluateJavascript(source: js);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            VimeoVideoPlayer(
              videoId: widget.videoId,
              isAutoPlay: true,
              isLooping: false,
              backgroundColor: Colors.black,
              onInAppWebViewReceivedError: (controller, request, error) {},
              showControls: true,
              onInAppWebViewCreated: (controller) {
                webViewController = controller;
                controller.addJavaScriptHandler(
                  handlerName: 'onProgressChanged',
                  callback: (args) {
                    if (widget.onProgressChanged != null && args.length >= 2) {
                      final position = Duration(seconds: (args[0] as num).floor());
                      final duration = Duration(seconds: (args[1] as num).floor());
                      widget.onProgressChanged!(position, duration);
                    }
                  },
                );
                controller.addJavaScriptHandler(
                  handlerName: 'onFullScreenChanged',
                  callback: (args) {
                    if (args.isNotEmpty && args[0] is bool) {
                      final isFullScreen = args[0] as bool;
                      if (isFullScreen) {
                        SystemChrome.setPreferredOrientations(
                            [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
                      } else {
                        SystemChrome.setPreferredOrientations(
                            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
                      }
                    }
                  },
                );
              },
              onInAppWebViewLoadStop: (controller, url) async {
                setState(() {
                  isVideoLoading = false;
                });
                // Inject JS after page load
                _injectJavaScriptListeners();
              },
              onInAppWebViewLoadStart: (controller, url) {
                setState(() {
                  isVideoLoading = true;
                });
              },

            ),
            if (isVideoLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
