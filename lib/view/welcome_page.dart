import 'package:flutter/material.dart';
import 'package:tagify/vm/connect_vm.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text("Connect with Spotify"),
            onPressed: () => ConnectVM.of(context).connect(),
          )
        ),
      ),
    );
  }
}