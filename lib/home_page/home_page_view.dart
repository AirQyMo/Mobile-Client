import 'package:flutter/material.dart';
import 'package:mobile_client/ble_devices_page/ble_devices_page_view.dart';
import 'package:mobile_client/home_page/components/home_page_component.dart';
import 'package:mobile_client/home_page/components/recomendations_component.dart';
import 'package:mobile_client/home_page/home_page_view_model.dart';
import 'package:mobile_client/settings_page/settings_page_view.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late HomePageViewModel homePageViewModel;

  @override
  void initState() {
    super.initState();
    homePageViewModel = HomePageViewModel();
    homePageViewModel.startConnectionStatus();
    homePageViewModel.receiveMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Home Page"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Menu', style: TextStyle(fontSize: 24))),
            ListTile(
              leading: const Icon(Icons.bluetooth_sharp),
              title: const Text('Dispositivos BLE'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BleDevicesPageView()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPageView()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            ChangeNotifierProvider.value(
              value: homePageViewModel,
              child: Consumer<HomePageViewModel>(
                builder: (context, vm, child) {
                  return Text(
                    'Conexão com ContextNet: ${vm.connectionStatus}',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            Expanded(
              child: ChangeNotifierProvider.value(
                value: homePageViewModel,
                child: Consumer<HomePageViewModel>(
                  builder: (context, vm, child) {
                    if (vm.message.entries.isEmpty) return Text('Vazio');

                    (String, Color, IconData) getRiskConfig(String level) {
                      return switch (level) {
                        "moderate" => (
                          "Moderado",
                          Colors.yellow,
                          Icons.back_hand,
                        ),
                        "high" => ("Alto", Colors.red, Icons.warning),
                        "critical" => (
                          "Crítico",
                          Color.fromARGB(255, 160, 20, 10),
                          Icons.dangerous,
                        ),
                        _ => ("Erro", Colors.white, Icons.error),
                      };
                    }

                    final (riskText, riskColor, riskIcon) = getRiskConfig(
                      vm.message['risk_level'],
                    );

                    return Column(
                      spacing: 10,
                      children: [
                        SizedBox(height: 25),
                        HomePageComponent(
                          inputText: vm.message['location']['address'],
                          icon: Icons.location_pin,
                          color: Colors.grey,
                        ),
                        HomePageComponent(
                          inputText: riskText,
                          icon: riskIcon,
                          color: riskColor,
                        ),
                        RecomendationsComponent(
                          inputText: "Recomendações:",
                          icon: Icons.recommend,
                          color: Colors.blue,
                          recomendations: vm.message['recommendations'],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
