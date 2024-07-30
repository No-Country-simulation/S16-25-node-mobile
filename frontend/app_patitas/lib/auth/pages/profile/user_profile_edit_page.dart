import 'dart:io';
import 'package:app_patitas/auth/structures/controllers/auth_controller.dart';
import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/home/structures/controllers/refugio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileEditPage extends StatefulWidget {
  final Map<String, dynamic>? user;
  const UserProfileEditPage({super.key, required this.user});

  @override
  State<UserProfileEditPage> createState() => _UserProfilePageEditState();
}

class _UserProfilePageEditState extends State<UserProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  //final _fechaNacimientoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();
  //final _poseeAnimalesController = TextEditingController();
  //final _conviveMenoresController = TextEditingController();
  //final _patioController = TextEditingController();
  //final _dimensionesController = TextEditingController();
  //final _direccionController = TextEditingController();
  File? _imagePerfil;

  final ImagePicker _picker = ImagePicker();

  final refugioController = Get.find<RefugioController>();
  final authController = Get.find<AuthController>();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imagePerfil = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _nombreController.text = widget.user!['nombre'] ?? 'Sin Nombre';
    _telefonoController.text =
        widget.user!['telefono'].toString() ?? 'Sin Telefono';
    _correoController.text = widget.user!['email'] ?? 'Sin Correo';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _correoController,
                  decoration:
                      const InputDecoration(labelText: 'Correo Electronico'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu correo electronico';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _telefonoController,
                  decoration: const InputDecoration(labelText: 'Telefono'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu numero de telefono';
                    }
                    return null;
                  },
                ),
                /*const SizedBox(height: 16.0),
                TextFormField(
                  controller: _poseeAnimalesController,
                  decoration:
                      const InputDecoration(labelText: 'Tiene Animales'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa si tiene animales';
                    }
                    return null;
                  },
                ),*/
                /*const SizedBox(height: 16.0),
                TextFormField(
                  controller: _conviveMenoresController,
                  decoration:
                      const InputDecoration(labelText: 'Convive con Menores'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa si convive con menores';
                    }
                    return null;
                  },
                ),*/
                /* const SizedBox(height: 16.0),
                TextFormField(
                  controller: _patioController,
                  decoration: const InputDecoration(labelText: 'Tiene Patio'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa si tiene patio';
                    }
                    return null;
                  },
                ),*/
                /*const SizedBox(height: 16.0),
                TextFormField(
                  controller: _dimensionesController,
                  decoration:
                      const InputDecoration(labelText: 'Dimensiones del patio'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa las dimensiones del patio';
                    }
                    return null;
                  },
                ),*/
                /*const SizedBox(height: 16.0),
                TextFormField(
                  controller: _direccionController,
                  decoration: const InputDecoration(labelText: 'Direccion'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa su direccion';
                    }
                    return null;
                  },
                ),*/
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () => _showImageSourceDialog(context),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[200],
                    child: _imagePerfil == null
                        ? const Center(child: Text('Seleccionar Imagen'))
                        : Image.file(_imagePerfil!),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Const.primaryColorTextOrange,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          authController.editProfile(
                              nombre: _nombreController.text,
                              email: _correoController.text,
                              telefono: _telefonoController.text,
                              image: _imagePerfil!);
                        }
                      },
                      child: const Text('Guardar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {}
                      },
                      child: const Text('Cancelar'),
                    )
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
