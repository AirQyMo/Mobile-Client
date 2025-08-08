import 'package:flutter/material.dart';
// import 'package:mobile_hub_plugin/mobile_hub_plugin.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Home Page"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Menu', style: TextStyle(fontSize: 24))),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                // TODO: Menu de configurações
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          "Essa é a home page",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
