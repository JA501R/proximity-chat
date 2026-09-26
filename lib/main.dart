import 'package:flutter/material.dart';

import 'features/nearby/nearby_screen.dart';

void main() {
  runApp(const ProximityChatApp());
}

class ProximityChatApp extends StatelessWidget {
  const ProximityChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proximity Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080A0D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4DA3FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const NearbyScreen(),
    );
  }
}
