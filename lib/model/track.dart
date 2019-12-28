
import 'package:tagify/model/album.dart';
import 'package:tagify/model/artist.dart';
import 'package:tagify/model/playable.dart';

class Track extends Playable {
  final String name;
  final Album album;
  final List<Artist> artists;
  final int duration;
  final bool explicit;
  final bool isLocal;

  Artist get artist => artists != null && artists.isNotEmpty ? artists[0] : null;

  Track({
    String uri,
    this.name,
    this.album,
    this.artists,
    this.duration,
    this.explicit,
    this.isLocal,
  }) : super(uri);

  Track copyWith({
    String uri,
    String name,
    Album album,
    List<Artist> artists,
    int duration,
    bool explicit,
    bool isLocal,
  }) => Track(
    uri: uri ?? this.uri,
    name: name ?? this.name,
    album: album ?? this.album,
    artists: artists ?? this.artists,
    duration: duration ?? this.duration,
    explicit: explicit ?? this.explicit,
    isLocal: isLocal ?? this.isLocal,
  );
}