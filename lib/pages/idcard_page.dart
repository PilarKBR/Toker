import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IdCardPage extends StatelessWidget {
  const IdCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              'ID Kartu Anda',
              style: GoogleFonts.poppins(
                  fontSize: 32, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 80,
            ),
            Image.asset('assets/Code-2of5 Interleaved 1.png'),
            const SizedBox(
              height: 80,
            ),
            Text(
              'Catatan: \n\nTunjukkan Barcode ID Kartu Anda Kepada Kasir untuk mendapatkan potongan harga pada barang tertentu jika sedang ada promo',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
            )
          ]),
        ));
  }
}
