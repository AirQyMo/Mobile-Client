import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_client/core/message_service.dart';
import 'package:mobile_client/ui/home/view_models/home_page_view_model.dart';
import 'package:mobile_client/ui/settings/view_models/settings_view_model.dart';
import 'package:mocktail/mocktail.dart';

class MockMessageService extends Mock implements MessageService {}

class MockSettingsViewModel extends Mock implements SettingsViewModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockMessageService mockMessageService;
  late MockSettingsViewModel mockSettingsViewModel;
  late HomePageViewModel homePageViewModel;
  late StreamController<List<Map<dynamic, dynamic>>> streamController;

  setUp(() {
    mockMessageService = MockMessageService();
    mockSettingsViewModel = MockSettingsViewModel();
    streamController =
        StreamController<List<Map<dynamic, dynamic>>>.broadcast();

    when(
      () => mockMessageService.stream,
    ).thenAnswer((_) => streamController.stream);
  });

  tearDown(() {
    streamController.close();
  });

  test('inicialização copia mensagens', () {
    when(() => mockSettingsViewModel.isMobileHubStarted).thenReturn(true);
    when(() => mockMessageService.mensagens).thenReturn([
      {"msg": "teste"},
    ]);

    homePageViewModel = HomePageViewModel.setMock(
      mockMessageService,
      mockSettingsViewModel,
    );

    expect(homePageViewModel.mensagens.length, 1);
    expect(homePageViewModel.mensagens.first["msg"], "teste");
  });

  test('view model atualiza mensagens quando o service emite', () async {
    when(() => mockSettingsViewModel.isMobileHubStarted).thenReturn(true);
    when(() => mockMessageService.mensagens).thenReturn([]);
    when(() => mockMessageService.startListening()).thenAnswer((_) {});

    homePageViewModel = HomePageViewModel.setMock(
      mockMessageService,
      mockSettingsViewModel,
    );
    const mensagem = [
      {"texto": "alerta novo"},
    ];
    streamController.add(mensagem);
    await pumpEventQueue();

    expect(homePageViewModel.mensagens, hasLength(1));
    expect(homePageViewModel.mensagens.first["texto"], "alerta novo");
  });

  test('mobile hub para', () {
    when(() => mockMessageService.mensagens).thenReturn([]);
    when(() => mockSettingsViewModel.isMobileHubStarted).thenReturn(false);

    homePageViewModel = HomePageViewModel.setMock(
      mockMessageService,
      mockSettingsViewModel,
    );

    verify(() => mockMessageService.stopListening()).called(1);
  });
}
