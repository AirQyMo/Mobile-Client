import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plugin/plugin.dart';

class PermissionService {
  Future<PermissionStatus> requestLocation() => Permission.location.request();
  Future<bool> isNotificationDenied() => Permission.notification.isDenied;
  Future<PermissionStatus> requestNotification() =>
      Permission.notification.request();
}

class SettingsViewModel extends ChangeNotifier {
  final Plugin _plugin;
  final PermissionService _permissionService;

  SettingsViewModel()
    : _plugin = Plugin(),
      _permissionService = PermissionService();

  @visibleForTesting
  SettingsViewModel.setMock(this._plugin, this._permissionService);

  Future<({bool success, String message})> startMobileHub(
    String ipAddress,
    String port,
  ) async {
    try {
      var status = await _permissionService.requestLocation();
      if (!status.isGranted) {
        return (success: false, message: "Permissão de localização negada");
      }

      if (await _permissionService.isNotificationDenied()) {
        await _permissionService.requestNotification();
      }

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
