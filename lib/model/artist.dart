
import 'package:tagify/model/playable.dart';

class Artist extends Playable {
  final String name;

  Artist({
    String uri,
    this.name,
  }) : super(uri);
}