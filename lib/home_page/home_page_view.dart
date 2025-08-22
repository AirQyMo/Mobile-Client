import 'package:flutter/material.dart';
import 'package:mobile_client/ble_devices_page/ble_devices_page_view.dart';
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
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPageView()),
                );
              },
            ),
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
                    return Column(
                      children: [
                        SizedBox(height: 25),
                        Text(
                          vm.message['location']['address'],
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          'Nível de risco: ${vm.message['risk_level']}',
                          style: TextStyle(fontSize: 24),
                        ),
                        Text('Recomendações:', style: TextStyle(fontSize: 24)),
                        Expanded(
                          child: ListView.builder(
                            itemCount: vm.message['recommendations'].length,
                            itemBuilder: (context, index) {
                              return Text(
                                vm.message['recommendations'][index],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              );
                            },
                          ),
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
