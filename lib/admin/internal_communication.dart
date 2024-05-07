import 'package:flutter/material.dart';

class InternalCommunicationScreen extends StatelessWidget {
  const InternalCommunicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comunicación Interna"),
      ),
      body: const Center(
        child: Text("Pantalla de Comunicación Interna"),
      ),
    );
  }
}
