

import 'package:tagify/player/impl.dart';
import 'package:tagify/player/spotify/spotify_connect.dart';
import 'package:tagify/player/spotify_web/spotify_web_connect.dart';

abstract class Connect {
  static Connect _instance;

  static Connect get instance {
    if (_instance == null) {
      switch(Implementation.impl) {
        case Impl.spotify: 
          _instance = new SpotifyConnect();
          break;
        case Impl.spotifyWeb:
          _instance = new SpotifyWebConnect();
          break;
      }
    }

    return _instance;
  }

  String get token;
  Future<bool> connect();
  Future<bool> connected();
}