import 'package:flutter/material.dart';
import 'package:mobile_client/ui/ble_devices/view_models/ble_devices_page_view_model.dart';
import 'package:mobile_client/ui/ble_devices/widgets/ble_device_banner.dart';
import 'package:provider/provider.dart';
// import 'package:mobile_hub_plugin/mobile_hub_plugin.dart';

class BleDevicesPageView extends StatelessWidget {
  const BleDevicesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Dispositivos BLE"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Dispositivos próximos',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: ChangeNotifierProvider(
                create: (_) =>
                    BleDevicesPageViewModel()..startDeviceDiscovery(),
                child: Consumer<BleDevicesPageViewModel>(
                  builder: (context, viewModel, child) {
                    return ListView.builder(
                      itemCount: viewModel.discoveredDevices.length,
                      itemBuilder: (context, index) {
                        final device = viewModel.discoveredDevices[index];
                        return BleDeviceBanner(
                          title: device['name'],
                          subtitle: device['address'],
                          trailing: device['rssi'].toString(),
                        );
                      },
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
