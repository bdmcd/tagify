import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/model/now_playing.dart';
import 'package:tagify/model/track.dart';
import 'package:tagify/player/player.dart';

class PlayerNotifier extends ChangeNotifier implements PlayerListener {
  @override
  notify() => this.notifyListeners();
}

class ShuffleVM extends PlayerNotifier {
  static ShuffleVM of(BuildContext context) => Provider.of<ShuffleVM>(context);

  ShuffleVM() {
    Player.instance.shuffleListeners.add(this);
  }

  @override
  notify() => this.notifyListeners();

  bool get isShuffling => Player.instance.isShuffling;
  toggleShuffle() async => await Player.instance.toggleShuffle();
}

class RepeatModeVM extends PlayerNotifier {
  static RepeatModeVM of(BuildContext context) => Provider.of<RepeatModeVM>(context);

  RepeatModeVM() {
    Player.instance.repeatModeListeners.add(this);
  }

  RepeatMode get repeatMode => Player.instance.repeatMode;
  toggleRepeat() async => await Player.instance.toggleRepeat();
}

class ResumePauseVM extends PlayerNotifier {
  static ResumePauseVM of(BuildContext context) => Provider.of<ResumePauseVM>(context);

  ResumePauseVM() {
    Player.instance.isPausedListeners.add(this);
  }

  @override
  notify() => this.notifyListeners();

  bool get isPaused => Player.instance.isPaused;
  resume() async => await Player.instance.resume();
  pause() async => await Player.instance.pause();
  toggle() async {
    if (isPaused) {
      resume();
    } else {
      pause();
    }
  }
}

class NowPlayingVM extends PlayerNotifier {
  static NowPlayingVM of(BuildContext context) => Provider.of<NowPlayingVM>(context);

  NowPlayingVM() {
    Player.instance.trackInfoListeners.add(this);
  }

  Future<bool> init() async => await Player.instance.init();

  Track get track => Player.instance.track;
}

class AlbumArtVM extends PlayerNotifier {
  static AlbumArtVM of(BuildContext context) => Provider.of<AlbumArtVM>(context);

  AlbumArtVM() {
    Player.instance.albumArtListeners.add(this);
  }

  String get albumArt => Player.instance.track?.album?.albumArt;
}

class PlayerControls extends ChangeNotifier {
  static PlayerControls of(BuildContext context) => Provider.of<PlayerControls>(context);

  play(Track track) async => await Player.instance.play(track);
  queue(Track track) async => await Player.instance.queue(track);
  next() async => await Player.instance.next();
  previous() async => await Player.instance.previous();
  resume() async => await Player.instance.resume();
  pause() async => await Player.instance.pause();
}