import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_client/ui/settings/view_models/settings_view_model.dart';
import 'package:plugin/plugin.dart';

class HomePageViewModel extends ChangeNotifier {
  final List<Map<dynamic, dynamic>> _mensagens = [];
  List<Map<dynamic, dynamic>> get mensagens => List.unmodifiable(_mensagens);
  final Plugin _plugin;
  StreamSubscription? _streamSubscription;

  bool _isMobileHubStarted = false;
  bool get isMobileHubStarted => _isMobileHubStarted;

  HomePageViewModel() : _plugin = Plugin() {
    Future.microtask(init);
  }

  @visibleForTesting
  HomePageViewModel.setMock(this._plugin) {
    Future.microtask(init);
  }

  void init() async {
    _isMobileHubStarted = SettingsViewModel().isMobileHubStarted;

    if (_isMobileHubStarted) {
      _setupMessageListener();
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void _setupMessageListener() {
    _streamSubscription = _plugin.onMessageReceived.listen((novaMensagem) {
      log('recebeu alerta');
      var mensagemJson = jsonDecode(novaMensagem);
      _mensagens.insert(0, mensagemJson);
      notifyListeners();
    });
  }

  void refreshMobileHubState() {
    _isMobileHubStarted = SettingsViewModel().isMobileHubStarted;
    notifyListeners();
  }
}
