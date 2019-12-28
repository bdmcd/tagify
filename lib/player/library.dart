
import 'package:tagify/model/album.dart';
import 'package:tagify/model/track.dart';
import 'package:tagify/player/impl.dart';
import 'package:tagify/player/spotify/spotify_library.dart';
import 'package:tagify/player/spotify_web/spotify_web_library.dart';

abstract class Library {
  static Library _instance;

  static Library get instance {
    if (_instance == null) {
      switch(Implementation.impl) {
        case Impl.spotify: 
          _instance = new SpotifyLibrary();
          break;
        case Impl.spotifyWeb:
          _instance = new SpotifyWebLibrary();
          break;
      }
    }

    return _instance;
  }

  Future<List<Track>> getTracks();
  Future<List<Track>> getNextTracks({ var offset });

  Future<List<Album>> getAlbums();
  Future<List<Album>> getNextAlbums({ var offset });

  Future<Track> getTrack(String uri);
}