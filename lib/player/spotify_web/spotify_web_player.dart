
import 'package:tagify/model/now_playing.dart';
import 'package:tagify/model/track.dart';
import 'package:tagify/player/player.dart';

class SpotifyWebPlayer extends Player {

  @override bool get isPaused => null;
  @override bool get isShuffling => null;
  @override RepeatMode get repeatMode => null;
  @override Track get track => null;

  @override
  Future<bool> init() async {
    // TODO: implement next
    return false;
  }

  @override
  Future<void> next() async {
    // TODO: implement next
    return null;
  }

  @override
  Future<void> pause() async {
    // TODO: implement pause
    return null;
  }

  @override
  Future<void> play(Track track) async {
    // TODO: implement play
    return null;
  }

  @override
  Future<void> previous() async {
    // TODO: implement previous
    return null;
  }

  @override
  Future<void> queue(Track track) async {
    // TODO: implement queue
    return null;
  }

  @override
  Future<void> resume() async {
    // TODO: implement resume
    return null;
  }

  @override
  Future<void> toggleRepeat() async {
    // TODO: implement toggleRepeat
    return null;
  }

  @override
  Future<void> toggleShuffle() async {
    // TODO: implement toggleShuffle
    return null;
  }
}