import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const Soundizzy());
}

// ----------- Soundizzy (Main) ----------------
class Soundizzy extends StatelessWidget {
  const Soundizzy({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Soundizzy',
      home: SafeArea(child: Scaffold()),
      debugShowCheckedModeBanner: false,
    );
  }
}
