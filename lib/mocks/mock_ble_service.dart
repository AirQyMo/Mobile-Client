import 'dart:async';
import 'dart:math';

class MockBleService {
  final StreamController<Map<String, dynamic>> _controller =
      StreamController.broadcast();

  Stream<Map<String, dynamic>> get onBleDeviceDiscovered => _controller.stream;

  void deviceDiscovery() {
    final mockDevices = [
      {
        'id': 'device_1',
        'name': 'iPhone 12',
        'address': '00:1A:2B:3C:4D:5E',
        'rssi': -45,
        'advertisementData': {'localName': 'iPhone 12'},
      },
      {
        'id': 'device_2',
        'name': 'Samsung Galaxy',
        'address': '00:1A:2B:3C:4D:5F',
        'rssi': -67,
        'advertisementData': {'localName': 'Galaxy S21'},
      },
      {
        'id': 'device_3',
        'name': 'AirPods',
        'address': '00:1A:2B:3C:4D:60',
        'rssi': -32,
        'advertisementData': {'localName': 'AirPods Pro'},
      },
    ];

    Timer.periodic(Duration(seconds: 0), (timer) {
      if (timer.tick <= mockDevices.length) {
        _controller.add(mockDevices[timer.tick - 1]);
      } else {
        timer.cancel();
      }
    });
  }

  void continuousDiscovery() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      final random = Random();
      final device = {
        'id': 'device_${random.nextInt(1000)}',
        'name': 'Random Device ${random.nextInt(100)}',
        'address': _generateRandomMac(),
        'rssi': -30 - random.nextInt(70),
        'advertisementData': {'localName': 'Mock Device'},
      };

      _controller.add(device);
    });
  }

  String _generateRandomMac() {
    final random = Random();
    return List.generate(
      6,
      (i) =>
          random.nextInt(256).toRadixString(16).padLeft(2, '0').toUpperCase(),
    ).join(':');
  }

  void dispose() {
    _controller.close();
  }
}
