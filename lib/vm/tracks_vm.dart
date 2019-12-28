
import 'package:flutter/material.dart';
import 'package:tagify/model/track.dart';
import 'package:tagify/model/tracks.dart';
import 'package:provider/provider.dart';

class TracksVM extends ChangeNotifier {
  static TracksVM of(BuildContext context) => Provider.of<TracksVM>(context);

  TracksVM() {
    if (Tracks.instance.tracks.isEmpty) {
      nextBlock();
    }
  }

  List<Track> get tracks => Tracks.instance.tracks;

  nextBlock() async {
    await Tracks.instance.nextTracks();

    notifyListeners();
  }
}