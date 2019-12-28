
import 'package:tagify/model/track.dart';
import 'package:tagify/player/library.dart';

class Albums {
  static Albums _instance;
  static Albums get instance {
    _instance = _instance ?? new Albums();
    return _instance;
  }

  final List<Track> tracks = [];

  Future<void> nextAlbums() async {
    final block = await Library.instance.getNextTracks();
    if (block != null) {
      tracks.addAll(block);
    }
  }
}