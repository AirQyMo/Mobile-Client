import 'package:flutter/material.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({super.key});

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  late bool ble = false;
  late bool contextNetConnection = false;
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
                  Text('Ligar BLE'),
                  Switch(
                    value: ble,
                    onChanged: (bool newValue) {
                      setState(() {
                        ble = newValue;
                        if (ble) {
                          print('começou a escanear');
                          // TODO: startHub()
                        } else {
                          print('parou de escanear');
                          // TODO: stopHub()
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Conectar ao ContextNet'),
                  Switch(
                    value: contextNetConnection,
                    onChanged: (bool newValue) {
                      setState(() {
                        contextNetConnection = newValue;
                        if (contextNetConnection) {
                          print('começou a escanear');
                          // TODO: startHub()
                        } else {
                          print('parou de escanear');
                          // TODO: stopHub()
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
