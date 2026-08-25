import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double currentSpeed = 0.0;

  final List<String> alerts = [
    'Keine Meldungen vorhanden',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navi-VA'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const Icon(
                Icons.navigation,
                size: 90,
              ),

              const SizedBox(height: 20),

              const Text(
                'Aktuelle Geschwindigkeit',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                '${currentSpeed.toStringAsFixed(1)} km/h',
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Karte'),
                  subtitle: const Text(
                    'OpenStreetMap Navigation',
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.warning),
                  title: const Text('Verkehrsmeldungen'),
                  subtitle: Text(
                    alerts.first,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                icon: const Icon(Icons.speed),
                label: const Text(
                  'Geschwindigkeit testen',
                ),

                onPressed: () {
                  setState(() {
                    currentSpeed = 50.0;
                  });
                },
              ),

              const SizedBox(height: 15),

              ElevatedButton.icon(
                icon: const Icon(Icons.clear),
                label: const Text(
                  'Zurücksetzen',
                ),

                onPressed: () {
                  setState(() {
                    currentSpeed = 0.0;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
