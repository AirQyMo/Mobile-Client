import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mobile_client/main.dart';
import 'package:mobile_client/ui/home/widgets/home_page_view.dart';
import 'package:mobile_client/ui/settings/widgets/settings_page_view.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
      'acessa a página de configurações e configura o ip e port do context net',
      (tester) async {
        await tester.pumpWidget(const MyApp());

        expect(find.byType(HomePageView), findsOneWidget);

        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Configurações'));
        await tester.pumpAndSettle();

        expect(find.byType(SettingsPageView), findsOneWidget);

        await tester.enterText(find.byType(TextField).first, "192.168.15.10");
        await tester.enterText(find.byType(TextField).last, "6200");
        await tester.tap(find.byType(ElevatedButton).first);

        await tester.pumpAndSettle();

        final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
        expect(find.byType(SnackBar), findsOneWidget);
        expect(snackBar.backgroundColor, Colors.green);
        // expect(find.text('Mobile Hub iniciado com sucesso'), findsOneWidget);
      },
    );
  });
}
