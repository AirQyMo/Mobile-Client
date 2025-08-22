import 'dart:async';

class MockMessageReceived {
  final StreamController<Map<String, dynamic>> _controller =
      StreamController.broadcast();

  Stream<Map<String, dynamic>> get onMessageReceived => _controller.stream;

  void receiveMessage() {
    final message = {
      "alert_id": "alert_1705312200000",
      "timestamp": "2024-01-15T10:30:00Z",
      "location": {
        "latitude": -23.5505,
        "longitude": -46.6333,
        "address": "Rio de Janeiro, RJ - Centro",
      },
      "risk_level": "moderate",
      "affected_diseases": [
        {
          "disease": "Asma",
          "pollutant": "PM2.5",
          "current_level": 45.2,
          "threshold": 35.4,
          "risk_factor": 1.28,
        },
      ],
      "recommendations": [
        "Evitar atividades físicas ao ar livre",
        "Manter janelas fechadas",
        "Usar máscara P2 se necessário",
      ],
    };

    Timer(Duration(seconds: 5), () {
      _controller.add(message);
    });
  }
}
