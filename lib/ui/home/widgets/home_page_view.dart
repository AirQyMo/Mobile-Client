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

  final Map<String, dynamic> mensagem = {
    'titulo': 'Mensagem do grupo',
    'horario': '22:30',
    'prioridade': 'baixa',
    'poluentes': [
      {
        'nome': 'PM2.5',
        'prioridade': 'moderada',
        'efeitos': ['asma', 'bronquite', 'irritação respiratória'],
      },
      {
        'nome': 'PM4',
        'prioridade': 'alta',
        'efeitos': ['irritação respiratória', 'inflamação sistêmica leve'],
      },
    ],
  };

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
          GroupMessageTopicComponent(mensagem: mensagem),
        ],
      ),
    );
  }
}
