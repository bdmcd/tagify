import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/core/text/label.dart';
import 'package:tagify/core/theme.dart';
import 'package:tagify/view/now_playing_view.dart';
import 'package:tagify/vm/player_vm.dart';
import 'package:tagify/core/controls/lib.dart' as c;

class NowPlayingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: TagifyTheme.of(context).background,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NowPlayingView(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 8,
            left: 8,
            right: 8,
          ),
          child: _NowPlayingBar(),
        )
      ),
    );
  }
}

class _NowPlayingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Consumer<ShuffleVM>(
          builder: (context, shuffle, _) {
            return c.IconButton(
              icon: Icon(Icons.shuffle),
              highlighted: shuffle.isShuffling,
              onPressed: shuffle.toggleShuffle,
            );
          },
        ),
        Consumer<NowPlayingVM>(
          builder: (context, nowPlaying, _) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: <Widget>[
                    LabelTitle(
                      text: nowPlaying.track.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    LabelSubtitle(
                      text: nowPlaying.track.artist.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                )
              ),
            );
          },
        ),
        Consumer<ResumePauseVM>(
          builder: (context, rp, _) {
            return c.IconButton(
              iconSize: 32,
              icon: Icon(rp.isPaused ? Icons.play_circle_outline : Icons.pause_circle_outline),
              onPressed: rp.toggle,
            );
          },
        )
      ],
    );
  }
}
