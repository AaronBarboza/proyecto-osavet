import 'package:flutter/material.dart';
import 'package:flutter_osavet_1/admin/addEvento.dart';
import 'package:flutter_osavet_1/admin/addnoticia.dart';
import 'package:flutter_osavet_1/usuarios/principalpage.dart';
import 'appointment.dart';
import 'medical_history.dart';
import 'billing.dart';
import 'pet_profile.dart';
import 'calendar.dart';
import '../login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Veterinaria OSAVET"),
        backgroundColor: Color.fromRGBO(75, 224, 255, 1),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF4be0ff),
                    Color(0xFF9bfff8),
                    Color(0xFF9bfff8),
                    
                  ],
                ),
              ),
              child: Text(
                'Opciones',
                style: TextStyle(
                  color: Color.fromRGBO(146, 219, 224, 1),
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Gestión de citas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historial médico'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicalHistoryScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Facturación'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BillingScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.pets),
              title: const Text('Perfil de mascotas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PetProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Calendario de vacunación'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VaccinationCalendarScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Agregar Noticia'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddNoticia()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Agregar Evento'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddEvento()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrincipalPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFa9dcff),
              Color(0xFFe4f6ff),
              Color(0xFFffffff),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Perfil del Administrador',
              style: TextStyle(
                color: Color.fromARGB(255, 41, 43, 49),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.grey[700]),
                title: const Text('Nombre del Administrador'),
                subtitle: const Text('admin@osavet.com'),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Editar Perfil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3a6186),
              ),
              onPressed: () {
                // Navegar a la pantalla de edición de perfil
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.analytics, color: Colors.grey[700]),
                title: const Text('Estadísticas de Uso'),
                subtitle: const Text('Visualizar estadísticas de la aplicación'),
                onTap: () {
                  // Navegar a la pantalla de estadísticas
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StatisticsScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.settings, color: Colors.grey[700]),
                title: const Text('Configuración'),
                subtitle: const Text('Ajustar configuraciones de la aplicación'),
                onTap: () {
                  // Navegar a la pantalla de configuración
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: const Color(0xFF2c3e50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Guardar cambios del perfil
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3a6186),
              ),
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas de Uso'),
        backgroundColor: const Color(0xFF2c3e50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.grey[700]),
                title: const Text('Citas Programadas'),
                subtitle: const Text('Total: 123\nEsta semana: 45\nHoy: 8'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.person_add, color: Colors.grey[700]),
                title: const Text('Nuevos Clientes'),
                subtitle: const Text('Total: 50\nEsta semana: 10\nHoy: 2'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.pets, color: Colors.grey[700]),
                title: const Text('Nuevas Mascotas'),
                subtitle: const Text('Total: 70\nEsta semana: 15\nHoy: 3'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.attach_money, color: Colors.grey[700]),
                title: const Text('Facturación'),
                subtitle: const Text('Ingresos: \$5000\nEsta semana: \$1200\nHoy: \$300'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.notifications, color: Colors.grey[700]),
                title: const Text('Notificaciones Enviadas'),
                subtitle: const Text('Total: 200\nEsta semana: 40\nHoy: 8'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.assessment, color: Colors.grey[700]),
                title: const Text('Tasa de Retención de Clientes'),
                subtitle: const Text('80% de clientes recurrentes'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.vaccines, color: Colors.grey[700]),
                title: const Text('Vacunas Administradas'),
                subtitle: const Text('Total: 150\nEsta semana: 20\nHoy: 5'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.feedback, color: Colors.grey[700]),
                title: const Text('Comentarios y Sugerencias'),
                subtitle: const Text('Total: 30\nEsta semana: 5\nHoy: 1'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: const Color(0xFF2c3e50),
      ),
      body: Center(
        child: Text(
          'Aquí se podrán ajustar las configuraciones de la aplicación.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
