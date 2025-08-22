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
            ChangeNotifierProvider.value(
              value: homePageViewModel,
              child: Consumer<HomePageViewModel>(
                builder: (context, vm, child) {
                  return Text(
                    'Conexão com ContextNet: ${vm.connectionStatus}',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
