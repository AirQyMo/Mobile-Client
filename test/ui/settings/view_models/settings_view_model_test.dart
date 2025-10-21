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

    expect(result.success, true);
    expect(result.message, "Mobile Hub iniciado com sucesso");
    verify(
      () => mockPlugin.startMobileHub(ipAddress: ipAddress, port: 8096),
    ).called(1);
  });

  test('inicia mobile hub falha exceção', () async {
    when(
      () => mockPlugin.startMobileHub(
        ipAddress: any(named: 'ipAddress'),
        port: any(named: 'port'),
      ),
    ).thenThrow(Exception('teste'));
    var ipAddress = "123.123.123.0";
    var port = "8096";

    var result = await settingsViewModel.startMobileHub(ipAddress, port);

    expect(result.success, false);
    expect(result.message, "Falha ao iniciar o Mobile Hub: Exception: teste");
    verify(
      () => mockPlugin.startMobileHub(ipAddress: ipAddress, port: 8096),
    ).called(1);
  });

  group('ip errado', () {
    test('999.999.999.999', () async {
      when(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      ).thenAnswer((_) async {});
      var ipAddress = "999.999.999.999";
      var port = "aaa";

      var result = await settingsViewModel.startMobileHub(ipAddress, port);

      expect(result.success, false);
      expect(result.message, "Endereço de IP inválido");
      verifyNever(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      );
    });
    test('a', () async {
      when(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      ).thenAnswer((_) async {});
      var ipAddress = "a";
      var port = "aaa";

      var result = await settingsViewModel.startMobileHub(ipAddress, port);

      expect(result.success, false);
      expect(result.message, "Endereço de IP inválido");
      verifyNever(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      );
    });
    test('123', () async {
      when(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      ).thenAnswer((_) async {});
      var ipAddress = "123";
      var port = "aaa";

      var result = await settingsViewModel.startMobileHub(ipAddress, port);

      expect(result.success, false);
      expect(result.message, "Endereço de IP inválido");
      verifyNever(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      );
    });
  });

  group('port errado', () {
    test('aaa', () async {
      when(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      ).thenAnswer((_) async {});
      var ipAddress = "123.123.123.0";
      var port = "aaa";

      var result = await settingsViewModel.startMobileHub(ipAddress, port);

      expect(result.success, false);
      expect(result.message, "Porta inválida");
      verifyNever(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      );
    });
    test('-1', () async {
      when(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      ).thenAnswer((_) async {});
      var ipAddress = "123.123.123.0";
      var port = "-1";

      var result = await settingsViewModel.startMobileHub(ipAddress, port);

      expect(result.success, false);
      expect(result.message, "Porta inválida");
      verifyNever(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      );
    });
    test('999999999', () async {
      when(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      ).thenAnswer((_) async {});
      var ipAddress = "123.123.123.0";
      var port = "999999999";

      var result = await settingsViewModel.startMobileHub(ipAddress, port);

      expect(result.success, false);
      expect(result.message, "Porta inválida");
      verifyNever(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      );
    });
  });

  test('para o mobile hub sucesso', () async {
    when(() => mockPlugin.stopMobileHub()).thenAnswer((_) async {});
    settingsViewModel.stopMobileHub();

    verify(() => mockPlugin.stopMobileHub()).called(1);
  });

  test('para o mobile hub falha exceção', () async {
    when(() => mockPlugin.stopMobileHub()).thenThrow(Exception('teste'));
    var result = await settingsViewModel.stopMobileHub();

    expect(result.success, false);
    expect(
      result.message,
      "Falha ao interromper o Mobile Hub: Exception: teste",
    );
    verify(() => mockPlugin.stopMobileHub()).called(1);
  });
}
