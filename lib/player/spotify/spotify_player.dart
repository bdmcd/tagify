import 'package:spotify_playback/spotify_playback.dart';
import 'package:tagify/model/album.dart';
import 'package:tagify/model/artist.dart';
import 'package:tagify/model/now_playing.dart';
import 'package:tagify/model/track.dart';
import 'package:tagify/player/library.dart';
import 'package:tagify/player/player.dart';

enum PlayerStates {
  isPaused,
  isShuffling,
  repeatMode,
  position,
  albumArt,
  track,
}

class SpotifyPlayer extends Player {
  NowPlaying _nowPlaying;

  @override bool get isShuffling => _nowPlaying.isShuffling;
  @override RepeatMode get repeatMode => _nowPlaying.repeatMode;
  @override bool get isPaused => _nowPlaying.isPaused;
  @override Track get track => _nowPlaying.track;

  void _handlePlayerStateChange(state) {
    _UpdatedNowPlaying updated = _UpdatedNowPlaying.update(state, _nowPlaying);
    _nowPlaying = updated.nowPlaying;

    if (updated.updatedStates.contains(PlayerStates.isPaused)) notifyIsPausedListeners();
    if (updated.updatedStates.contains(PlayerStates.isShuffling)) notifyShuffleListeners(); 
    if (updated.updatedStates.contains(PlayerStates.repeatMode)) notifyRepeatModeListeners();
    if (updated.updatedStates.contains(PlayerStates.position)) notifyPositionListeners();
    if (updated.updatedStates.contains(PlayerStates.track)) {
      notifyTrackInfoListeners();
      updateAlbumArt();
    }
  }

  Future<void> updateAlbumArt() async {
    if (_nowPlaying?.track?.album?.albumArt == null) {
      final trackWithArt = await Library.instance.getTrack(_nowPlaying.track.id);

      if(trackWithArt != null) {
        _nowPlaying = _nowPlaying.copyWith(
          track: trackWithArt,
        );
        notifyAlbumArtListeners();
      }
    }
  }

  @override
  Future<bool> init() async {
    final state = await SpotifyPlayback.getPlaybackState();
    _nowPlaying = _Helpers.nowPlaying(state, null);
    await updateAlbumArt();

    await SpotifyPlayback.initSubscription(_handlePlayerStateChange);

    return _nowPlaying != null;
  }

  @override
  Future<void> toggleShuffle() async {
    _nowPlaying = _nowPlaying.copyWith(
      isShuffling: !_nowPlaying.isShuffling,
    );
    notifyShuffleListeners();

    await SpotifyPlayback.toggleShuffle();
  }

  @override
  Future<void> toggleRepeat() async {
    //TODO: new repeat mode

    await SpotifyPlayback.toggleRepeat();
  }

  @override
  Future<void> play(Track track) async {
    await SpotifyPlayback.play(track.uri);
  }

  @override
  Future<void> queue(Track track) async {
    await SpotifyPlayback.queue(track.uri);
  }

  @override
  Future<void> pause() async {
    _nowPlaying = _nowPlaying.copyWith(
      isPaused: true,
    );
    notifyIsPausedListeners();

    await SpotifyPlayback.pause();
  }

  @override
  Future<void> resume() async {
    _nowPlaying = _nowPlaying.copyWith(
      isPaused: false,
    );
    notifyIsPausedListeners();

    await SpotifyPlayback.resume();
  }

  @override
  Future<void> next() async {
    await SpotifyPlayback.skipNext();
  }

  @override
  Future<void> previous() async {
    await SpotifyPlayback.skipPrevious();
  }
}

class _UpdatedNowPlaying {
  final NowPlaying nowPlaying;
  final List<PlayerStates> updatedStates;

  _UpdatedNowPlaying({
    this.nowPlaying,
    this.updatedStates,
  });

  static _UpdatedNowPlaying update(Map map, NowPlaying old) {
    NowPlaying nowPlaying = _Helpers.nowPlaying(map, old);

    List<PlayerStates> updatedStates = [];
    if (nowPlaying.isPaused != old?.isPaused) updatedStates.add(PlayerStates.isPaused);
    if (nowPlaying.isShuffling != old?.isShuffling) updatedStates.add(PlayerStates.isShuffling);
    if (nowPlaying.repeatMode != old?.repeatMode) updatedStates.add(PlayerStates.repeatMode);
    if (nowPlaying.position != old?.position) updatedStates.add(PlayerStates.position);
    if (nowPlaying.track != old?.track) updatedStates.add(PlayerStates.track);

    return _UpdatedNowPlaying(
      nowPlaying: nowPlaying,
      updatedStates: updatedStates,
    );
  }

  
}

class _Helpers {
  static NowPlaying nowPlaying(Map map, NowPlaying old) {
    final playbackOptions = map['playback_options'] ?? {};
    final playbackRestrictions = map['playback_restrictions'] ?? {};

    return NowPlaying(
      isPaused: map['is_paused'] ?? old?.isPaused,
      position: map['playback_position'] ?? old?.position,
      isShuffling: playbackOptions['shuffle'] ?? old?.isShuffling,
      repeatMode: RepeatMode.values[playbackOptions['repeat'] ?? old?.repeatMode?.index],
      track: map['track'] != null && map['track']['uri'] != old?.track?.uri ? _Helpers._track(map['track']) : old.track
    );
  }

  static Track _track(Map map) {
    return Track(
      uri: map['uri'],
      name: map['name'],
      duration: map['duration_ms'],
      album: _Helpers._album(map['album']),
      artists: _Helpers._artists(map['artists']),
    );
  }

  static Album _album(Map map) {
    return Album(
      uri: map['uri'],
      name: map['name'],
    );
  }

  static Artist _artist(Map map) {
    return Artist(
      uri: map['uri'],
      name: map['name'],
    );
  }

  static List<Artist> _artists(List list) {
    return list.map((map) => _Helpers._artist(map)).toList();
  }
}