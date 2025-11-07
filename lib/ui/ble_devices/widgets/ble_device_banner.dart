import 'package:flutter/material.dart';

class BleDeviceBanner extends StatelessWidget {
  final String? name;
  final String? uuid;
  final int rssi;

  const BleDeviceBanner({
    super.key,
    required this.name,
    required this.uuid,
    required this.rssi,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          name ?? 'Dispositivo sem nome',
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          uuid ?? 'UUID desconhecido',
          style: TextStyle(fontSize: 13),
        ),
        trailing: Text('RSSI: $rssi', style: TextStyle(fontSize: 13)),
      ),
    );
  }
}
