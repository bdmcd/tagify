import 'package:tagify/spotify_api/spotify_globals.dart';

class Playable {
  final String uri;

  String get id => SpotifyAPI.idFromUri(uri);

  Playable(this.uri);
}