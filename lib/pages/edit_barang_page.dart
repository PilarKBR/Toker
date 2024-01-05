import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coba1/pages/edit_barang_page_body.dart';

class EditBarang extends StatelessWidget {
  const EditBarang({super.key});

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
        title: Text('Edit Barang',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
        foregroundColor: Colors.black,
      ),
      body: const EditBarangBody(),
    );
  }
}
