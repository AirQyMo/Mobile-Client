import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_client/ui/ble_devices/widgets/ble_device_banner.dart';

void main() {
  testWidgets('renderiza com mensagens definidas', (tester) async {
    const Map<String, dynamic> device = {
      "name": "dispositivo teste",
      "uuid": "uuid teste",
      "rssi": 10,
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: const BleDeviceBanner(device: device)),
      ),
    );

    expect(find.text('dispositivo teste'), findsOneWidget);
    expect(find.text('uuid teste'), findsOneWidget);
    expect(find.text('RSSI: 10'), findsOneWidget);
  });

  testWidgets('renderiza com mensagens vazias', (tester) async {
    const Map<dynamic, dynamic> device = {
      "name": null,
      "uuid": null,
      "rssi": 10,
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: const BleDeviceBanner(device: device)),
      ),
    );

    expect(find.text('Dispositivo sem nome'), findsOneWidget);
    expect(find.text('UUID desconhecido'), findsOneWidget);
    expect(find.text('RSSI: 10'), findsOneWidget);
  });
}
