import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_client/ui/settings/view_models/settings_view_model.dart';
import 'package:mobile_client/ui/settings/widgets/settings_page_view.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsViewModel extends Mock implements SettingsViewModel {}

void main() {
  late MockSettingsViewModel mockSettingsViewModel;

  setUp(() {
    mockSettingsViewModel = MockSettingsViewModel();
  });

  group('inicia o mobile hub', () {
    testWidgets('sucesso', (tester) async {
      var ipAddress = "123.123.123.0";
      var port = "8096";
      when(() => mockSettingsViewModel.startMobileHub(any(), any())).thenAnswer(
        (_) async {
          return (success: true, message: "Mobile Hub iniciado com sucesso");
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsPageView(settingsViewModel: mockSettingsViewModel),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, ipAddress);
      await tester.enterText(find.byType(TextField).last, port);
      await tester.tap(find.byType(ElevatedButton).first);

      await tester.pumpAndSettle();

      verify(
        () => mockSettingsViewModel.startMobileHub(ipAddress, port),
      ).called(1);
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(find.byType(SnackBar), findsOneWidget);
      expect(snackBar.backgroundColor, Colors.green);
      expect(find.text('Mobile Hub iniciado com sucesso'), findsOneWidget);
    });

    testWidgets('endereço de ip inválido', (tester) async {
      var ipAddress = "999.999.999.999";
      var port = "8096";
      when(() => mockSettingsViewModel.startMobileHub(any(), any())).thenAnswer(
        (_) async {
          return (success: false, message: "Endereço de IP inválido");
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsPageView(settingsViewModel: mockSettingsViewModel),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, ipAddress);
      await tester.enterText(find.byType(TextField).last, port);
      await tester.tap(find.byType(ElevatedButton).first);

      await tester.pumpAndSettle();

      verify(
        () => mockSettingsViewModel.startMobileHub(ipAddress, port),
      ).called(1);
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(find.byType(SnackBar), findsOneWidget);
      expect(snackBar.backgroundColor, Colors.red);
      expect(find.text('Endereço de IP inválido'), findsOneWidget);
    });

    testWidgets('porta inválida', (tester) async {
      var ipAddress = "123.123.123.123";
      var port = "-1";
      when(() => mockSettingsViewModel.startMobileHub(any(), any())).thenAnswer(
        (_) async {
          return (success: false, message: "Porta inválida");
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsPageView(settingsViewModel: mockSettingsViewModel),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, ipAddress);
      await tester.enterText(find.byType(TextField).last, port);
      await tester.tap(find.byType(ElevatedButton).first);

      await tester.pumpAndSettle();

      verify(
        () => mockSettingsViewModel.startMobileHub(ipAddress, port),
      ).called(1);
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(find.byType(SnackBar), findsOneWidget);
      expect(snackBar.backgroundColor, Colors.red);
      expect(find.text('Porta inválida'), findsOneWidget);
    });

    testWidgets('erro exceção', (tester) async {
      var ipAddress = "123.123.123.0";
      var port = "8096";
      when(() => mockSettingsViewModel.startMobileHub(any(), any())).thenAnswer(
        (_) async {
          return (
            success: false,
            message: "Falha ao iniciar o Mobile Hub: Exception: teste",
          );
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsPageView(settingsViewModel: mockSettingsViewModel),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, ipAddress);
      await tester.enterText(find.byType(TextField).last, port);
      await tester.tap(find.byType(ElevatedButton).first);

      await tester.pumpAndSettle();

      verify(
        () => mockSettingsViewModel.startMobileHub(ipAddress, port),
      ).called(1);
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
      when(() => mockSettingsViewModel.stopMobileHub()).thenAnswer((_) async {
        return (success: true, message: 'Mobile Hub interrompido');
      });
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsPageView(settingsViewModel: mockSettingsViewModel),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton).last);

      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      verify(() => mockSettingsViewModel.stopMobileHub()).called(1);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(snackBar.backgroundColor, Colors.green);
      expect(find.text('Mobile Hub interrompido'), findsOneWidget);
    });

    testWidgets('erro exceção', (tester) async {
      var ipAddress = "123.123.123.0";
      var port = "8096";
      when(() => mockSettingsViewModel.startMobileHub(any(), any())).thenAnswer(
        (_) async {
          return (
            success: false,
            message: "Falha ao interromper o Mobile Hub: Exception: teste",
          );
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsPageView(settingsViewModel: mockSettingsViewModel),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, ipAddress);
      await tester.enterText(find.byType(TextField).last, port);
      await tester.tap(find.byType(ElevatedButton).first);

      await tester.pumpAndSettle();

      verify(
        () => mockSettingsViewModel.startMobileHub(ipAddress, port),
      ).called(1);
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
