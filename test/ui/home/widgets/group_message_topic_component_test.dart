import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_client/ui/home/widgets/group_message_topic_component.dart';

void main() {
  testWidgets('renderiza a mensagem devidamente', (tester) async {
    const Map<dynamic, dynamic> mensagem = {
      "alert_id": "alert_1706798417002",
      "timestamp": "2025-10-01T22:40:17.002-03:00",
      "sensores": [
        {
          "sensor_id": "IAQ_6227821",
          "poluentes": [
            {
              "poluente": "pm25",
              "risk_level": "moderate",
              "affected_diseases": {
                "disease": ["asma", "bronquite", "irritação respiratória"],
              },
            },
            {
              "poluente": "pm4",
              "risk_level": "high",
              "affected_diseases": {
                "disease": [
                  "irritação respiratória",
                  "inflamação sistêmica leve",
                ],
              },
            },
          ],
        },
      ],
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const GroupMessageTopicComponent(mensagem: mensagem),
        ),
      ),
    );

    expect(find.text('01:40:17'), findsOneWidget);
  });

  group('prioridade widget', () {
    testWidgets('high', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PrioridadeWidget(prioridade: 'high')),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).last);
      final boxDecoration = container.decoration as BoxDecoration;
      final text = tester.widget<Text>(find.byType(Text));

      expect(boxDecoration.color, Color(0xfffee2e1));
      expect(text.style!.color, Color.fromARGB(255, 138, 38, 31));
      expect(find.text('high'), findsOneWidget);
    });
    testWidgets('moderate', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PrioridadeWidget(prioridade: 'moderate')),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).last);
      final boxDecoration = container.decoration as BoxDecoration;
      final text = tester.widget<Text>(find.byType(Text));

      expect(boxDecoration.color, Color(0xfffef3c4));
      expect(text.style!.color, Color.fromARGB(255, 151, 134, 57));
      expect(find.text('moderate'), findsOneWidget);
    });
    testWidgets('low', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PrioridadeWidget(prioridade: 'low')),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container).last);
      final boxDecoration = container.decoration as BoxDecoration;
      final text = tester.widget<Text>(find.byType(Text));

      expect(boxDecoration.color, Color(0xffdbfde5));
      expect(text.style!.color, Colors.green);
      expect(find.text('low'), findsOneWidget);
    });
  });
}
