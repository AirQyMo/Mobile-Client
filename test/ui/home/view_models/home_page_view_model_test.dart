import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_client/ui/home/view_models/home_page_view_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin/plugin.dart';

class MockMethodChannelPlugin extends Mock implements Plugin {}

void main() {
  late HomePageViewModel homePageViewModel;
  late MockMethodChannelPlugin mockMethodChannelPlugin;
  late StreamController<String> streamController;

  setUp(() {
    mockMethodChannelPlugin = MockMethodChannelPlugin();
    streamController = StreamController<String>();

    when(
      () => mockMethodChannelPlugin.onMessageReceived,
    ).thenAnswer((_) => streamController.stream);

    homePageViewModel = HomePageViewModel.setMock(mockMethodChannelPlugin);
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
}
