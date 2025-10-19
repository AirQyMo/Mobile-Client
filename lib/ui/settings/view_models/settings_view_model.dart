import 'package:flutter/material.dart';
import 'package:plugin/plugin.dart';

class SettingsViewModel extends ChangeNotifier {
  final Plugin _plugin;

  SettingsViewModel() : _plugin = Plugin();

  @visibleForTesting
  SettingsViewModel.setMock(this._plugin);

  Future<bool> startMobileHub(String ipAddress, String port) async {
    RegExp exp = RegExp(
      r'\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b',
    );

    if (!exp.hasMatch(ipAddress)) {
      return false;
    }

    var intPort = int.tryParse(port);

    if (intPort == null) {
      return false;
    }

    _plugin.startMobileHub(ipAddress: ipAddress, port: intPort);
    return true;
  }

  Future<void> stopMobileHub() async {
    _plugin.stopMobileHub();
  }
}
