import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/vm/player_vm.dart';
import 'package:tagify/vm/tracks_vm.dart';

class TracksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<TracksVM>(
        builder: (context, tracksVM, _){
          final tracks = tracksVM.tracks;

          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: tracks.length,
                  itemBuilder: (context, index) {
                    if (index == tracks.length - 50) {
                      tracksVM.nextBlock();
                    }

                    final track = tracks[index];
                    return ListTile(
                      title: Text(track.name),
                      onTap: () => PlayerControls.of(context).play(track),
                      onLongPress: () => PlayerControls.of(context).queue(track),
                    );
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}