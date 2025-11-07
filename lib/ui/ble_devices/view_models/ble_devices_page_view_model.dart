import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plugin/plugin.dart';

class BleDevicesPageViewModel extends ChangeNotifier {
  final Plugin _plugin;
  final List<Map<dynamic, dynamic>> _devicesList = [];
  final List<String> _uuidList = [];
  List<Map<dynamic, dynamic>> get devices => _devicesList;

  BleDevicesPageViewModel() : _plugin = Plugin() {
    _listenToBLEStreams();
  }

  @visibleForTesting
  BleDevicesPageViewModel.setMock(this._plugin) {
    _listenToBLEStreams();
    getBLEScanState();
  }

  void _listenToBLEStreams() async {
    await _plugin.startListening();

    _plugin.onBleDataReceived.listen((device) {
      var uuid = device['uuid'];
      if (uuid != null && !_uuidList.contains(uuid)) {
        _devicesList.add(device);
        _uuidList.add(uuid);
        notifyListeners();
      }
    });
  }

  void getBLEScanState() {
    _plugin.onScanningStateChanged.listen((state) {
      print('estado de escaneamento: $state');
    });
  }

  Future<bool?> getMobileHubState() async {
    return await _plugin.isMobileHubStarted();
  }
}
