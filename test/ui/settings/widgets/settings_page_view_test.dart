import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_client/ui/settings/view_models/settings_view_model.dart';
import 'package:mobile_client/ui/settings/widgets/settings_page_view.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plugin/plugin.dart';

class MockPlugin extends Mock implements Plugin {}

class MockPermissionService extends Mock implements PermissionService {}

void main() {
  late SettingsViewModel settingsViewModel;
  late MockPlugin mockPlugin;
  late MockPermissionService mockPermissionService;

  setUp(() {
    mockPlugin = MockPlugin();
    mockPermissionService = MockPermissionService();
    settingsViewModel = SettingsViewModel.setMock(
      mockPlugin,
      mockPermissionService,
    );
  });

  group('inicia o mobile hub', () {
    setUp(() {
      when(
        () => mockPermissionService.requestLocation(),
      ).thenAnswer((_) async => PermissionStatus.granted);
      when(
        () => mockPermissionService.isNotificationDenied(),
      ).thenAnswer((_) async => true);
      when(
        () => mockPermissionService.requestNotification(),
      ).thenAnswer((_) async => PermissionStatus.granted);
    });
    testWidgets('sucesso', (tester) async {
      var ipAddress = "123.123.123.0";
      var port = "8096";
      when(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      ).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsPageView(settingsViewModel: settingsViewModel),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, ipAddress);
      await tester.enterText(find.byType(TextField).last, port);
      await tester.tap(find.byType(ElevatedButton).first);

      await tester.pumpAndSettle();

      verify(() => settingsViewModel.startMobileHub(ipAddress, port)).called(1);
      expect(find.byType(SnackBar), findsOneWidget);
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.backgroundColor, Colors.green);
      expect(find.text('Mobile Hub iniciado com sucesso'), findsOneWidget);
    });

    testWidgets('endereço de ip inválido', (tester) async {
      var ipAddress = "999.999.999.999";
      var port = "8096";

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsPageView(settingsViewModel: settingsViewModel),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, ipAddress);
      await tester.enterText(find.byType(TextField).last, port);
      await tester.tap(find.byType(ElevatedButton).first);

      await tester.pumpAndSettle();

      verify(() => settingsViewModel.startMobileHub(ipAddress, port)).called(1);
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(find.byType(SnackBar), findsOneWidget);
      expect(snackBar.backgroundColor, Colors.red);
      expect(find.text('Endereço de IP inválido'), findsOneWidget);
    });

    testWidgets('porta inválida', (tester) async {
      var ipAddress = "123.123.123.123";
      var port = "-1";
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsPageView(settingsViewModel: settingsViewModel),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, ipAddress);
      await tester.enterText(find.byType(TextField).last, port);
      await tester.tap(find.byType(ElevatedButton).first);

      await tester.pumpAndSettle();

      verify(() => settingsViewModel.startMobileHub(ipAddress, port)).called(1);
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(find.byType(SnackBar), findsOneWidget);
      expect(snackBar.backgroundColor, Colors.red);
      expect(find.text('Porta inválida'), findsOneWidget);
    });

    testWidgets('erro exceção', (tester) async {
      var ipAddress = "123.123.123.0";
      var port = "8096";
      when(
        () => mockPlugin.startMobileHub(
          ipAddress: any(named: 'ipAddress'),
          port: any(named: 'port'),
        ),
      ).thenThrow(Exception('teste'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsPageView(settingsViewModel: settingsViewModel),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, ipAddress);
      await tester.enterText(find.byType(TextField).last, port);
      await tester.tap(find.byType(ElevatedButton).first);

      await tester.pumpAndSettle();

      verify(() => settingsViewModel.startMobileHub(ipAddress, port)).called(1);
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(find.byType(SnackBar), findsOneWidget);
      expect(snackBar.backgroundColor, Colors.red);
      expect(
        find.text('Falha ao iniciar o Mobile Hub: Exception: teste'),
        findsOneWidget,
      );
    });
  });

  group('interrompe o mobile hub', () {
    testWidgets('sucesso', (tester) async {
      when(() => settingsViewModel.stopMobileHub()).thenAnswer((_) async {
        return (success: true, message: 'Mobile Hub interrompido');
      });
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsPageView(settingsViewModel: settingsViewModel),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton).last);

      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      verify(() => settingsViewModel.stopMobileHub()).called(1);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(snackBar.backgroundColor, Colors.green);
      expect(find.text('Mobile Hub interrompido'), findsOneWidget);
    });

    testWidgets('erro exceção', (tester) async {
      when(() => mockPlugin.stopMobileHub()).thenThrow(Exception('teste'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsPageView(settingsViewModel: settingsViewModel),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton).last);

      await tester.pumpAndSettle();

      verify(() => settingsViewModel.stopMobileHub()).called(1);
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(find.byType(SnackBar), findsOneWidget);
      expect(snackBar.backgroundColor, Colors.red);
      expect(
        find.text('Falha ao interromper o Mobile Hub: Exception: teste'),
        findsOneWidget,
      );
    });
  });
}
