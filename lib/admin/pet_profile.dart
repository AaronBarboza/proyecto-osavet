import 'package:flutter/material.dart';

// Modelo básico para una mascota.
class Pet {
  final String name;
  final String type;
  final int age;

  Pet({required this.name, required this.type, required this.age});
}

// Pantalla de perfil de la mascota.
class PetProfileScreen extends StatelessWidget {
  // Crear una instancia de mascota de ejemplo.
  final Pet pet = Pet(name: 'Firulais', type: 'Perro', age: 4);

  PetProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name), // Usar el nombre de la mascota como título.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${pet.name}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8), // Espaciador
            Text('Tipo: ${pet.type}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8), // Espaciador
            Text('Edad: ${pet.age} años', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
