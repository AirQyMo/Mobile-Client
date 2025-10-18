import 'package:flutter/material.dart';
import 'package:mobile_client/ui/ble_devices/widgets/ble_devices_page_view.dart';
import 'package:mobile_client/ui/home/widgets/group_message_topic_component.dart';
import 'package:mobile_client/ui/home/view_models/home_page_view_model.dart';
import 'package:mobile_client/ui/settings/widgets/settings_page_view.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alertas de Qualidade do Ar",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 40,
            height: 40,
            child: MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPageView(),
                      ),
                    );
                  },
                  child: Row(
                    children: [Icon(Icons.settings), Text('Configurações')],
                  ),
                ),
              ],
              builder: (_, MenuController controller, _) {
                return InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    controller.isOpen ? controller.close() : controller.open();
                  },
                  child: const Icon(Icons.menu, color: Colors.white),
                );
              },
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Color(0xFF29345E),
              ],
            ),
          ),
        ),
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
      body: Column(
        spacing: 10,
        children: [
          ChangeNotifierProvider(
            create: (context) => HomePageViewModel(),
            child: Consumer<HomePageViewModel>(
              builder: (context, viewModel, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.mensagens.length,
                    itemBuilder: (context, index) {
                      return GroupMessageTopicComponent(
                        mensagem: viewModel.mensagens[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
