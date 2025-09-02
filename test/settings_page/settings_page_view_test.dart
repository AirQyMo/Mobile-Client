import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_client/settings_page/settings_page_view.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin/plugin.dart';

class MockMobileHubPlugin extends Mock implements Plugin {}

void main() {
  late MockMobileHubPlugin mockPlugin;

  setUp(() {
    mockPlugin = MockMobileHubPlugin();

    registerFallbackValue(Duration(seconds: 1));

    when(() => mockPlugin.startMobileHub()).thenAnswer((_) async {});
    when(() => mockPlugin.stopMobileHub()).thenAnswer((_) async {});
  });

  testWidgets('toggling BLE switch to ON/OFF', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: SettingsPageView(plugin: mockPlugin)),
    );
    final bleSwitch = tester.widget<Switch>(
      find.byKey(const Key('BLE_switch')),
    );

    expect(bleSwitch.value, false);

    await tester.tap(find.byKey(const Key('BLE_switch')));
    await tester.pump();

    verify(() => mockPlugin.startMobileHub()).called(1);

    await tester.tap(find.byKey(const Key('BLE_switch')));
    await tester.pump();

    verify(() => mockPlugin.stopMobileHub()).called(1);
  });

  // testWidgets('toggling ContextNet switch to ON/OFF', (
  //   WidgetTester tester,
  // ) async {
  //   await tester.pumpWidget(
  //     MaterialApp(home: SettingsPageView(plugin: mockPlugin)),
  //   );
  //   final bleSwitch = tester.widget<Switch>(
  //     find.byKey(const Key('ContextNetConnection_switch')),
  //   );

  //   expect(bleSwitch.value, false);

  //   await tester.tap(find.byKey(const Key('ContextNetConnection_switch')));
  //   await tester.pump();
  //   expect(bleSwitch.value, true);

  //   await tester.tap(find.byKey(const Key('ContextNetConnection_switch')));
  //   await tester.pump();
  //   expect(bleSwitch.value, false);
  // });
}

Finder findSwitchByLabel(String label) {
  return find.ancestor(of: find.text(label), matching: find.byType(Switch));
}
