import 'package:flutter/material.dart';

class BleDeviceBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String trailing;

  const BleDeviceBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 16)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 13)),
        trailing: Text('RSSI: $trailing', style: TextStyle(fontSize: 13)),
      ),
    );
  }
}
