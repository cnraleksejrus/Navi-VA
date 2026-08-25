import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(NaviVAApp());
}

class NaviVAApp extends StatelessWidget {
  const NaviVAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navi-VA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
