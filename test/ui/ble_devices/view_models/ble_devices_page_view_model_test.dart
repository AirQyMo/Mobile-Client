import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_client/ui/ble_devices/view_models/ble_devices_page_view_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin/plugin.dart';

class MockPlugin extends Mock implements Plugin {}

void main() {
  late MockPlugin mockPlugin;
  late BleDevicesPageViewModel bleDevicesPageViewModel;
  late StreamController<Map<String, dynamic>> streamController;

  setUp(() {
    mockPlugin = MockPlugin();
    streamController = StreamController<Map<String, dynamic>>();

    when(
      () => mockPlugin.onBleDataReceived,
    ).thenAnswer((_) => streamController.stream);
    when(() => mockPlugin.startListening()).thenAnswer((_) async {});

    bleDevicesPageViewModel = BleDevicesPageViewModel.setMock(mockPlugin);
  });
  tearDown(() => streamController.close());

  test('recebe os dispositivos ble e coloca na lista', () async {
    const device = {
      "name": "nome do dispositivo",
      "uuid": "aaaa0000",
      "rssi": 1,
    };

    streamController.add(device);
    await Future(() {});

    expect(bleDevicesPageViewModel.devices, hasLength(1));
    expect(bleDevicesPageViewModel.devices.first, device);
  });
}
