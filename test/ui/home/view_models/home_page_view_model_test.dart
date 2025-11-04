import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_client/ui/home/view_models/home_page_view_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin/plugin.dart';

class MockMethodChannelPlugin extends Mock implements Plugin {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late HomePageViewModel homePageViewModel;
  late MockMethodChannelPlugin mockPlugin;
  late StreamController<String> streamController;

  setUp(() {
    mockPlugin = MockMethodChannelPlugin();
    streamController = StreamController<String>();

    when(
      () => mockPlugin.onMessageReceived,
    ).thenAnswer((_) => streamController.stream);
    when(() => mockPlugin.isMobileHubStarted()).thenAnswer((_) async => true);

    homePageViewModel = HomePageViewModel.setMock(mockPlugin);
  });

  tearDown(() => streamController.close());

  test('inicializa com plugin padrão', () {
    expect(() => HomePageViewModel(), returnsNormally);
  });
  test('lista inicia vazia', () {
    expect(homePageViewModel.mensagens, isEmpty);
  });

  test('adiciona mensagem do stream na lista', () async {
    const mensagem = "{\"texto\": \"teste\"}";
    streamController.add(mensagem);

    await Future(() {});

    expect(homePageViewModel.mensagens, hasLength(1));
    expect(homePageViewModel.mensagens.first, jsonDecode(mensagem));
  });

  group('mobile hub desligado?', () {
    test('sim', () async {
      final result = await mockPlugin.isMobileHubStarted();
      expect(result, true);
    });

    test('não', () async {
      when(
        () => mockPlugin.isMobileHubStarted(),
      ).thenAnswer((_) async => false);

      final result = await mockPlugin.isMobileHubStarted();
      expect(result, false);
    });
  });
}
