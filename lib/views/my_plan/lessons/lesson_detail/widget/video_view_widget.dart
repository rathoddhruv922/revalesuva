import 'package:flutter/material.dart';
import 'package:revalesuva/components/video_media_player.dart';
import 'package:revalesuva/components/vimeo_player.dart';

class VideoViewWidget extends StatelessWidget {
  const VideoViewWidget(
      {super.key, required this.videoUrl, required this.playedLength, this.onProgressChanged});

  final String videoUrl;
  final String playedLength;
  final Function(Duration position, Duration duration)? onProgressChanged;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: VideoMediaPlayer(
        videoUrl: videoUrl,
        startPoint: Duration(seconds: int.tryParse(playedLength) ?? 0),
        onProgressChanged: onProgressChanged,
      ),
    );
  }
}

class VimeoViewWidget extends StatelessWidget {
  const VimeoViewWidget(
      {super.key, required this.vimeoVideoId, required this.playedLength, this.onProgressChanged});

  final String vimeoVideoId;
  final String playedLength;
  final Function(Duration position, Duration duration)? onProgressChanged;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: VimeoPlayer(
        videoId: vimeoVideoId,
        startPoint: Duration(seconds: int.tryParse(playedLength) ?? 0),
        onProgressChanged: onProgressChanged,
      ),
    );
  }
}
