import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/core/theme.dart';
import 'package:tagify/player/player.dart';
import 'package:tagify/view/main_page.dart';
import 'package:tagify/view/welcome_page.dart';
import 'package:tagify/vm/connect_vm.dart';
import 'package:tagify/vm/player_vm.dart';
import 'package:tagify/vm/tracks_vm.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectVM(),),
        ChangeNotifierProvider(create: (_) => TagifyTheme(),),
      ],
      child: ConnectControllerView(),
    );
  }
}

class ConnectControllerView extends StatefulWidget {
  @override
  _ConnectControllerViewState createState() => _ConnectControllerViewState();
}

class _ConnectControllerViewState extends State<ConnectControllerView> {
  int counter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Player.instance.pause();
    super.dispose();
  }

  void increment() => setState(() => counter++);

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectVM>(
      builder: (context, connect, _) {
        return FutureBuilder<bool>(
          future: connect.connected(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                return MainApp(
                  home: MainPage(),
                  providers: [
                    ChangeNotifierProvider<TracksVM>(create: (_) => TracksVM()),
                    ChangeNotifierProvider<ShuffleVM>(create: (_) => ShuffleVM()),
                    ChangeNotifierProvider<RepeatModeVM>(create: (_) => RepeatModeVM()),
                    ChangeNotifierProvider<ResumePauseVM>(create: (_) => ResumePauseVM()),
                    ChangeNotifierProvider<NowPlayingVM>(create: (_) => NowPlayingVM()),
                    ChangeNotifierProvider<AlbumArtVM>(create: (_) => AlbumArtVM()),
                    ChangeNotifierProvider<PlayerControls>(create: (_) => PlayerControls()),
                  ],
                );
              }
              return MainApp(
                home: WelcomePage(),
              );
            }
            return MainApp(
              home: Container(),
            );
          },
        );
      },
    );
  }
}

class MainApp extends StatelessWidget {
  final List<InheritedProvider> providers;
  final Widget home;

  MainApp({
    this.providers,
    this.home,
  });

  @override
  Widget build(BuildContext context) {
    if (providers == null || providers.isEmpty) {
      return MaterialApp(
        home: this.home
      );
    }
    return MultiProvider(
      providers: this.providers ?? [],
      child: MaterialApp(
        home: this.home,
      )
    );
  }
}