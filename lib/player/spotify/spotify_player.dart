import 'package:spotify_playback/spotify_playback.dart';
import 'package:tagify/model/album.dart';
import 'package:tagify/model/artist.dart';
import 'package:tagify/model/now_playing.dart';
import 'package:tagify/model/track.dart';
import 'package:tagify/player/player.dart';

import 'dart:convert';

class SpotifyPlayer extends Player {
  NowPlaying _nowPlaying;

  @override bool get isShuffling => _nowPlaying.isShuffling;
  @override RepeatMode get repeatMode => _nowPlaying.repeatMode;
  @override bool get isPaused => _nowPlaying.isPaused;
  @override Track get track => _nowPlaying.track;

  void _handlePlayerStateChange(state) {
    print(json.encode(state));
  }

  @override
  Future<bool> init() async {
    SpotifyPlayback.initSubscription(_handlePlayerStateChange);
  }

  @override
  Future<void> toggleShuffle() async {
  }

  @override
  Future<void> toggleRepeat() async {
  }

  @override
  Future<void> play(Track track) async {
  }

  @override
  Future<void> queue(Track track) async {
  }

  @override
  Future<void> pause() async {
  }

  @override
  Future<void> resume() async {
  }

  @override
  Future<void> next() async {
  }

  @override
  Future<void> previous() async {
  }
}

class UpdatedNowPlaying {
  // List<String>
}