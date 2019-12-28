
import 'package:spotify_playback/spotify_playback.dart';
import 'package:tagify/player/connect.dart';
import 'package:tagify/player/spotify_web/spotify_web_connect.dart';
import 'package:tagify/spotify_api/spotify_globals.dart';

class SpotifyConnect extends Connect {
  var _web = SpotifyWebConnect();

  @override
  Future<bool> connect() async {
    if (!await _web.connect()) {
      return false;
    }

    try {
      await SpotifyPlayback.spotifyConnect(
        clientId: SpotifyAPI.CLIENT_ID,
        redirectUrl: SpotifyAPI.REDIRECT_URI
      );
    } on Exception catch(e) {
      print(e);
    }
    
    return await SpotifyPlayback.isConnected();
  }

  @override
  String get token => _web.token;

  @override
  Future<bool> connected() async => await SpotifyPlayback.isConnected();
}