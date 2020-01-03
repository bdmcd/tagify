import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/core/text/label.dart';
import 'package:tagify/core/theme.dart';
import 'package:tagify/model/now_playing.dart';
import 'package:tagify/vm/player_vm.dart';
import 'package:tagify/core/controls/lib.dart' as c;

class NowPlayingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TagifyTheme.of(context).background,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: _BackgroundAlbumArt(),
                  ),
                  _NowPlayingView(),
                ],
              ),
            )
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).viewPadding.top,
            child: _MirroredAlbumArt(
              scale: 1.0,
              imageAlignment: Alignment.topCenter,
            )
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  width: double.infinity,
                  color: TagifyTheme.of(context).background2.withOpacity(0.3),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).viewPadding.top,
                  ),
                )
              ),
            ),
          )
        ],
      )
    );
  }
}

class _NowPlayingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: _MirroredAlbumArt(),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                width: double.infinity,
                color: TagifyTheme.of(context).background2.withOpacity(0.5),
                child: _NowPlaying(),
              )
            ),
          ),
        ],
      ),
    );
  }
}

class _NowPlaying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48, top: 24),
      child: Column(
        children: <Widget>[
          //TODO: position status
          Consumer<NowPlayingVM>(
            builder: (context, nowPlaying, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    LabelTitle(
                      text: nowPlaying.track?.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    LabelSubtitle(
                      text: nowPlaying.track?.artist?.name,
                    )
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Consumer<ShuffleVM>(
                  builder: (context, shuffleVM, _) {
                    return c.IconButton(
                      icon: Icon(Icons.shuffle),
                      onPressed: shuffleVM.toggleShuffle,
                      highlighted: shuffleVM.isShuffling,
                    );
                  },
                ),
                c.IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: PlayerControls.of(context).previous,
                  iconSize: 48,
                ),
                Consumer<ResumePauseVM>(
                  builder: (context, resumePauseVM, _) {
                    return c.IconButton(
                      icon: Icon(resumePauseVM.isPaused ? Icons.play_circle_outline : Icons.pause_circle_outline),
                      onPressed: resumePauseVM.toggle,
                      iconSize: 64,
                    );
                  },
                ),
                c.IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: PlayerControls.of(context).next,
                  iconSize: 48,
                ),
                Consumer<RepeatModeVM>(
                  builder: (context, repeatModeVM, _) {
                    return c.IconButton(
                      icon: Icon(_getRepeatIcon(repeatModeVM)),
                      onPressed: repeatModeVM.toggleRepeat,
                      highlighted: repeatModeVM.repeatMode != RepeatMode.None,
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

IconData _getRepeatIcon(RepeatModeVM repeatModeVM) {
  switch (repeatModeVM.repeatMode) {
    case RepeatMode.None: return Icons.repeat;
    case RepeatMode.RepeatAll: return Icons.repeat;
    case RepeatMode.RepeatOne: return Icons.repeat_one;
    default: return Icons.repeat;
  }
}

class _BackgroundAlbumArt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.0,
      alignment: Alignment.center,
      child: Consumer<AlbumArtVM>(
        builder: (context, albumArtVM, _) {
          return _getImageWidget(albumArtVM);
        },
      ),
    );
  }
}

class _MirroredAlbumArt extends StatelessWidget {
  final double scale;
  final Alignment alignment;
  final Alignment imageAlignment;

  _MirroredAlbumArt({
    this.scale = 1.5,
    this.alignment = Alignment.topCenter,
    this.imageAlignment = Alignment.bottomCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: this.scale,
      alignment: this.alignment,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationX(math.pi),
        child: Consumer<AlbumArtVM>(
          builder: (context, albumArtVM, _) {
            return _getImageWidget(
              albumArtVM,
              alignment: this.imageAlignment,
            );
          }
        ),
      ),
    );
  }
}

Widget _getImageWidget(AlbumArtVM albumArtVM, { Alignment alignment = Alignment.center }) {
  if (albumArtVM.albumArt != null) {
    return Image.network(
      albumArtVM.albumArt,
      fit: BoxFit.cover,
      alignment: alignment
    );
  }
  return Container();
}