import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plugin/plugin.dart';

class HomePageViewModel extends ChangeNotifier {
  final List<Map<dynamic, dynamic>> _mensagens = [];
  List<Map<dynamic, dynamic>> get mensagens => List.unmodifiable(_mensagens);
  final Plugin _methodChannelPlugin;

  HomePageViewModel() : _methodChannelPlugin = Plugin() {
    _setupMessageListener();
  }

  @visibleForTesting
  HomePageViewModel.setMock(this._methodChannelPlugin) {
    _setupMessageListener();
  }

  _setupMessageListener() {
    _methodChannelPlugin.onMessageReceived.listen((novaMensagem) {
      var mensagemJson = jsonDecode(novaMensagem);
      _mensagens.insert(0, mensagemJson);
      notifyListeners();
    });
  }
}
