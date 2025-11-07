import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:plugin/plugin.dart';

class HomePageViewModel extends ChangeNotifier {
  final List<Map<dynamic, dynamic>> _mensagens = [];
  List<Map<dynamic, dynamic>> get mensagens => List.unmodifiable(_mensagens);
  final Plugin _plugin;

  HomePageViewModel() : _plugin = Plugin() {
    Future.microtask(init);
  }

  @visibleForTesting
  HomePageViewModel.setMock(this._plugin) {
    Future.microtask(init);
  }

  Future<bool?> isMobileHubStarted() async {
    return await _plugin.isMobileHubStarted();
  }

  void init() async {
    final mobileHubStarted = await isMobileHubStarted();
    if (mobileHubStarted != null && mobileHubStarted) {
      _setupMessageListener();
    }
  }

  void _setupMessageListener() {
    _plugin.onMessageReceived.listen((novaMensagem) {
      log('recebeu alerta');
      var mensagemJson = jsonDecode(novaMensagem);
      _mensagens.insert(0, mensagemJson);
      notifyListeners();
    });
  }
}
