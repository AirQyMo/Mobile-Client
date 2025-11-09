import 'package:flutter/material.dart';
import 'package:mobile_client/ui/settings/view_models/settings_view_model.dart';
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
  }

  void _listenToBLEStreams() {
    _plugin.onBleDataReceived.listen((device) {
      var uuid = device['uuid'];
      if (uuid != null && !_uuidList.contains(uuid)) {
        _devicesList.add(device);
        _uuidList.add(uuid);
        notifyListeners();
      }
    });
  }

  bool getMobileHubState() {
    return SettingsViewModel().isMobileHubStarted;
  }
}
