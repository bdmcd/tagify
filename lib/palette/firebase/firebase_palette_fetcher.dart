import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:tagify/model/album.dart';
import 'package:tagify/model/palette.dart';
import 'package:tagify/palette/palette_fetcher.dart';
import 'package:tagify/player/connect.dart';
import 'package:tagify/spotify_api/spotify_globals.dart';

const _URL = 'https://us-central1-tagify-1d132.cloudfunctions.net/albumArtPalette?album={albumArt}';
const url = 'https://cdnb.artstation.com/p/assets/images/images/002/490/351/large/david-ardinaryas-lojaya-jon-bellion-front-cover-final-1.jpg?1466083884';

class FirebasePaletteFetcher extends PaletteFetcher {
  @override
  Future<Palette> getPalette(Album album) async {
    try {
      final response = await http.get(
        _URL.replaceAll('{albumArt}', album.albumArt),
        headers: {
          SpotifyAPI.AUTH_HEADER: "Bearer ${Connect.instance.token}"
        }
      );

      final data = json.decode(response.body);
      return _Helpers.paletteFromMap(data);      
    } on Exception catch(e) {
      print(e);
    }
    return null;
  }
}

class _Helpers {
  static Palette paletteFromMap(Map map) {
    return Palette(
      vibrant: colorFromHex(map['vibrant']),
      darkVibrant: colorFromHex(map['darkVibrant']),
      lightVibrant: colorFromHex(map['lightVibrant']),
      muted: colorFromHex(map['muted']),
      lightMuted: colorFromHex(map['lightMuted']),
      darkMuted: colorFromHex(map['darkMuted']),
    );
  }

  static Color colorFromHex(String hex) {
    return Color(int.parse(hex.replaceFirst("#", ""), radix: 16));
  }
}