import 'package:flutter/material.dart';
import 'package:mobile_client/ui/ble_devices/view_models/ble_devices_page_view_model.dart';
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
          style: TextStyle(color: Colors.white),
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
                return Expanded(
                  child: ListView.builder(
                    itemCount: bleDevicesPageViewModel.devices.length,
                    itemBuilder: (context, index) {
                      return Text(
                        bleDevicesPageViewModel.devices[index]['name'],
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
