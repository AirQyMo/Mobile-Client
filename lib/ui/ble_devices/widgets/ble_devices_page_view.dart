import 'package:flutter/material.dart';
import 'package:mobile_client/ui/ble_devices/view_models/ble_devices_page_view_model.dart';
import 'package:mobile_client/ui/ble_devices/widgets/ble_device_banner.dart';
import 'package:provider/provider.dart';

class BleDevicesPageView extends StatefulWidget {
  @visibleForTesting
  final BleDevicesPageViewModel? bleDevicesPageViewModel;

  const BleDevicesPageView({super.key, this.bleDevicesPageViewModel});

  @override
  State<BleDevicesPageView> createState() => _BleDevicesPageViewState();
}

class _BleDevicesPageViewState extends State<BleDevicesPageView> {
  late BleDevicesPageViewModel bleDevicesPageViewModel;

  @override
  void initState() {
    super.initState();
    bleDevicesPageViewModel =
        widget.bleDevicesPageViewModel ?? BleDevicesPageViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Dispositivos BLE",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
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
      body: Column(
        children: [
          ChangeNotifierProvider(
            create: (context) => bleDevicesPageViewModel,
            child: Consumer<BleDevicesPageViewModel>(
              builder: (context, value, child) {
                if (value.devices.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        bleDevicesPageViewModel.getMobileHubState()
                            ? 'Sem dispositivos nas proximidades'
                            : 'Scan BLE desligado',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: bleDevicesPageViewModel.devices.length,
                    itemBuilder: (context, index) {
                      return BleDeviceBanner(device: value.devices[index]);
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
