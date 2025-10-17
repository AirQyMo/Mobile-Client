import 'package:flutter/material.dart';
import 'package:plugin/plugin.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({super.key, this.plugin});
  final Plugin? plugin;

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  late Plugin plugin;
  late bool ble = false;
  late bool contextNetConnection = false;

  @override
  void initState() {
    super.initState();
    plugin = widget.plugin ?? Plugin();
  }

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
                    key: Key('BLE_switch'),
                    value: ble,
                    onChanged: (bool newValue) {
                      setState(() {});
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
                  // Switch(
                  //   key: Key('ContextNetConnection_switch'),
                  //   value: contextNetConnection,
                  //   onChanged: (bool newValue) {
                  //     setState(() {
                  //       contextNetConnection = newValue;
                  //       if (contextNetConnection) {
                  //         // TODO: replace with another function
                  //         plugin.startMobileHub();
                  //       } else {
                  //         // TODO: replace with another function
                  //         plugin.stopMobileHub();
                  //       }
                  //     });
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
