import 'package:tagify/model/now_playing.dart';
import 'package:tagify/model/track.dart';
import 'package:tagify/player/impl.dart';
import 'package:tagify/player/spotify/spotify_player.dart';
import 'package:tagify/player/spotify_web/spotify_web_player.dart';

abstract class PlayerListener {
  void notify();
}

abstract class Player {
  static Player _instance;
  static Player get instance {
    if (_instance == null) {
      switch(Implementation.impl) {
        case Impl.spotify: 
          _instance = new SpotifyPlayer();
          break;
        case Impl.spotifyWeb:
          _instance = new SpotifyWebPlayer();
          break;
      }
    }

    return _instance;
  }

  final List<PlayerListener> shuffleListeners = [];
  final List<PlayerListener> repeatModeListeners = [];
  final List<PlayerListener> isPausedListeners = [];
  final List<PlayerListener> trackInfoListeners = [];
  final List<PlayerListener> positionListeners = [];
  final List<PlayerListener> albumArtListeners = [];

  void notifyShuffleListeners() => shuffleListeners.forEach((l) => l.notify());
  void notifyRepeatModeListeners() => repeatModeListeners.forEach((l) => l.notify());
  void notifyIsPausedListeners() => isPausedListeners.forEach((l) => l.notify());
  void notifyTrackInfoListeners() => trackInfoListeners.forEach((l) => l.notify());
  void notifyPositionListeners() => positionListeners.forEach((l) => l.notify());
  void notifyAlbumArtListeners() => albumArtListeners.forEach((l) => l.notify());
  
  void notifyAllListeners() {
    notifyShuffleListeners();
    notifyRepeatModeListeners();
    notifyIsPausedListeners();
    notifyTrackInfoListeners();
    notifyPositionListeners();
    notifyAlbumArtListeners();
  }

  bool get isShuffling;
  RepeatMode get repeatMode;
  bool get isPaused;
  Track get track;

  Future<bool> init();
  Future<void> toggleShuffle();
  Future<void> toggleRepeat();
  Future<void> play(Track track);
  Future<void> queue(Track track);
  Future<void> resume();
  Future<void> pause();
  Future<void> next();
  Future<void> previous();
}