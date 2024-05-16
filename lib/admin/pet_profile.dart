import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// Modelo para una mascota
class Pet {
  final String name;
  final String type;
  final int age;
  final String ownerName;
  final String ownerPhone;
  final String photoUrl;

  Pet({
    required this.name,
    required this.type,
    required this.age,
    required this.ownerName,
    required this.ownerPhone,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'age': age,
      'ownerName': ownerName,
      'ownerPhone': ownerPhone,
      'photoUrl': photoUrl,
    };
  }
}

class PetProfileScreen extends StatefulWidget {
  const PetProfileScreen({super.key});

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _ownerPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfiles de Mascotas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('pets').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final pets = snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return Pet(
                      name: data['name'],
                      type: data['type'],
                      age: data['age'],
                      ownerName: data['ownerName'],
                      ownerPhone: data['ownerPhone'],
                      photoUrl: data['photoUrl'],
                    );
                  }).toList();

                  return ListView.builder(
                    itemCount: pets.length,
                    itemBuilder: (context, index) {
                      final pet = pets[index];
                      return ListTile(
                        leading: pet.photoUrl.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(pet.photoUrl),
                              )
                            : const CircleAvatar(
                                child: Icon(Icons.pets),
                              ),
                        title: Text(pet.name),
                        subtitle: Text('${pet.type}, ${pet.age} años'),
                        trailing: Text('${pet.ownerName}, ${pet.ownerPhone}'),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _showAddPetDialog(context);
            },
            child: const Text('Agregar Mascota'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddPetDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Mascota'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    final pickedImage =
                        await _imagePicker.pickImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      setState(() {
                        _selectedImage = File(pickedImage.path);
                      });
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: _selectedImage != null
                        ? Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.camera_alt),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                TextField(
                  controller: _typeController,
                  decoration: const InputDecoration(
                    labelText: 'Tipo',
                  ),
                ),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Edad',
                  ),
                ),
                TextField(
                  controller: _ownerNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Dueño',
                  ),
                ),
                TextField(
                  controller: _ownerPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Teléfono del Dueño',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _addPet(context);
                Navigator.pop(context);
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addPet(BuildContext context) async {
    String? photoUrl;
    if (_selectedImage != null) {
      final storageRef = FirebaseStorage.instance.ref().child('pet_photos').child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(_selectedImage!);
      await uploadTask.whenComplete(() => null);
      photoUrl = await storageRef.getDownloadURL();
    }

    final pet = Pet(
      name: _nameController.text,
      type: _typeController.text,
      age: int.parse(_ageController.text),
      ownerName: _ownerNameController.text,
      ownerPhone: _ownerPhoneController.text,
      photoUrl: photoUrl ?? '',
    );

    try {
      await FirebaseFirestore.instance.collection('pets').add(pet.toJson());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al agregar la mascota: $e'),
        ),
      );
    }

    _nameController.clear();
    _typeController.clear();
    _ageController.clear();
    _ownerNameController.clear();
    _ownerPhoneController.clear();
    setState(() {
      _selectedImage = null;
    });
  }
}