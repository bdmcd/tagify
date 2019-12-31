
import 'package:spotify_playback/spotify_playback.dart';
import 'package:tagify/player/connect.dart';
import 'package:tagify/spotify_api/spotify_globals.dart';

class SpotifyWebConnect extends Connect {
  String _token;
  bool _connected = false;

  @override
  Future<bool> connect() async {
    try {
      final tok = await SpotifyPlayback.getAuthToken(
        SpotifyAPI.CLIENT_ID, 
        SpotifyAPI.REDIRECT_URI
      );

      if (tok != null && tok.isNotEmpty) {
        _token = tok;
        _connected = true;
      }
    } on Exception catch(e) {
      print(e);
    }

    return _connected;
  }

  @override
  String get token => _token;

  @override
  Future<bool> connected() async => _connected;
}