import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/audio_player_handler.dart';

class PlayerProgressbarWidget extends StatelessWidget {
  const PlayerProgressbarWidget(
      {super.key, required this.audioPlayerHandler, required this.audioupload});

  final AudioPlayerHandler audioPlayerHandler;
  final String audioupload;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: audioPlayerHandler.playbackState,
      builder: (context, snapshot) {
        final playing = snapshot.data?.playing ?? false;
        final isCurrentTrack = audioPlayerHandler.isPlayingUrl(audioupload);

        if (!isCurrentTrack || !playing) return const SizedBox.shrink();

        return Column(
          children: [
            const Gap(8),
            StreamBuilder<MediaItem?>(
              stream: audioPlayerHandler.mediaItem,
              builder: (context, mediaItemSnapshot) {
                return StreamBuilder<Duration>(
                  stream: AudioService.position,
                  builder: (context, positionSnapshot) {
                    final position = positionSnapshot.data ?? Duration.zero;
                    final duration = mediaItemSnapshot.data?.duration ?? Duration.zero;
                    final maxDuration = double.tryParse(duration.inMilliseconds.toString()) ?? 0.0;
                    final currentPosition = double.tryParse(position.inMilliseconds.toString()) ?? 0.0;

                    return Column(
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 2.0,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 6.0,
                            ),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 14.0,
                            ),
                            activeTrackColor: AppColors.surfaceGreen,
                            inactiveTrackColor: AppColors.surfaceGreen.withAlpha(77),
                            // 0.3 * 255 = 77
                            thumbColor: AppColors.surfaceGreen,
                            overlayColor: AppColors.surfaceGreen.withAlpha(51), // 0.2 * 255 = 51
                          ),
                          child: Slider(
                            min: 0.0,
                            max: maxDuration,
                            value: currentPosition.clamp(0.0, maxDuration),
                            onChanged: (value) {
                              audioPlayerHandler.seek(Duration(milliseconds: value.round()));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(position),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                _formatDuration(duration),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return '--:--';
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
