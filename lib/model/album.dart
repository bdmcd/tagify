
import 'package:tagify/model/artist.dart';
import 'package:tagify/model/playable.dart';

class Album extends Playable {
  final String name;
  final List<Artist> artists;
  final String albumArt;

  Album({
    String uri,
    this.name,
    this.artists,
    this.albumArt,
  }) : super(uri);

  Album copyWith({
    String uri,
    String name,
    List<Artist> artists,
    String albumArt,
  }) => Album(
    uri: uri ?? this.uri,
    name: name ?? this.name,
    artists: artists ?? this.artists,
    albumArt: albumArt ?? this.albumArt,
  );
}