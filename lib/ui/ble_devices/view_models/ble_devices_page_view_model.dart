import 'package:flutter/material.dart';
import 'package:plugin/plugin.dart';

class BleDevicesPageViewModel extends ChangeNotifier {
  final Plugin _plugin;
  final List<Map<dynamic, dynamic>> _devicesList = [];
  List<Map<dynamic, dynamic>> get devices => _devicesList;

  BleDevicesPageViewModel() : _plugin = Plugin() {
    _listenToBLEStreams();
  }

  @visibleForTesting
  BleDevicesPageViewModel.setMock(this._plugin) {
    _listenToBLEStreams();
    getBLEScanState();
  }

  void _listenToBLEStreams() {
    print('recebendo');
    _plugin.onBleDataReceived.listen((device) {
      print(device);
      _devicesList.add(device);
      notifyListeners();
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
