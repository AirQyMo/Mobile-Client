import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_client/mocks/mock_connection_status.dart';

class HomePageViewModel extends ChangeNotifier {
  final MockConnectionStatus _mockConnectionStatus = MockConnectionStatus();
  StreamSubscription<String>? _streamSubscription;
  String _connectionStatus = "DISCONNECTED";

  String get connectionStatus => _connectionStatus;

  void startConnectionStatus() {
    _mockConnectionStatus.connectionCycle();
    notifyListeners();
    _streamSubscription = _mockConnectionStatus.onConnectionStatusChanged
        .listen((status) {
          _connectionStatus = status;
          notifyListeners();
        });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
