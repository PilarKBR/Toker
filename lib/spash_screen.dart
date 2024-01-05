import 'package:coba1/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child!),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
            padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromRGBO(251, 255, 194, 1)),
            child: Center(
                child: Column(
              children: [
                Container(
                  height: displayHeight(context) / 2.5,
                ),
                Image.asset(
                  'assets/065121128_PilarKukuhBintangRachmadi_DESGRAF_T1_V1.png',
                  scale: 5,
                ),
                Container(
                  height: displayHeight(context) / 3,
                ),
                Text(
                  'Toker',
                  style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                ),
                Text('V 5.8.0.5',
                    style:
                        GoogleFonts.poppins(fontSize: 15, color: Colors.black))
              ],
            ))));
  }
}
