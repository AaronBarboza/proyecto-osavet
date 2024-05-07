import 'package:flutter/material.dart';

class VaccinationCalendarScreen extends StatelessWidget {
  const VaccinationCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de vacunación'),
      ),
      body: const Center(
        child: Text('Pantalla del Calendario de vacunación'),
      ),
    );
  }
}
