import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/core/theme.dart';
import 'package:tagify/model/now_playing.dart';
import 'package:tagify/vm/player_vm.dart';
import 'package:tagify/core/controls/lib.dart' as c;

class NowPlayingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TagifyTheme.of(context).background2,
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Transform.scale(
                scale: 1.1,
                alignment: Alignment.center,
                child:       Consumer<PlayerVM>(
                  builder: (context, player, _) {
                    return _getImageWidget(
                      player,
                    );
                  },
                ),
              ),
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Transform.scale(
                      scale: 1.5,
                      alignment: Alignment.topCenter,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationX(math.pi),
                        child: Consumer<PlayerVM>(
                          builder: (context, player, _) {
                            return _getImageWidget(
                              player,
                              alignment: Alignment.bottomCenter,
                            );
                          }
                        ),
                      ),
                    )
                  ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        color: TagifyTheme.of(context).background2.withOpacity(0.65),
                        child: _NowPlaying()
                      )
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}

class _NowPlaying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerVM>(
      builder: (context, player, _) {
        final nowPlaying = player.nowPlaying;
        return Padding(
          padding: const EdgeInsets.only(bottom: 48),
          child: Column(
            children: <Widget>[
              Consumer<TagifyTheme>(
                builder: (context, _, __) => Stack(
                  children: <Widget>[
                    Container(
                      height: 3,
                      color: TagifyTheme.of(context).tagify.withOpacity(0.3),
                    ),
                    Container(
                      height: 3,
                      width: 134,
                      color: TagifyTheme.of(context).tagify,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "0:30",
                      style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "3:43",
                      style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    nowPlaying.track.name,
                    style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.w400, fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${nowPlaying.track.artist.name}',
                    style: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.w300),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    c.IconButton(
                      icon: Icon(Icons.shuffle),
                      onPressed: player.toggleShuffle,
                      highlightedColor: TagifyTheme.of(context).tagifyDark,
                      highlighted: nowPlaying.isShuffling,
                    ),
                    c.IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: player.previous,
                      iconSize: 48,
                    ),
                    c.IconButton(
                      icon: Icon(nowPlaying.isPaused ? Icons.play_circle_outline : Icons.pause_circle_outline),
                      onPressed: nowPlaying.isPaused ? player.resume : player.pause,
                      iconSize: 64,
                    ),
                    c.IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: player.next,
                      iconSize: 48,
                    ),
                    c.IconButton(
                      icon: Icon(nowPlaying.repeatMode == RepeatMode.RepeatOne ? Icons.repeat_one : Icons.repeat),
                      highlighted: nowPlaying.repeatMode != RepeatMode.None,
                      highlightedColor: TagifyTheme.of(context).tagifyDark,
                      onPressed: player.toggleRepeat,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

Widget _getImageWidget(PlayerVM player, { Alignment alignment = Alignment.center }) {
  if (player.nowPlaying != null && player.nowPlaying.track.album != null && player.nowPlaying.track.album.albumArt != null) {
    return Image.network(
      player.nowPlaying.track.album.albumArt,
      fit: BoxFit.cover,
      alignment: alignment
    );
  }
  return Container();
}