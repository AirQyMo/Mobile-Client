import 'package:flutter/material.dart';
import 'package:mobile_client/ui/settings/view_models/settings_view_model.dart';

class SettingsPageView extends StatefulWidget {
  @visibleForTesting
  final SettingsViewModel? settingsViewModel;

  const SettingsPageView({super.key, this.settingsViewModel});

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  late SettingsViewModel settingsViewModel;
  final TextEditingController ipAddressController = TextEditingController();
  final TextEditingController portController = TextEditingController();

  @override
  void initState() {
    super.initState();
    settingsViewModel = widget.settingsViewModel ?? SettingsViewModel();
  }

  void _showSnackBar(BuildContext context, String message, bool isError) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Configurações", style: TextStyle(color: Colors.white)),
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.2,
          ),
          child: Column(
            spacing: 20,
            children: [
              Column(
                children: [
                  Row(children: [Text('Endereço de IP')]),
                  TextField(
                    key: Key('input ip address'),
                    controller: ipAddressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(children: [Text('Port')]),
                  TextField(
                    key: Key('input port'),
                    controller: portController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final result = await settingsViewModel.startMobileHub(
                        ipAddressController.text,
                        portController.text,
                      );

                      _showSnackBar(context, result.message, !result.success);
                    },
                    child: Text('Iniciar Mobile Hub'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await settingsViewModel.stopMobileHub();

                      _showSnackBar(context, result.message, !result.success);
                    },
                    child: Text('Para Mobile Hub'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
