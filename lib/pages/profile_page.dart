// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba1/pages/admin.dart';
import 'package:coba1/pages/home_page.dart';
import 'package:coba1/size_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [const HomePage(), const IsiProfile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
      body: _children[_selectedIndex],
    );
  }
}

class IsiProfile extends StatefulWidget {
  final User? user;
  const IsiProfile({super.key, this.user});

  @override
  State<IsiProfile> createState() => _IsiProfileState();
}

class _IsiProfileState extends State<IsiProfile> {
  bool isVerified = false;
  final TextEditingController _kodeController = TextEditingController();
  late User? _user;
  Future<DocumentSnapshot<Map<String, dynamic>>>
      getUserDataFromFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Mengambil dokumen pengguna dari Firestore
        return await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
      } else {
        // Mengembalikan dokumen kosong jika pengguna tidak terautentikasi
        return FirebaseFirestore.instance.doc('users/empty').get();
      }
    } catch (e) {
      // Mengembalikan dokumen kosong jika terjadi kesalahan
      return FirebaseFirestore.instance.doc('users/empty').get();
    }
  }

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 35),
                    child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white,
                        ),
                        height: displayHeight(context),
                        width: 360,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 30),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: _user?.photoURL != null
                                      ? NetworkImage(_user!.photoURL!)
                                      : const AssetImage(
                                              'assets/065121128_PilarKukuhBintangRachmadi_DESGRAF_T1_V1.png')
                                          as ImageProvider,
                                ),
                                const SizedBox(height: 20),
                                FutureBuilder<
                                        DocumentSnapshot<Map<String, dynamic>>>(
                                    future: getUserDataFromFirestore(),
                                    builder: (context, snapshot) {
                                      var userData = snapshot.data?.data();
                                      return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${userData?['name'] ?? "N/A"}',
                                              style: GoogleFonts.poppins(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${userData?['email'] ?? "N/A"} | '
                                                    '${userData?['phoneNumber'] ?? "N/A"}',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ]),
                                          ]);
                                    }),
                                const SizedBox(height: 20),
                                Text(
                                  isVerified ? 'Admin' : 'Pelanggan',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  height: 50,
                                  width: 283,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/editprofile',
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        backgroundColor: const Color.fromRGBO(
                                            227, 198, 48, 1),
                                        foregroundColor: Colors.black),
                                    child: const Text(
                                      'EDIT PROFIL',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 283,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.pushNamed(context, "/landing");
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        backgroundColor: const Color.fromRGBO(
                                            202, 27, 27, 1),
                                        foregroundColor: Colors.white),
                                    child: const Text(
                                      'KELUAR',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    Text(
                                      'Verifikasi Admin',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(),
                                      // semanticsLabel: ,
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  controller: _kodeController,
                                  scrollPadding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  decoration: const InputDecoration(
                                    labelText: 'Masukkan kode dari Admin',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 283,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_kodeController.text == '123') {
                                        setState(() {
                                          isVerified = true;
                                        });
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminPage()));
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'Kata Sandi Salah');
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        backgroundColor: const Color.fromRGBO(
                                            227, 198, 48, 1),
                                        foregroundColor: Colors.black),
                                    child: const Text(
                                      'VERIFIKASI',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))),
              )
            ])));
  }

  Future<void> ensureVisibleOnTextArea(
      {required GlobalKey textfieldKey}) async {
    final keyContext = textfieldKey.currentContext;
    if (keyContext != null) {
      await Future.delayed(const Duration(milliseconds: 500)).then(
        (value) => Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 200),
          curve: Curves.decelerate,
        ),
      );
    }
  }
}
