
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:tagify/model/album.dart';
import 'package:tagify/model/artist.dart';
import 'package:tagify/model/track.dart';
import 'package:tagify/player/connect.dart';
import 'package:tagify/player/library.dart';
import 'package:tagify/spotify_api/spotify_globals.dart';

class SpotifyWebLibrary extends Library {
  static final int _limit = 50;

  static final String _origTrackUrl = SpotifyAPI.TRACKS + "?limit=$_limit";
  String _trackUrl = _origTrackUrl;

  static final String _origAlbumUrl = SpotifyAPI.ALBUMS + "?limit=$_limit";
  String _albumUrl = _origAlbumUrl;

  @override
  Future<List<Track>> getTracks() async {
    _trackUrl = SpotifyAPI.TRACKS;
    return await getNextTracks();
  }

  @override
  Future<List<Track>> getNextTracks({var offset}) async {
    if (_trackUrl == null) {
      return null;
    }
    
    final response = await http.get(
      _trackUrl, headers: {
        SpotifyAPI.AUTH_HEADER: 'Bearer ${Connect.instance.token}'
      }
    );

    final data = json.decode(response.body);
    final List trackData = data['items'];
    final List<Track> tracks = [];
    _trackUrl = data['next'];

    trackData.forEach((t) {
      tracks.add(_Helpers.trackFromMap(t['track']));
    });

    return tracks;
  }

  @override
  Future<List<Album>> getAlbums() async {
    _albumUrl = SpotifyAPI.ALBUMS;
    return await getNextAlbums();
  }

  @override
  Future<List<Album>> getNextAlbums({ var offset }) async {
    if (_albumUrl == null) {
      return null;
    }
    
    final response = await http.get(
      _albumUrl, headers: {
        SpotifyAPI.AUTH_HEADER: 'Bearer ${Connect.instance.token}'
      }
    );

    final data = json.decode(response.body);
    final List albumData = data['items'];
    final List<Album> albums = [];
    _albumUrl = data['next'];

    albumData.forEach((t) {
      albums.add(_Helpers.albumFromMap(t['track']));
    });

    return albums;
  }

  @override
  Future<Track> getTrack(String trackId) async {
    try {
      final response = await http.get(
        SpotifyAPI.TRACK.replaceAll('{id}', trackId),
        headers: {
          SpotifyAPI.AUTH_HEADER: "Bearer ${Connect.instance.token}"
        }
      );

      final data = json.decode(response.body);
      return _Helpers.trackFromMap(data);
      
    } on Exception catch(e) {
      print(e);
    }
    return null;
  }

  Future<Album> getAlbum(String albumId) async {
    try {
      final response = await http.get(
        SpotifyAPI.ALBUM.replaceAll("{id}", albumId),
        headers: {
          SpotifyAPI.AUTH_HEADER: "Bearer ${Connect.instance.token}"
        }
      );

      final data = json.decode(response.body);
      return _Helpers.albumFromMap(data);
    } on Exception catch(e) {
      print(e);
    }
    return null;
  }
}

class _Helpers {
  static Album albumFromMap(Map map) => Album(
    uri: map['uri'],
    name: map['name'],
    artists: artistsFromList(map['artists']),
    albumArt: map['images'][0]['url'] //TODO: get all sizes of album art
  );

  static Track trackFromMap(Map map) => Track(
    uri: map['uri'],
    name: map['name'],
    album: albumFromMap(map['album']),
    artists: artistsFromList(map['artists']),
    duration: map['duration_ms'],
    explicit: map['explicit'],
    isLocal: map['is_local'],
  );

  static List<Artist> artistsFromList(List list) {
    List<Artist> artists = [];
    list.forEach((a) {
      artists.add(Artist(
        uri: a['uri'],
        name: a['name'],
      ));
    });
    return artists;
  }
}