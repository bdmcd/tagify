import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/core/controls/lib.dart' as c;
import 'package:tagify/core/text/label.dart';
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
                    return InkWell(
                      splashColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 8,
                          top: 14,
                          bottom: 14,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  LabelTitleSmall(text: track.name, overflow: TextOverflow.ellipsis),
                                  SizedBox(height: 6),
                                  LabelCaption(text: track.artist?.name, overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            c.IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
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