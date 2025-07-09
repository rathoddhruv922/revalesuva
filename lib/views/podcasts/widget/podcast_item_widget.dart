import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_click.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/generated/assets.dart';
import 'package:revalesuva/model/podcast/podcast_model.dart' as podcast_model;
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/audio_player_handler.dart';
import 'package:revalesuva/views/podcasts/widget/player_progressbar_widget.dart';

class PodcastItemWidget extends StatefulWidget {
  const PodcastItemWidget({
    super.key,
    required this.data,
    required this.index,
  });

  final podcast_model.Datum data;
  final int index;

  @override
  State<PodcastItemWidget> createState() => _PodcastItemWidgetState();
}

class _PodcastItemWidgetState extends State<PodcastItemWidget> {
  final AudioPlayerHandler _audioHandler = AudioPlayerHandler.instance;

  String _formatDuration(Duration? duration) {
    if (duration == null) return '--:--';
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.surfaceTertiary,
        borderRadius: BorderRadius.circular(AppCorner.listTile),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                StreamBuilder<PlaybackState>(
                  stream: _audioHandler.playbackState,
                  builder: (context, snapshot) {
                    final playing = snapshot.data?.playing ?? false;
                    final isCurrentTrack = _audioHandler.isPlayingUrl(widget.data.audioupload ?? "");

                    return CustomClick(
                      onTap: () async {
                        if (isCurrentTrack && playing) {
                          await _audioHandler.pause();
                        } else {
                          await _audioHandler.setupAudioUrl(
                            uri: widget.data.audioupload ?? "",
                            id: widget.data.id.toString(),
                            title: widget.data.title ?? "",
                            description: widget.data.description ?? "",
                            artist: widget.data.title ?? "",
                          );
                        }
                      },
                      child: ImageIcon(
                        AssetImage(
                          (isCurrentTrack && playing) ? Assets.iconsIcPause : Assets.iconsIcPlay,
                        ),
                        size: 35,
                      ),
                    );
                  },
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextTitleMedium(
                        text: widget.data.title ?? "",
                        maxLine: 1,
                      ),
                      TextBodySmall(
                        text: widget.data.description ?? "",
                        color: AppColors.textPrimary,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Seek bar section that only shows when this track is playing
            PlayerProgressbarWidget(
              audioPlayerHandler: _audioHandler,
              audioupload: widget.data.audioupload ?? "",
            ),
          ],
        ),
      ),
    );
  }
}
