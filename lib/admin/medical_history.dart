import 'package:flutter/material.dart';

class MedicalHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial Médico"),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Historial Médico de Mascotas",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildMedicalRecord(
                        petName: "Lucas",
                        details: "Vacunacion al dia",
                        onEdit: () {
                          _editMedicalHistory(
                              context, "Lucas", "Vacunacion al dia");
                        },
                        onDelete: () {
                          _deleteMedicalHistory(context, "Lucas");
                        }),
                    _buildMedicalRecord(
                        petName: "Docky",
                        details: "Pendiente de desparacitacion",
                        onEdit: () {
                          _editMedicalHistory(
                              context, "Docky", "Pendiente de desparacitacion");
                        },
                        onDelete: () {
                          _deleteMedicalHistory(context, "Docky");
                        }),
                    // Agrega más registros médicos si es necesario
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalRecord({
    required String petName,
    required String details,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Nombre de la mascota: $petName",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Detalles: $details",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: onEdit,
                child: Text(
                  "Editar",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(width: 8),
              TextButton(
                onPressed: onDelete,
                child: Text(
                  "Eliminar",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _editMedicalHistory(
      BuildContext context, String petName, String currentDetails) {
    TextEditingController detailsController =
        TextEditingController(text: currentDetails);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Historial Médico de $petName"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Detalles actuales: $currentDetails"),
                SizedBox(height: 16),
                TextField(
                  controller: detailsController,
                  decoration: InputDecoration(
                    labelText: "Nuevos detalles",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  void _deleteMedicalHistory(BuildContext context, String petName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Eliminar Historial Médico de $petName"),
          content: Text(
              "¿Estás seguro de que quieres eliminar el historial médico de $petName?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                // Aquí puedes implementar la lógica para eliminar el historial médico
                Navigator.of(context).pop();
              },
              child: Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }
}
