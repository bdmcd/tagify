import 'package:spotify_playback/spotify_playback.dart';
import 'package:tagify/model/album.dart';
import 'package:tagify/model/artist.dart';
import 'package:tagify/model/now_playing.dart';
import 'package:tagify/model/playable.dart';
import 'package:tagify/model/track.dart';
import 'package:tagify/player/player.dart';
import 'package:tagify/spotify_api/spotify_globals.dart';

class SpotifyPlayer extends Player {
  
  @override
  Future<bool> next() async {
    try {
      return await SpotifyPlayback.skipNext();
    } on Exception catch(e) {
      print(e);
    }
    return false;
  }

  @override
  Future<bool> pause() async {
    try {
      return await SpotifyPlayback.pause();
    } on Exception catch(e) {
      print(e);
    }
    return false;
  }

  @override
  Future<bool> play(Playable playable) async {
    try {
      return await SpotifyPlayback.play(playable.uri);
    } on Exception catch(e) {
      print(e);
    }
    return false;
  }

  @override
  Future<bool> previous() async {
    try {
      return await SpotifyPlayback.skipPrevious();
    } on Exception catch(e) {
      print(e);
    }
    return false;
  }

  @override
  Future<bool> queue(Track track) async {
    try {
      return await SpotifyPlayback.queue(track.uri);
    } on Exception catch(e) {
      print(e);
    }
    return false;
  }

  @override
  Future<bool> resume() async {
    try {
      return await SpotifyPlayback.resume();
    } on Exception catch(e) {
      print(e);
    }
    return false;
  }

  @override
  Future<bool> toggleRepeat() async {
    try {
      return await SpotifyPlayback.toggleRepeat();
    } on Exception catch(e) {
      print(e);
    }
    return false;
  }

  @override
  Future<bool> toggleShuffle() async {
    try {
      return await SpotifyPlayback.toggleShuffle();
    } on Exception catch(e) {
      print(e);
    }
    return false;
  }

  @override
  Future<NowPlaying> nowPlaying() async {
    try  {
      final state = await SpotifyPlayback.getPlaybackState();
      return await _Helpers.getNowPlayingFromMap(state);
    } on Exception catch(e) {
      print(e);
    }
    return null;
  }
}


class _Helpers {
  static Future<NowPlaying> getNowPlayingFromMap(Map state) async {
    final track = state['track'];
    if (track == null) {
      return null;
    }

    final artist = track['artist'];
    final album = track['album'];
    final restrictions = state['playback_restrictions'];

    final n = NowPlaying(
      isPaused: state['is_paused'],
      isShuffling: state['playback_options']['shuffle'],
      position: state['position'],
      repeatMode: RepeatMode.values[state['playback_options']['repeat']],

      canSeek: restrictions['can_seek'],
      canNext: restrictions['can_skip_next'],
      canPrevious: restrictions['can_skip_prev'],
      canToggleShuffle: restrictions['can_toggle_shuffle'],
      maxRepeatMode: restrictions['can_repeat_context'] ? 2 : restrictions['can_repeat_track'] ? 1 : 0,

      track: Track(
        album: Album(
          name: album['name'],
          uri: album['uri'],
        ),
        artists: [
          Artist(uri: artist['uri'], name: artist['name']),
        ],
        isLocal: false,
        explicit: false,
        uri: state['track']['uri'],
        duration: track['duration_ms'],
        name: track['name'],
      ),
    );
    return n;
  }
}