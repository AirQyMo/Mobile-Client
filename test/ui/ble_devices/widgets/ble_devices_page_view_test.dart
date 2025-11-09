import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_client/ui/ble_devices/view_models/ble_devices_page_view_model.dart';
import 'package:mobile_client/ui/ble_devices/widgets/ble_devices_page_view.dart';
import 'package:mocktail/mocktail.dart';

class MockBleDevicesViewModel extends Mock implements BleDevicesPageViewModel {}

void main() {
  late MockBleDevicesViewModel mockBleDevicesViewModel;

  setUp(() {
    mockBleDevicesViewModel = MockBleDevicesViewModel();
  });

  testWidgets('carrega a lista de dispositivos', (tester) async {
    const Map<String, dynamic> device = {
      "name": "dispositivo teste",
      "uuid": "uuid teste",
      "rssi": 10,
    };
    when(() => mockBleDevicesViewModel.devices).thenReturn([device]);

    await tester.pumpWidget(
      MaterialApp(
        home: BleDevicesPageView(
          bleDevicesPageViewModel: mockBleDevicesViewModel,
        ),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);
  });
}
