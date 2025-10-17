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
  final Map<dynamic, dynamic> mensagem = {
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

  @override
  void initState() {
    super.initState();
    homePageViewModel = HomePageViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Color(0xFF29345E),
                ],
              ),
            ),
            height: MediaQuery.sizeOf(context).height * 0.2,
            width: MediaQuery.sizeOf(context).width,
            child: Center(
              child: Text(
                "Alertas de Qualidade do Ar",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => HomePageViewModel(),
            child: Consumer<HomePageViewModel>(
              builder: (context, viewModel, child) {
                return ListView.builder(
                  itemCount: viewModel.mensagens.length,
                  itemBuilder: (context, index) {
                    return GroupMessageTopicComponent(mensagem: mensagem);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
