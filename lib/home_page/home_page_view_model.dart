import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_client/mocks/mock_connection_status.dart';
import 'package:mobile_client/mocks/mock_message_received.dart';

class HomePageViewModel extends ChangeNotifier {
  final MockConnectionStatus _mockConnectionStatus = MockConnectionStatus();
  StreamSubscription<String>? statusStreamSubscription;
  String _connectionStatus = "DISCONNECTED";

  final MockMessageReceived _mockMessageReceived = MockMessageReceived();
  StreamSubscription<Map<String, dynamic>>? messageStreamSubscription;
  Map<String, dynamic> _message = {};

  String get connectionStatus => _connectionStatus;
  Map<String, dynamic> get message => _message;

  void startConnectionStatus() {
    _mockConnectionStatus.connectionCycle();
    notifyListeners();
    statusStreamSubscription = _mockConnectionStatus.onConnectionStatusChanged
        .listen((status) {
          _connectionStatus = status;
          notifyListeners();
        });
  }

  void receiveMessage() {
    _mockMessageReceived.receiveMessage();
    notifyListeners();
    messageStreamSubscription = _mockMessageReceived.onMessageReceived.listen((
      message,
    ) {
      _message = message;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    statusStreamSubscription?.cancel();
    messageStreamSubscription?.cancel();
    super.dispose();
  }
}
