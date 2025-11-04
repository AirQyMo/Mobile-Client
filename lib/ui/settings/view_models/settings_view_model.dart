import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:plugin/plugin.dart';

class SettingsViewModel extends ChangeNotifier {
  final Plugin _plugin;

  SettingsViewModel() : _plugin = Plugin();

  @visibleForTesting
  SettingsViewModel.setMock(this._plugin);

  Future<({bool success, String message})> startMobileHub(
    String ipAddress,
    String port,
  ) async {
    try {
      RegExp exp = RegExp(
        r'\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b',
      );
      if (!exp.hasMatch(ipAddress)) {
        return (success: false, message: "Endereço de IP inválido");
      }

      var intPort = int.tryParse(port);
      if (intPort == null || intPort <= 0 || intPort >= 65535) {
        return (success: false, message: "Porta inválida");
      }

      await _plugin.startMobileHub(ipAddress: ipAddress, port: intPort);
      return (success: true, message: "Mobile Hub iniciado com sucesso");
    } catch (e) {
      log("$e");
      return (success: false, message: "Falha ao iniciar o Mobile Hub: $e");
    }
  }

  Future<({bool success, String message})> stopMobileHub() async {
    try {
      await _plugin.stopMobileHub();
      return (success: true, message: "Mobile Hub interrompido");
    } catch (e) {
      return (success: false, message: "Falha ao interromper o Mobile Hub: $e");
    }
  }
}
