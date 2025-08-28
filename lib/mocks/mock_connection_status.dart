import 'dart:async';

class MockConnectionStatus {
  final StreamController<String> _controller = StreamController.broadcast();

  Stream<String> get onConnectionStatusChanged => _controller.stream;

  void connectionCycle() {
    _controller.add('DISCONNECTED');
    Timer(Duration(seconds: 0), () {
      _controller.add('CONNECTED');
    });
  }

  void dispose() {
    _controller.close();
  }
}
