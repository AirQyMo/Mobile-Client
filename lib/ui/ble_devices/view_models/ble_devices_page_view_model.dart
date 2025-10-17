import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_client/mocks/mock_ble_service.dart';

class BleDevicesPageViewModel extends ChangeNotifier {
  final MockBleService _mockBleService = MockBleService();
  final List<Map<String, dynamic>> _discoveredDevices = [];
  StreamSubscription<Map<String, dynamic>>? _deviceSubscription;

  List<Map<String, dynamic>> get discoveredDevices =>
      List.unmodifiable(_discoveredDevices);

  void startDeviceDiscovery() {
    _deviceSubscription = _mockBleService.onBleDeviceDiscovered.listen((
      device,
    ) {
      final deviceId = device['id'] ?? device['address'];
      if (!_discoveredDevices.any(
        (d) => (d['id'] ?? d['address']) == deviceId,
      )) {
        _discoveredDevices.add(device);
        notifyListeners();
      }
    });

    _mockBleService.deviceDiscovery();
  }

  void stopDeviceDiscovery() {
    _deviceSubscription?.cancel();
    _deviceSubscription = null;
  }

  void clearDevices() {
    _discoveredDevices.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _deviceSubscription?.cancel();
    super.dispose();
  }
}
