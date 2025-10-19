import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_client/ui/settings/view_models/settings_view_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin/plugin.dart';

class MockPlugin extends Mock implements Plugin {}

void main() {
  late MockPlugin mockPlugin;
  late SettingsViewModel settingsViewModel;

  setUp(() {
    mockPlugin = MockPlugin();
    settingsViewModel = SettingsViewModel.setMock(mockPlugin);
  });

  test('inicializa com plugin padrão', () {
    when(
      () => mockPlugin.startMobileHub(
        ipAddress: any(named: 'ipAddress'),
        port: any(named: 'port'),
      ),
    ).thenAnswer((_) async {});
    expect(() => SettingsViewModel(), returnsNormally);
  });

  test('inicia mobile hub sucesso', () async {
    when(
      () => mockPlugin.startMobileHub(
        ipAddress: any(named: 'ipAddress'),
        port: any(named: 'port'),
      ),
    ).thenAnswer((_) async {});
    var ipAddress = "123.123.123.0";
    var port = "8096";

    var result = await settingsViewModel.startMobileHub(ipAddress, port);

    expect(result, true);
    verify(
      () => mockPlugin.startMobileHub(ipAddress: ipAddress, port: 8096),
    ).called(1);
  });

  test('inicia mobile hub falha', () async {
    when(
      () => mockPlugin.startMobileHub(
        ipAddress: any(named: 'ipAddress'),
        port: any(named: 'port'),
      ),
    ).thenAnswer((_) async {});
    var ipAddress = "123.456.789.0";
    var port = "aaa";

    var result = await settingsViewModel.startMobileHub(ipAddress, port);

    expect(result, false);
    verifyNever(
      () => mockPlugin.startMobileHub(
        ipAddress: any(named: 'ipAddress'),
        port: any(named: 'port'),
      ),
    );
  });

  test('para o mobile hub', () async {
    when(() => mockPlugin.stopMobileHub()).thenAnswer((_) async {});
    settingsViewModel.stopMobileHub();

    verify(() => mockPlugin.stopMobileHub()).called(1);
  });
}
