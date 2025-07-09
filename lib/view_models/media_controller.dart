// audio_player_controller.dart
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:revalesuva/utils/app_colors.dart';

class CustomAudioHandler extends BaseAudioHandler with SeekHandler {
  @override
  Future<void> play() async {}

  @override
  Future<void> pause() async {}

  @override
  Future<void> stop() async {}

  @override
  Future<void> seek(Duration position) async {}
}

class AudioPlayerController extends GetxController {

  final _player = AudioPlayer();
  final currentUrl = RxnString();
  final mediaItem = Rxn<MediaItem>();
  final playbackState = Rx<PlaybackState>(PlaybackState());
  final position = Rx<Duration>(Duration.zero);
  final bufferedPosition = Rx<Duration>(Duration.zero);
  final isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    initAudioService();
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }

  Future<void> initAudioService() async {
    await _initializeAudioService();
    await _configureAudioSession();
    _setupEventListeners();
  }

  Future<void> _initializeAudioService() async {
    await AudioService.init(
      builder: () => CustomAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.example.myapp.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationChannelDescription: 'Audio playback controls',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
        androidNotificationIcon: 'mipmap/launcher_icon',
        notificationColor: AppColors.surfaceGreen,
      ),
    );
  }

  Future<void> _configureAudioSession() async {
    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playback,
        avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
        avAudioSessionMode: AVAudioSessionMode.defaultMode,
        avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
        avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
        androidAudioAttributes: AndroidAudioAttributes(
          contentType: AndroidAudioContentType.music,
          flags: AndroidAudioFlags.none,
          usage: AndroidAudioUsage.media,
        ),
        androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
        androidWillPauseWhenDucked: true,
      ));
    } catch (e) {
      debugPrint("Error configuring audio session: $e");
    }
  }

  void _setupEventListeners() {
    // Listen to player position changes
    _player.positionStream.listen((pos) => position.value = pos);

    // Listen to buffered position changes
    _player.bufferedPositionStream.listen((pos) => bufferedPosition.value = pos);

    // Listen to player state changes
    _player.playingStream.listen((playing) => isPlaying.value = playing);

    // Listen to playback events
    _player.playbackEventStream.listen(_handlePlaybackEvent);

    // Listen to player state for completion
    _player.playerStateStream.listen(_handlePlayerState);
  }

  void _handlePlaybackEvent(PlaybackEvent event) {
    final processingState = const {
      ProcessingState.idle: AudioProcessingState.idle,
      ProcessingState.loading: AudioProcessingState.loading,
      ProcessingState.buffering: AudioProcessingState.buffering,
      ProcessingState.ready: AudioProcessingState.ready,
      ProcessingState.completed: AudioProcessingState.completed,
    }[_player.processingState]!;

    playbackState.value = PlaybackState(
      controls: [
        isPlaying.value ? MediaControl.pause : MediaControl.play,
        MediaControl.stop,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [1],
      processingState: processingState,
      playing: isPlaying.value,
      updatePosition: position.value,
      bufferedPosition: bufferedPosition.value,
      speed: _player.speed,
    );
  }

  void _handlePlayerState(PlayerState state) {
    if (state.processingState == ProcessingState.completed) {
      currentUrl.value = null;
      stop();
    }
  }

  Future<void> setupAudioUrl({
    required String uri,
    required String id,
    required String title,
    required String description,
    required String artist,
  }) async {
    if (uri.isEmpty) {
      debugPrint("Error: Empty URI provided");
      return;
    }

    try {
      if (_player.playing) {
        await _player.stop();
      }

      currentUrl.value = uri;
      await _player.setAudioSource(AudioSource.uri(Uri.parse(uri)), preload: true);

      mediaItem.value = MediaItem(
        id: id,
        album: "Podcast",
        title: title,
        artist: artist,
        displayDescription: description,
        duration: _player.duration,
      );

      await play();
    } catch (e) {
      debugPrint("Error setting up audio: $e");
      currentUrl.value = null;
      mediaItem.value = null;
    }
  }

  Future<void> play() async {
    try {
      await _player.play();
    } catch (e) {
      debugPrint("Error playing audio: $e");
    }
  }

  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e) {
      debugPrint("Error pausing audio: $e");
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
      currentUrl.value = null;
      mediaItem.value = null;
    } catch (e) {
      debugPrint("Error stopping audio: $e");
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
    } catch (e) {
      debugPrint("Error seeking audio: $e");
    }
  }

  bool isPlayingUrl(String url) => currentUrl.value == url && isPlaying.value;
}
