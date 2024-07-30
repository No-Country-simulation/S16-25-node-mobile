import 'dart:io';
import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/home/models/refugio_model.dart';
import 'package:app_patitas/home/structures/controllers/refugio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RefugioCreatePage extends StatefulWidget {
  const RefugioCreatePage({super.key});

  @override
  _RefugioCreatePageState createState() => _RefugioCreatePageState();
}

class _RefugioCreatePageState extends State<RefugioCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final RefugioController refugioController = Get.find<RefugioController>();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _createRefugio() async {
    if (_formKey.currentState?.validate() ?? false) {
      final idUser = await Const.getStorage.read(key: "idUser") ?? '';
      final refugio = RefugioModel(
        nombre: _nameController.text,
        correo: _emailController.text,
        telefono: _phoneController.text,
        image: _image?.path,
        gerente: "66a061a96eb745499d30cc42",
        animales: [],
        publicaciones: [],
      );
      refugioController.createRefugio(refugio);
      // Puedes mostrar un mensaje de éxito o navegar a otra página aquí
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear refugio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un correo';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor ingresa un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un número de teléfono';
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
                      ? Center(child: Text('Seleccionar Imagen'))
                      : Image.file(_image!),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _createRefugio,
                child: const Text('Crear Refugio'),
              ),
            ],
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
