// ignore_for_file: prefer_final_fields, unused_field, use_build_context_synchronously

import 'package:coba1/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  DateTime? _selectedDate;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    // Populate controllers with current user data
    _nameController.text = widget.user.displayName ?? '';
    _emailController.text = widget.user.email ?? '';
    // Populate other fields if available in Firestore
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(widget.user.uid).get();

      if (userData.exists) {
        setState(() {
          _nikController.text = userData['nik'] ?? '';
          _phoneNumberController.text = userData['phoneNumber'] ?? '';
          _birthPlaceController.text = userData['birthPlace'] ?? '';
          Timestamp? dob = userData['dob'];
          _selectedDate = dob?.toDate();
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error fetching user data: $e');
    }
  }

  Future<void> _updateProfile() async {
    try {
      // Check if the user has filled out the required fields during registration
      if (_nikController.text.isEmpty ||
          _phoneNumberController.text.isEmpty ||
          _birthPlaceController.text.isEmpty ||
          _selectedDate == null) {
        Fluttertoast.showToast(msg: "Isi semua data yang diperlukan");
        return;
      }

      // Validasi NIK
      if (_nikController.text.length != 16) {
        Fluttertoast.showToast(msg: "NIK harus terdiri dari 16 digit");
        return;
      }

      // Validasi Email
      if (!_isValidEmail(_emailController.text)) {
        Fluttertoast.showToast(msg: "Email tidak valid");
        return;
      }

      // Validasi Password
      if (_passwordController.text.isNotEmpty ||
          _verifyPasswordController.text.isNotEmpty) {
        if (_passwordController.text.length < 8) {
          Fluttertoast.showToast(
              msg: "Password minimal terdiri dari 8 karakter");
          return;
        }

        if (_passwordController.text != _verifyPasswordController.text) {
          Fluttertoast.showToast(
              msg: "Password dan verifikasi password tidak cocok");
          return;
        }

        // Update password if it's provided
        await widget.user.updatePassword(_passwordController.text);
      }

      // Update data pengguna di Firebase Authentication
      await widget.user.updateDisplayName(_nameController.text);
      await widget.user.updateEmail(_emailController.text);

      // Update data pengguna di Firestore
      await _firestore.collection('users').doc(widget.user.uid).update({
        'name': _nameController.text,
        'nik': _nikController.text,
        'email': _emailController.text,
        'phoneNumber': _phoneNumberController.text,
        'birthPlace': _birthPlaceController.text,
        'dob': _selectedDate,
        // Tambahkan field lain yang ingin diubah di Firestore jika perlu
      });

      // Upload dan update foto profil jika ada
      String? profileImageUrl;
      if (_pickedImage != null) {
        profileImageUrl = await _uploadProfileImage(widget.user.uid);
        await widget.user.updatePhotoURL(profileImageUrl);
        await widget.user.reload();
      }

      Fluttertoast.showToast(msg: 'Profil diperbarui dengan sukses');
      Navigator.pop(context);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Gagal memperbarui profil: $e');
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

  Future<void> _selectImage() async {
    final XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = pickedImage;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1945, 8),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  bool _isValidEmail(String email) {
    // Contoh validasi sederhana untuk format email
    RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text('Edit Profil',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
        foregroundColor: Colors.black,
      ),
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
                              const InputDecoration(labelText: 'Nomor Telepon'),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 32),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Email',
                  //       style: GoogleFonts.poppins(),
                  //       textAlign: TextAlign.start,
                  //     ),
                  //   ],
                  // ),
                  // TextFormField(
                  //   controller: _emailController,
                  //   scrollPadding: EdgeInsets.only(
                  //       bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                  //   decoration: const InputDecoration(labelText: 'Email'),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Email cannot be empty';
                  //     } else if (!value.contains('@') || !value.contains('.')) {
                  //       return 'Invalid email format';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // const SizedBox(height: 32),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Ubah Password',
                  //       style: GoogleFonts.poppins(),
                  //       textAlign: TextAlign.start,
                  //     ),
                  //   ],
                  // ),
                  // TextFormField(
                  //   controller: _passwordController,
                  //   scrollPadding: EdgeInsets.only(
                  //       bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                  //   obscureText: passwordVisible,
                  //   decoration: InputDecoration(
                  //     border: const UnderlineInputBorder(),
                  //     hintText: "Ubah Password",
                  //     helperStyle: const TextStyle(color: Colors.green),
                  //     suffixIcon: IconButton(
                  //       icon: Icon(passwordVisible
                  //           ? Icons.visibility
                  //           : Icons.visibility_off),
                  //       onPressed: () {
                  //         setState(
                  //           () {
                  //             passwordVisible = !passwordVisible;
                  //           },
                  //         );
                  //       },
                  //     ),
                  //     alignLabelWithHint: false,
                  //     filled: true,
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Password cannot be empty';
                  //     } else if (value.length < 8) {
                  //       return 'Password must be at least 8 characters';
                  //     }
                  //     return null;
                  //   },
                  //   keyboardType: TextInputType.visiblePassword,
                  //   textInputAction: TextInputAction.done,
                  // ),
                  // const SizedBox(height: 32),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Verifikasi Password',
                  //       style: GoogleFonts.poppins(),
                  //       textAlign: TextAlign.start,
                  //     ),
                  //   ],
                  // ),
                  // TextFormField(
                  //   controller: _verifyPasswordController,
                  //   scrollPadding: EdgeInsets.only(
                  //       bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                  //   obscureText: passwordVisible,
                  //   decoration: InputDecoration(
                  //     border: const UnderlineInputBorder(),
                  //     hintText: "Verifikasi Password",
                  //     helperStyle: const TextStyle(color: Colors.green),
                  //     suffixIcon: IconButton(
                  //       icon: Icon(passwordVisible
                  //           ? Icons.visibility
                  //           : Icons.visibility_off),
                  //       onPressed: () {
                  //         setState(
                  //           () {
                  //             passwordVisible = !passwordVisible;
                  //           },
                  //         );
                  //       },
                  //     ),
                  //     alignLabelWithHint: false,
                  //     filled: true,
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Verify Password cannot be empty';
                  //     } else if (value != _passwordController.text) {
                  //       return 'Passwords do not match';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const SizedBox(height: 64),
                  SizedBox(
                    height: 50,
                    width: 280,
                    child: ElevatedButton(
                      onPressed: () {
                        _updateProfile();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        backgroundColor: const Color.fromRGBO(227, 198, 48, 1),
                      ),
                      child: const Text(
                        'UBAH PROFIL',
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
}
