// ignore_for_file: prefer_final_fields, unused_field, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba1/size_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  bool passwordVisible = false;
  XFile? _pickedImage;
  DateTime? _selectedDate;

  Future<void> _selectImage() async {
    final XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = pickedImage;
    });
  }

  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String? profileImageUrl;
      if (_pickedImage != null) {
        profileImageUrl = await _uploadProfileImage(userCredential.user!.uid);
        await userCredential.user!.updatePhotoURL(profileImageUrl);
        await userCredential.user!.reload();
      }

      String name = _nameController.text.trim();
      String nik = _nikController.text.trim();
      String email = _emailController.text.trim();
      String phoneNumber = _phoneNumberController.text.trim();
      String birthPlace = _birthPlaceController.text.trim();

      if (name.isEmpty ||
          nik.isEmpty ||
          email.isEmpty ||
          phoneNumber.isEmpty ||
          birthPlace.isEmpty ||
          _selectedDate == null) {
        Fluttertoast.showToast(
            msg: 'All fields, including profile image, must be filled');
        return;
      }
      if (_nameController.text.isEmpty ||
          _nikController.text.length != 16 ||
          _emailController.text.isEmpty ||
          !_emailController.text.contains('@') ||
          !_emailController.text.contains('.') ||
          _passwordController.text.length < 8 ||
          _verifyPasswordController.text != _passwordController.text ||
          _selectedDate == null) {
        Fluttertoast.showToast(msg: 'Please fix the errors before proceeding');
        return;
      }

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'nik': nik,
        'email': email,
        'phoneNumber': phoneNumber,
        'birthPlace': birthPlace,
        'dob': _selectedDate,
        'profileImageUrl': profileImageUrl,
      });

      Fluttertoast.showToast(msg: 'Sign Up Successful');
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<String?> _uploadProfileImage(String userId) async {
    try {
      String imagePath = 'profile_images/$userId.jpg';
      await FirebaseStorage.instance
          .ref(imagePath)
          .putFile(File(_pickedImage!.path));
      return await FirebaseStorage.instance.ref(imagePath).getDownloadURL();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error uploading profile image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Container(
            width: displayWidth(context) - 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomLeft,
                opacity: 0.2,
                scale: 1.8,
                image: AssetImage(
                  'assets/065121128_PilarKukuhBintangRachmadi_DESGRAF_T1_V1.png',
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 25, 100),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    'assets/065121128_PilarKukuhBintangRachmadi_DESGRAF_T1_V2.png',
                    scale: 5,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Registrasi Akun',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Silahkan registrasi akun sesuai dengan data diri Anda',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Foto Profil',
                        style: GoogleFonts.poppins(),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _selectImage();
                    },
                    child: _pickedImage != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                FileImage(File(_pickedImage!.path)),
                          )
                        : const CircleAvatar(
                            radius: 50,
                            child: Icon(Icons.camera_alt),
                          ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Nama',
                        style: GoogleFonts.poppins(),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _nameController,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                    decoration: const InputDecoration(labelText: 'Nama'),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Text(
                        'NIK',
                        style: GoogleFonts.poppins(),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _nikController,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                    decoration: const InputDecoration(labelText: 'NIK'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'NIK cannot be empty';
                      } else if (value.length != 16) {
                        return 'NIK must be 16 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Text(
                        'Tanggal Lahir',
                        style: GoogleFonts.poppins(),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("${_selectedDate?.toLocal()}".split(' ')[0],
                          style: const TextStyle(fontSize: 16)),
                      SizedBox(
                        width: displayWidth(context) - 230,
                      ),
                      IconButton(
                        onPressed: () => _selectDate(context),
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Tempat Lahir',
                        style: GoogleFonts.poppins(),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _birthPlaceController,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                    decoration:
                        const InputDecoration(labelText: 'Tempat Lahir'),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Text(
                        'No. Telepon',
                        style: GoogleFonts.poppins(),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: _phoneNumberController,
                          decoration:
                              const InputDecoration(labelText: 'Phone Number'),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Text(
                        'Email',
                        style: GoogleFonts.poppins(),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _emailController,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email cannot be empty';
                      } else if (!value.contains('@') || !value.contains('.')) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Text(
                        'Buat Password',
                        style: GoogleFonts.poppins(),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _passwordController,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: "Buat Password",
                      helperStyle: const TextStyle(color: Colors.green),
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                      alignLabelWithHint: false,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Text(
                        'Verifikasi Password',
                        style: GoogleFonts.poppins(),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _verifyPasswordController,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: "Verifikasi Password",
                      helperStyle: const TextStyle(color: Colors.green),
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                      alignLabelWithHint: false,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Verify Password cannot be empty';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 64),
                  SizedBox(
                    height: 50,
                    width: 280,
                    child: ElevatedButton(
                      onPressed: () {
                        _signUp();
                        Navigator.pushNamed(context, "/login");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        backgroundColor: const Color.fromRGBO(227, 198, 48, 1),
                      ),
                      child: const Text(
                        'REGISTRASI',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1945, 8),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
}
