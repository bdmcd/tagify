import 'package:tagify/model/album.dart';
import 'package:tagify/model/track.dart';
import 'package:tagify/player/library.dart';
import 'package:tagify/player/spotify_web/spotify_web_library.dart';

class SpotifyLibrary extends Library {
  var _web = new SpotifyWebLibrary();

  @override
  Future<List<Track>> getTracks() async {
    return await _web.getTracks();
  }

  @override
  Future<List<Track>> getNextTracks({ var offset }) async {
    return await _web.getNextTracks(offset: offset);
  }

  @override
  Future<List<Album>> getAlbums() async {
    return await _web.getAlbums();
  }

  @override
  Future<List<Album>> getNextAlbums({ var offset }) async {
    return await _web.getNextAlbums(offset: offset);
  }

  @override
  Future<Track> getTrack(String trackId) async {
    return await _web.getTrack(trackId);
  }

  @override
  Future<Album> getAlbum(String albumId) async {
    return await _web.getAlbum(albumId);
  }
}