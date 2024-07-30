import 'dart:io';
import 'package:app_patitas/home/models/animal_model.dart';
import 'package:app_patitas/home/structures/controllers/refugio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RefugioCreateAnimalPage extends StatefulWidget {
  const RefugioCreateAnimalPage({super.key});

  @override
  State<RefugioCreateAnimalPage> createState() =>
      _RefugioCreateAnimalPageState();
}

class _RefugioCreateAnimalPageState extends State<RefugioCreateAnimalPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _edadController = TextEditingController();
  final _razaController = TextEditingController();
  final _pesoController = TextEditingController();
  final _sexoController = TextEditingController();
  final _especieController = TextEditingController();
  final _estadoSaludController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  final refugioController = Get.find<RefugioController>();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Llene los datos de la mascota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _showImageSourceDialog(context),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[200],
                    child: _image == null
                        ? const Center(child: Text('Imagen de la mascota'))
                        : Image.file(_image!),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre:'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _edadController,
                        decoration: const InputDecoration(labelText: 'Edad:'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa la edad del animal';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        controller: _sexoController,
                        decoration: const InputDecoration(labelText: 'Sexo:'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa el sexo del animal';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _razaController,
                  decoration: const InputDecoration(labelText: 'Raza:'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la raza del animal';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _especieController,
                  decoration: const InputDecoration(labelText: 'Especie:'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la especie del animal';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _pesoController,
                  decoration: const InputDecoration(labelText: 'Peso:'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el peso del animal';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _estadoSaludController,
                  decoration:
                      const InputDecoration(labelText: 'Estado de salud:'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el estado de salud del animal';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            refugioController.createAnimal(
                                nombre: _nameController.text,
                                especie: _especieController
                                    .text, // Add especie if needed
                                edad: int.tryParse(_edadController.text) ?? 0,
                                peso: int.tryParse(_pesoController.text) ?? 0,
                                sexo: _sexoController.text,
                                raza: _razaController.text,
                                estadoSalud: _estadoSaludController.text,
                                image: _image?.path,
                                estado: "Activo");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white),
                        child: const Text('Guardar'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Cancelar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona una fuente de imagen'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
              child: const Text('Galería'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
              child: const Text('Cámara'),
            ),
          ],
        );
      },
    );
  }
}
