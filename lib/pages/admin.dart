import 'package:coba1/pages/list_berita.dart';
import 'package:coba1/pages/status_barang_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_helpers.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

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
          elevation: 0,
          backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
          foregroundColor: Colors.black,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: displayHeight(context) - 100,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/065121128_PilarKukuhBintangRachmadi_DESGRAF_T1_V2.png',
                  scale: displayWidth(context) / 60,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Konfigurasi Admin',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  'Pilih Data Apa yang Akan Anda Ubah',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: 280,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const StatusBarangPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      backgroundColor: const Color.fromRGBO(227, 198, 48, 1),
                    ),
                    child: const Text(
                      'BARANG',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: 280,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ListBeritaPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      backgroundColor: const Color.fromRGBO(227, 198, 48, 1),
                    ),
                    child: const Text(
                      'BERITA',
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
        ));
  }
}
