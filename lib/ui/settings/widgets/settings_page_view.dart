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

    if (settingsViewModel.isMobileHubStarted) {
      ipAddressController.text = settingsViewModel.ipAddress;
      portController.text = settingsViewModel.port;
    }
  }

  void _showSnackBar(String message, bool isError) {
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
        title: Text(
          "Configurações",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
      body: AnimatedBuilder(
        animation: settingsViewModel,
        builder: (context, _) {
          final mobileHubStarted = settingsViewModel.isMobileHubStarted;

          return Center(
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
                        enabled: !mobileHubStarted,
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
                        enabled: !mobileHubStarted,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: !mobileHubStarted
                            ? () async {
                                settingsViewModel.ipAddress =
                                    ipAddressController.text;
                                settingsViewModel.port = portController.text;
                                final result = await settingsViewModel
                                    .startMobileHub(
                                      ipAddressController.text,
                                      portController.text,
                                    );

                                if (mounted) {
                                  _showSnackBar(
                                    result.message,
                                    !result.success,
                                  );
                                }
                              }
                            : null,
                        child: const Text('Iniciar Mobile Hub'),
                      ),
                      ElevatedButton(
                        onPressed: mobileHubStarted
                            ? () async {
                                final result = await settingsViewModel
                                    .stopMobileHub();

                                if (mounted) {
                                  _showSnackBar(
                                    result.message,
                                    !result.success,
                                  );
                                }
                              }
                            : null,
                        child: const Text('Parar Mobile Hub'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
