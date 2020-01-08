import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/core/theme.dart';
import 'package:tagify/view/albums_view.dart';
import 'package:tagify/view/artists_view.dart';
import 'package:tagify/view/now_playing_bar.dart';
import 'package:tagify/view/tracks_view.dart';
import 'package:tagify/core/controls/lib.dart' as c;
import 'package:tagify/vm/player_vm.dart';

enum Page {
  tracks,
  albums,
  artists,
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TagifyTheme.of(context).background,
      body: FutureBuilder<bool>(
        future: NowPlayingVM.of(context).init(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<_MainPageState>(create: (_) => _MainPageState()),
              ],
              child: _MainPage(),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class _MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<_MainPageState>(
      builder: (context, state, _) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: Consumer<AlbumArtVM>(
                builder: (context, albumArtVM, _) {
                  return Image.network(
                    albumArtVM.albumArt,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Column(
              children: <Widget>[
                Expanded(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                      child: Container(
                        width: double.infinity,
                        color: TagifyTheme.of(context).background.withOpacity(0.85),
                        child: buildView(state)
                      )
                    ),
                  ),
                ),
                // _BottomBar(),
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      width: double.infinity,
                      color: TagifyTheme.of(context).background2.withOpacity(0.65),
                      child: _BottomBar()
                    )
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildView(_MainPageState state) {
    switch(state.currentPage) {
      case Page.tracks: return TracksView();
      case Page.albums: return AlbumsView();
      case Page.artists: return ArtistsView();
    }

    return Container();
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 2,
          width: double.infinity,
          color: TagifyTheme.of(context).tagifyDark,
        ),
        NowPlayingBar(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildBottomButton(
                context: context,
                page: Page.tracks,
                icon: Icon(Icons.music_note),
              ),
              buildBottomButton(
                context: context,
                page: Page.artists,
                icon: Icon(Icons.person),
              ),
              buildBottomButton(
                context: context,
                page: Page.albums,
                icon: Icon(Icons.album),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBottomButton({
    @required BuildContext context,
    Page page,
    Icon icon,
  }) {
    final state = Provider.of<_MainPageState>(context);
    return c.IconButton(
      icon: icon,
      highlighted: state.currentPage == page,
      onPressed: () => state.currentPage = page,
    );
  }
}

class _MainPageState extends ChangeNotifier {
  Page _currentPage = Page.tracks;

  Page get currentPage => _currentPage;
  set currentPage(Page page) {
    _currentPage = page;
    notifyListeners();
  }
}