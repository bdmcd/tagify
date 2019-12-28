
import 'package:tagify/model/album.dart';
import 'package:tagify/model/palette.dart';
import 'package:tagify/palette/firebase/firebase_palette_fetcher.dart';

abstract class PaletteFetcher {
  static PaletteFetcher _instance;

  static PaletteFetcher get instance {
    if (_instance == null) {
      _instance = FirebasePaletteFetcher();
    }

    return _instance;
  }

  Future<Palette> getPalette(Album album);
}