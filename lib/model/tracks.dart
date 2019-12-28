
import 'package:tagify/model/track.dart';
import 'package:tagify/player/library.dart';

class Tracks {
  static Tracks _instance;
  static Tracks get instance {
    _instance = _instance ?? new Tracks();
    return _instance;
  }

  final List<Track> tracks = [];

  Future<void> nextTracks() async {
    final block = await Library.instance.getNextTracks();
    if (block != null) {
      tracks.addAll(block);
    }
  }
}