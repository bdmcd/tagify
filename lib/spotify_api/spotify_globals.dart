class SpotifyAPI {
  static const String CLIENT_ID = 'c1e158e094a144d0b07143e38e0128cf';
  static const String REDIRECT_URI = 'https://localhost:8163';
  static const String AUTH_HEADER = 'Authorization';
  
  static const String API_URL = 'https://api.spotify.com/v1';
  static const String TRACKS = '$API_URL/me/tracks';
  static const String ALBUMS = '$API_URL/me/albums';
  static const String TRACK = '$API_URL/tracks/{id}';

  static String idFromUri(String uri) {
    return uri.substring(uri.lastIndexOf(":") + 1);
  }
}