import 'dart:async';

import 'package:plugin/plugin.dart';

class BleDevicesService {
  static final BleDevicesService _instance = BleDevicesService._internal();
  factory BleDevicesService() => _instance;
  BleDevicesService._internal() : _plugin = Plugin();

  final Plugin _plugin;

  final List<Map<dynamic, dynamic>> _devicesList = [];
  final List<String> _uuidList = [];

  List<Map<dynamic, dynamic>> get devices => _devicesList;

  final _streamController =
      StreamController<List<Map<dynamic, dynamic>>>.broadcast();
  Stream<List<Map<dynamic, dynamic>>> get stream => _streamController.stream;

  StreamSubscription? _streamSubscription;

  void listenToBLEStreams() {
    _streamSubscription = _plugin.onBleDataReceived.listen((device) {
      var uuid = device['uuid'];

      if (uuid != null && !_uuidList.contains(uuid)) {
        _devicesList.add(device);
        _uuidList.add(uuid);
      }
    });
  }

  void stopListeningToBLEStreams() {
    _plugin.stopListening();
    _streamSubscription?.cancel();
    _streamSubscription = null;
  }
}
