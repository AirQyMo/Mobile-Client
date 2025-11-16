import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_client/core/message_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plugin/plugin.dart';

class PermissionService {
  Future<PermissionStatus> requestLocation() => Permission.location.request();
  Future<bool> isNotificationDenied() => Permission.notification.isDenied;
  Future<PermissionStatus> requestNotification() =>
      Permission.notification.request();
}

class SettingsViewModel extends ChangeNotifier {
  static final SettingsViewModel _instance = SettingsViewModel._internal();
  factory SettingsViewModel() => _instance;
  SettingsViewModel._internal()
    : _plugin = Plugin(),
      _permissionService = PermissionService(),
      _messageService = MessageService() {
    _checkMobileHubStatus();
  }

  String ipAddress = '';
  String port = '';

  final Plugin _plugin;
  final PermissionService _permissionService;
  final MessageService _messageService;

  bool _isMobileHubStarted = false;
  bool get isMobileHubStarted => _isMobileHubStarted;

  Timer? _contextUpdatesTimer;

  @visibleForTesting
  SettingsViewModel.setMock(
    this._plugin,
    this._permissionService,
    this._messageService,
  );

  Future<void> _checkMobileHubStatus() async {
    _isMobileHubStarted = await _plugin.isMobileHubStarted() ?? false;
    notifyListeners();
  }

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
      await _checkMobileHubStatus();
      await _plugin.startListening();
      await _sendContextUpdates();
      _messageService.startListening();
      return (success: true, message: "Mobile Hub iniciado com sucesso");
    } catch (e) {
      log("$e");
      return (success: false, message: "Falha ao iniciar o Mobile Hub: $e");
    }
  }

  Future<({bool success, String message})> stopMobileHub() async {
    try {
      await _stopPeriodicUpdates();
      await _plugin.stopMobileHub();
      await _checkMobileHubStatus();
      await _plugin.stopListening();
      _messageService.stopListening();
      return (success: true, message: "Mobile Hub interrompido");
    } catch (e) {
      return (success: false, message: "Falha ao interromper o Mobile Hub: $e");
    }
  }

  Future<void> _sendContextUpdates() async {
    _contextUpdatesTimer = Timer.periodic(const Duration(seconds: 10), (
      _,
    ) async {
      List<String> uuid = ['e534231f-0734-45aa-b97b-b6bc613c0759'];
      await _plugin.updateContext(devices: uuid);
    });
  }

  Future<void> _stopPeriodicUpdates() async {
    _contextUpdatesTimer?.cancel();
    _contextUpdatesTimer = null;

    return Future.value();
  }
}
