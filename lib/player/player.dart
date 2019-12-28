import 'package:tagify/model/now_playing.dart';
import 'package:tagify/model/playable.dart';
import 'package:tagify/model/track.dart';
import 'package:tagify/player/impl.dart';
import 'package:tagify/player/spotify/spotify_player.dart';
import 'package:tagify/player/spotify_web/spotify_web_player.dart';

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

  Future<bool> play(Playable playable);
  Future<bool> pause();
  Future<bool> resume();
  Future<bool> queue(Track track);
  Future<bool> toggleShuffle();
  Future<bool> toggleRepeat();
  Future<bool> next();
  Future<bool> previous();
  Future<NowPlaying> nowPlaying();
}