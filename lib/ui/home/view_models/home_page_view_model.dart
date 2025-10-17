import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plugin/plugin_method_channel.dart';

class HomePageViewModel extends ChangeNotifier {
  final List<Map<dynamic, dynamic>> _mensagens = [];
  List<Map<dynamic, dynamic>> get mensagens => List.unmodifiable(_mensagens);
  final MethodChannelPlugin _methodChannelPlugin;

  HomePageViewModel() : _methodChannelPlugin = MethodChannelPlugin() {
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
