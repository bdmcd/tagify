
import 'package:tagify/model/now_playing.dart';
import 'package:tagify/model/playable.dart';
import 'package:tagify/model/track.dart';
import 'package:tagify/player/player.dart';

class SpotifyWebPlayer extends Player {
  @override
  Future<bool> next() {
    // TODO: implement next
    return null;
  }

  @override
  Future<bool> pause() {
    // TODO: implement pause
    return null;
  }

  @override
  Future<bool> play(Playable playable) {
    // TODO: implement play
    return null;
  }

  @override
  Future<bool> previous() {
    // TODO: implement previous
    return null;
  }

  @override
  Future<bool> queue(Track track) {
    // TODO: implement queue
    return null;
  }

  @override
  Future<bool> resume() {
    // TODO: implement resume
    return null;
  }

  @override
  Future<bool> toggleRepeat() {
    // TODO: implement toggleRepeat
    return null;
  }

  @override
  Future<bool> toggleShuffle() {
    // TODO: implement toggleShuffle
    return null;
  }

  @override
  Future<NowPlaying> nowPlaying() {
    // TODO: implement nowPlaying
    return null;
  }
}