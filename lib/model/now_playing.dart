import 'package:tagify/model/track.dart';

enum RepeatMode {
  None,
  RepeatOne,
  RepeatAll,
}

class NowPlaying {
  final int position;
  final bool isPaused;
  final RepeatMode repeatMode;
  final bool isShuffling;
  final Track track;

  final bool canSeek;
  final bool canNext;
  final bool canPrevious;
  final bool canToggleShuffle;
  final int maxRepeatMode;

  bool get canToggleRepeat => maxRepeatMode > 0;

  NowPlaying({
    this.position,
    this.isPaused,
    this.repeatMode,
    this.isShuffling,
    this.track,
    this.canSeek = true,
    this.canNext = true,
    this.canPrevious = true,
    this.canToggleShuffle = true,
    this.maxRepeatMode = 2
  });

  NowPlaying copyWith({
    int position,
    bool isPaused,
    RepeatMode repeatMode,
    bool isShuffling,
    Track track,
    bool canSeek,
    bool canNext,
    bool canPrevious,
    bool canToggleShuffle,
    int maxRepeatMode,
  }) => NowPlaying(
    position: position ?? this.position,
    isPaused: isPaused ?? this.isPaused,
    repeatMode: repeatMode ?? this.repeatMode,
    isShuffling: isShuffling ?? this.isShuffling,
    track: track ?? this.track,
    canSeek: canSeek ?? this.canSeek,
    canNext: canNext ?? this.canNext,
    canPrevious: canPrevious ?? this.canPrevious,
    maxRepeatMode: maxRepeatMode ?? this.maxRepeatMode,
  );
}