import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:revalesuva/utils/app_colors.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  static final AudioPlayerHandler instance = AudioPlayerHandler._internal();
  static bool _isInitialized = false;
  final _player = AudioPlayer();
  String? _currentUrl;
  MediaItem? _mediaItem;

  factory AudioPlayerHandler() {
    return instance;
  }

  AudioPlayerHandler._internal();

  AudioPlayer get player => AudioPlayer();

  Future<void> init() async {
    if (!_isInitialized) {
      await AudioService.init(
        builder: () => this,
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
      _isInitialized = true;
    }

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
      print("Error configuring audio session: $e");
    }

    playbackEvent();
    playerState();
  }

  playbackEvent() {
    _player.playbackEventStream.listen((event) {
      final playing = _player.playing;
      final processingState = const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!;

      playbackState.add(playbackState.value.copyWith(
        controls: [
          playing ? MediaControl.pause : MediaControl.play,
          MediaControl.stop,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [1],
        processingState: processingState,
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
      ));
    });
  }

  playerState() {
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _currentUrl = null;
        stop();
      }
    });
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

      _currentUrl = uri;
      await _player.setAudioSource(
        AudioSource.uri(Uri.parse(uri)),
        preload: true,
      );
      _mediaItem = MediaItem(
        id: id,
        album: "Podcast",
        title: title,
        artist: artist,
        displayDescription: description,
        duration: _player.duration, // Set duration here
      );
      mediaItem.add(_mediaItem!);
      await play();
    } catch (e) {
      _currentUrl = null;
      _mediaItem = null;
    }
  }

  @override
  Future<void> play() async {
    try {
      await _player.play();
    } catch (e) {
      debugPrint("Error playing audio: $e");
    }
  }

  @override
  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e) {
      debugPrint("Error pausing audio: $e");
    }
  }

  @override
  Future<void> stop() async {
    try {
      await _player.stop();
      _currentUrl = null;
      _mediaItem = null;
    } catch (e) {
      debugPrint("Error stopping audio: $e");
    }
  }

  @override
  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
    } catch (e) {
      debugPrint("Error seeking audio: $e");
    }
  }

  bool isPlayingUrl(String url) {
    return _currentUrl == url && _player.playing;
  }
}
