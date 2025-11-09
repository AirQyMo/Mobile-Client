import 'package:flutter/material.dart';

class BleDeviceBanner extends StatelessWidget {
  final Map<dynamic, dynamic> device;

  const BleDeviceBanner({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          device['name'] ?? 'Dispositivo sem nome',
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          device['uuid'] ?? 'UUID desconhecido',
          style: TextStyle(fontSize: 13),
        ),
        trailing: Text(
          'RSSI: ${device['rssi']}',
          style: TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}
