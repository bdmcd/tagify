

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/core/theme.dart';
import 'package:tagify/model/now_playing.dart';
import 'package:tagify/model/track.dart';
import 'package:tagify/player/library.dart';
import 'package:tagify/player/player.dart';

class PlayerVM extends ChangeNotifier {
  static PlayerVM of(BuildContext context) => Provider.of<PlayerVM>(context);
  final TagifyTheme theme; //TODO: find a better way to connect these two

  PlayerVM(this.theme);

  NowPlaying _nowPlaying;
  NowPlaying get nowPlaying => _nowPlaying;

  Future<void> updateNowPlaying() async {
    _nowPlaying = await Player.instance.nowPlaying();
    _nowPlaying = _nowPlaying.copyWith(
      track: _nowPlaying.track.copyWith(
        album: await Library.instance.getAlbum(_nowPlaying.track.album.id)
      )
    );
  }

  Future<void> updateNotify() async {
    await Future.delayed(Duration(milliseconds: 500));
    await updateNowPlaying();
    theme.setPalette(_nowPlaying.track.album);
    await Future.delayed(Duration(milliseconds: 100));

    notifyListeners();
  }

  void tempUpdate(NowPlaying temp) {
    _nowPlaying = temp;
    notifyListeners();
  }

  Future<NowPlaying> getNowPlaying() async {
    if (nowPlaying == null) {
      await updateNowPlaying();
    }
    return nowPlaying;
  }

  Future<bool> play(Track track) async {
    tempUpdate(nowPlaying.copyWith(
      position: 0,
      track: track, 
      isPaused: false, 
    ));

    final r = await Player.instance.play(track);
    await updateNotify();
    return r;
  }

  Future<bool> pause() async {
    tempUpdate(nowPlaying.copyWith(
      isPaused: true
    ));

    final r = await Player.instance.pause();
    await updateNotify();
    return r;
  }

  Future<bool> resume() async {
    tempUpdate(nowPlaying.copyWith(
      position: 0,
      isPaused: false, 
    ));
    
    final r = await Player.instance.resume();
    await updateNotify();
    return r;
  }

  Future<bool> next() async {
    tempUpdate(nowPlaying.copyWith(
      position: 0,
      isPaused: false, 
    ));

    final r = await Player.instance.next();
    await updateNotify();
    return r;
  }

  Future<bool> previous() async {
    tempUpdate(nowPlaying.copyWith(
      position: 0,
    ));

    final r = await Player.instance.previous();
    await updateNotify();
    return r;
  }

  Future<bool> queue(Track track) async {
    final r = await Player.instance.queue(track);
    await updateNotify();
    return r;
  }

  Future<bool> toggleShuffle() async {
    tempUpdate(nowPlaying.copyWith(
      isShuffling: !nowPlaying.isShuffling
    ));

    final r = await Player.instance.toggleShuffle();
    await updateNotify();
    return r;
  }

  Future<bool> toggleRepeat() async {
    var newRepeatMode = nowPlaying.repeatMode.index - 1;
    if (newRepeatMode < 0) newRepeatMode = nowPlaying.maxRepeatMode;
    tempUpdate(nowPlaying.copyWith(
      repeatMode: RepeatMode.values[newRepeatMode],
    ));

    final r = await Player.instance.toggleRepeat();
    await updateNotify();
    return r;
  }
}