import 'package:flutter/material.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({super.key});

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  late bool ble = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Configurações"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('Ligar BLE'),
                      // Text(
                      //   'Permite que o dispositivo escaneie dispositivos BLE próximos',
                      // ),
                    ],
                  ),
                  Switch(
                    value: ble,
                    onChanged: (bool newValue) {
                      setState(() {
                        ble = newValue;
                        if (ble) {
                          print('começou a escanear');
                          // começa a escanear por dispositivos ble
                        } else {
                          print('parou de escanear');
                          // para de escanear por dispositivos ble
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
