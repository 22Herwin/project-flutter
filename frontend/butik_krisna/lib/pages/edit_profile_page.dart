import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool isPasswordVisible = false;
  bool isLoading = false;
  String? errorMessage;

  File? _image;
  Uint8List? _base64Image;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }

  Future<void> uploadImage() async {
    if (_image == null) return;

    final uri = Uri.parse('http://192.168.149.69:3000/users/upload/${widget.user["id"]}');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', _image!.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final updatedUser = json.decode(responseData);
      widget.user['image'] = updatedUser['image']; // Update local image data
    } else {
      throw Exception('Image upload failed');
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user['name']);
    emailController = TextEditingController(text: widget.user['email']);
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



  Future<void> saveProfile() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Upload image first if selected
      if (_image != null) {
        await uploadImage();
      }

      // Update profile data
      final response = await http.put(
        Uri.parse('http://192.168.149.69:3000/users/${widget.user["id"]}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          if (passwordController.text.isNotEmpty)
            'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        // Return merged data (server response + local image)
        Navigator.pop(context, {
          ...responseBody,
          'image': widget.user['image'] // Include updated image
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred while updating profile';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage!), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildTextField(
      String label, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      maxLength: isPassword ? 8 : null,
      decoration: InputDecoration(
        labelText: label,
        counterText: isPassword ? '${controller.text.length}/8' : null,
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        )
            : null,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (_) {
        if (isPassword) setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = widget.user['profileImage'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 10),

              // Avatar
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : widget.user['image'] != null && widget.user['image'].isNotEmpty
                        ? MemoryImage(base64.decode(widget.user['image']))
                        : const AssetImage('assets/avatar_placeholder.png') as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, size: 20, color: Colors.black),
                      onPressed: pickImage,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),
              const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(errorMessage!,
                      style: const TextStyle(color: Colors.red)),
                ),

              buildTextField('Name', nameController),
              const SizedBox(height: 20),
              buildTextField('Email', emailController),
              const SizedBox(height: 20),
              buildTextField('New Password (optional)', passwordController,
                  isPassword: true),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 50,
                child:
                ElevatedButton.icon(
                  icon: const Icon(Icons.lock_outlined, color: Colors.white),
                  label: Text(
                      'Save Change',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                    )),
                  onPressed: isLoading ? null : saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: GoogleFonts.poppins(),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
