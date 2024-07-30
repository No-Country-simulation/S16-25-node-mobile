import 'dart:io';
import 'package:app_patitas/home/models/animal_model.dart';
import 'package:app_patitas/home/models/publicaciones_model.dart';
import 'package:app_patitas/home/structures/controllers/refugio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RefugioCreatePublicacionPage extends StatefulWidget {
  const RefugioCreatePublicacionPage({super.key});

  @override
  State<RefugioCreatePublicacionPage> createState() =>
      _RefugioCreateAnimalPageState();
}

class _RefugioCreateAnimalPageState
    extends State<RefugioCreatePublicacionPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _textoController = TextEditingController();
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
        title: const Text('Crear Publicacion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _tituloController,
                  decoration: const InputDecoration(labelText: 'Titulo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _textoController,
                  decoration: const InputDecoration(labelText: 'Texto'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa una especie';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () => _showImageSourceDialog(context),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[200],
                    child: _image == null
                        ? const Center(child: Text('Seleccionar Imagen'))
                        : Image.file(_image!),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      refugioController.createPublicacion(
                          id: '',
                          titulo: _tituloController.text,
                          texto: _textoController.text,
                          image: _image!,
                          refugio: '66a071818c1f1ac7991bfeb3');
                    }
                  },
                  child: const Text('Crear Publicacion'),
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
