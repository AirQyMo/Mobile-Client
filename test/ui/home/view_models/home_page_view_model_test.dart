import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_client/ui/home/view_models/home_page_view_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin/plugin_method_channel.dart';

class MockMethodChannelPlugin extends Mock implements MethodChannelPlugin {}

void main() {
  late HomePageViewModel homePageViewModel;
  late MockMethodChannelPlugin mockMethodChannelPlugin;
  late StreamController<Map<dynamic, dynamic>> streamController;

  setUp(() {
    mockMethodChannelPlugin = MockMethodChannelPlugin();
    streamController = StreamController<Map<dynamic, dynamic>>();

    when(
      () => mockMethodChannelPlugin.onMessageReceived,
    ).thenAnswer((_) => streamController.stream);

    homePageViewModel = HomePageViewModel.setMock(mockMethodChannelPlugin);
  });

  tearDown(() => streamController.close());
  test('lista inicia vazia', () {
    expect(homePageViewModel.mensagens, isEmpty);
  });

  test('adiciona mensagem do stream na lista', () async {
    const mensagem = {'texto': 'teste'};
    streamController.add(mensagem);

    await Future(() {});

    expect(homePageViewModel.mensagens, hasLength(1));
    expect(homePageViewModel.mensagens.first, mensagem);
  });
}
