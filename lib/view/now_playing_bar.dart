import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/core/theme.dart';
import 'package:tagify/model/now_playing.dart';
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
                    Text(
                      nowPlaying.track.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      nowPlaying.track.artist.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle.copyWith(fontWeight: FontWeight.w300, fontSize: 14),
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

// class NowPlayingBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: PlayerVM.of(context).getNowPlaying(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Consumer<PlayerVM>(
//             builder: (context, player, _) {
//               final nowPlaying = player.nowPlaying;
//               return Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   splashColor: Colors.transparent,
//                   highlightColor: TagifyTheme.of(context).background,
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => NowPlayingView()
//                       )
//                     );
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       top: 16,
//                       bottom: 8,
//                       left: 8,
//                       right: 8
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         c.IconButton(
//                           icon: Icon(Icons.shuffle),
//                           onPressed: player.toggleShuffle,
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 4),
//                             child: Column(
//                               children: <Widget>[
                                // Text(
                                //   nowPlaying.track.name,
                                //   maxLines: 1,
                                //   overflow: TextOverflow.ellipsis,
                                //   style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.w400),
                                // ),
                                // SizedBox(height: 8,),
                                // Text(
                                //   nowPlaying.track.artist.name,
                                //   maxLines: 1,
                                //   overflow: TextOverflow.ellipsis,
                                //   style: Theme.of(context).textTheme.subtitle.copyWith(fontWeight: FontWeight.w300, fontSize: 14),
                                // )
//                               ],
//                             ),
//                           ),
//                         ),
//                         c.IconButton(
//                           icon: nowPlaying.isPaused ? Icon(Icons.play_circle_outline) : Icon(Icons.pause_circle_outline),
//                           iconSize: 32,
//                           onPressed: nowPlaying.isPaused ? player.resume : player.pause,
//                         )
//                       ],
//                     )
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//         return Container();
//       },
//     );
//   }
// }