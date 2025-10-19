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

  testWidgets('insere ip e port com sucesso', (tester) async {
    var ipAddress = "123.123.123.0";
    var port = "8096";
    when(() => mockSettingsViewModel.startMobileHub(any(), any())).thenAnswer((
      _,
    ) async {
      return true;
    });

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

    verify(
      () => mockSettingsViewModel.startMobileHub(ipAddress, port),
    ).called(1);
  });

  testWidgets('para o mobile hub', (tester) async {
    when(() => mockSettingsViewModel.stopMobileHub()).thenAnswer((_) async {});
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SettingsPageView(settingsViewModel: mockSettingsViewModel),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton).last);

    verify(() => mockSettingsViewModel.stopMobileHub()).called(1);
  });
}
