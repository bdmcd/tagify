import 'package:tagify/model/track.dart';

enum RepeatMode {
  RepeatAll,
  None,
  RepeatOne,
}

class NowPlaying {
  final bool isShuffling;
  final RepeatMode repeatMode;
  final bool isPaused;
  final int position;
  final Track track;

  NowPlaying({
    this.isShuffling,
    this.repeatMode,
    this.isPaused,
    this.position,
    this.track,
  });

  NowPlaying copyWith({
    bool isShuffling,
    RepeatMode repeatMode,
    bool isPaused,
    int position,
    Track track,
  }) => NowPlaying(
    isShuffling: isShuffling ?? this.isShuffling,
    repeatMode: repeatMode ?? this.repeatMode,
    isPaused: isPaused ?? this.isPaused,
    position: position ?? this.position,
    track: track ?? this.track,
  );
}