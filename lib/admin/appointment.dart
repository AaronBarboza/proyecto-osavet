import 'package:flutter/material.dart';

// Clase para representar una cita
class Appointment {
  final String title;
  final String details;

  Appointment({required this.title, required this.details});
}

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  // Lista de citas
  List<Appointment> appointments = [
    Appointment(title: 'Cita 1', details: 'Castracion de gato'),
    Appointment(title: 'Cita 2', details: 'Baño y peluqueado'),
    Appointment(title: 'Cita 3', details: 'Desparacitacion'),
    Appointment(title: 'Cita 4', details: 'Vacunacion'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestión de Citas")),
      backgroundColor: const Color.fromARGB(
          255, 85, 205, 226), // Color de fondo del Scaffold
      body: Column(
        children: <Widget>[
          // Encabezado
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "Lista de Citas",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Lista de citas
          Expanded(
            child: ListView.builder(
              itemCount: appointments.length, // Número de citas
              itemBuilder: (BuildContext context, int index) {
                // Construcción de cada elemento de la lista de citas
                return ListTile(
                  title: Text(appointments[index].title),
                  subtitle: Text(appointments[index].details),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Acción al presionar el botón de editar cita
                          _editAppointment(context, index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Acción al presionar el botón de eliminar cita
                          _deleteAppointment(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Botón para agregar nueva cita
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón para agregar nueva cita
                _addAppointment();
              },
              child: const Text("Agregar Cita"),
            ),
          ),
        ],
      ),
    );
  }

  // Función para editar una cita
  void _editAppointment(BuildContext context, int index) {
    // Mostrar un cuadro de diálogo para editar la cita
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController titleController =
            TextEditingController(text: appointments[index].title);
        TextEditingController detailsController =
            TextEditingController(text: appointments[index].details);

        return AlertDialog(
          title: Text("Editar Cita"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Título"),
              ),
              TextField(
                controller: detailsController,
                decoration: InputDecoration(labelText: "Detalles"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el cuadro de diálogo
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                // Guardar los cambios y cerrar el cuadro de diálogo
                Appointment editedAppointment = Appointment(
                  title: titleController.text,
                  details: detailsController.text,
                );
                _editAppointmentData(index, editedAppointment);
                Navigator.pop(context);
              },
              child: Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  // Función para editar los datos de una cita
  void _editAppointmentData(int index, Appointment editedAppointment) {
    setState(() {
      appointments[index] = editedAppointment;
    });
  }

  // Función para eliminar una cita
  void _deleteAppointment(int index) {
    setState(() {
      appointments.removeAt(index);
    });
  }

  // Función para agregar una nueva cita
  void _addAppointment() {
    setState(() {
      // Simplemente agrega una cita de ejemplo
      appointments.add(Appointment(
        title: 'Nueva Cita',
        details: 'Detalles de la nueva cita',
      ));
    });
  }
}
