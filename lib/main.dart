// ignore_for_file: prefer_const_constructors, unused_element
import 'package:coba1/pages/edit_profil.dart';
import 'package:coba1/pages/landing_page.dart';
import 'package:coba1/pages/login.dart';
import 'package:coba1/pages/profile_page.dart';
import 'package:coba1/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:coba1/spash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyCkilICXJb-oP6nk5pJ3DWYjx6mPmhb4cM",
            appId: "1:305241218894:android:ba5a609c9c24b6afca481f",
            messagingSenderId: "305241218894",
            projectId: "toker-5cd01",
            storageBucket: "toker-5cd01.appspot.com",
          ),
        )
      : await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(
            child: FirebaseAuth.instance.currentUser == null
                ? LandingPage()
                : HomePage()),
        '/login': (context) => LoginPage(),
        '/landing': (context) => LandingPage(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
        '/profile': (context) => IsiProfile(),
        '/editprofile': (context) => EditProfilePage(user: _auth.currentUser!),
      },
    );
  }
}
