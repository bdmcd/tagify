import 'package:tagify/spotify_api/spotify_globals.dart';

class Playable {
  final String uri;

  String get id => SpotifyAPI.idFromUri(uri);

  Playable(this.uri);

  @override
  bool operator ==(o) => o is Playable && o.uri == uri;

  @override
  int get hashCode => uri.hashCode + id.hashCode;
}