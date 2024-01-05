// ignore_for_file: prefer_final_fields, unused_field, use_build_context_synchronously

import 'package:coba1/auth_controllers.dart';
import 'package:coba1/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: displayHeight(context) - 60,
            width: displayWidth(context) - 50,
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.bottomLeft,
                    opacity: 0.2,
                    scale: displayWidth(context) / 125,
                    image: const AssetImage(
                      'assets/065121128_PilarKukuhBintangRachmadi_DESGRAF_T1_V1.png',
                    )),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Flexible(
                  flex: 1,
                  child: Image.asset(
                    'assets/065121128_PilarKukuhBintangRachmadi_DESGRAF_T1_V2.png',
                    scale: displayWidth(context) / 50,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Selamat Datang',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  'Silahkan login dengan akun yang terdaftar',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _passwordController,
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 45),
                SizedBox(
                  height: 50,
                  width: 280,
                  child: ElevatedButton(
                    onPressed: () {
                      _signIn();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      backgroundColor: const Color.fromRGBO(227, 198, 48, 1),
                    ),
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  child: const Text('Belum punya akun? Registrasi sekarang'),
                ),
              ],
            ),
          ),
        ));
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      const SnackBar(content: Text("User is successfully signed in"));
      Navigator.pushNamed(context, "/home");
    } else {
      const SnackBar(content: Text("some error occured"));
    }
  }
}
