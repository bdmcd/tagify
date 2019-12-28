
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/player/connect.dart';

class ConnectVM extends ChangeNotifier {
  static ConnectVM of(BuildContext context) => Provider.of<ConnectVM>(context);

  Future<bool> connected() async {
    return await Connect.instance.connected();
  }

  Future<bool> connect() async {
    final success = await Connect.instance.connect();
    notifyListeners();
    return success;
  }
}