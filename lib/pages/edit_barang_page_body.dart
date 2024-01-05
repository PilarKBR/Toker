import 'package:coba1/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coba1/pages/status_barang_page.dart';

enum HargaCharacter { diskon, turun }

enum PromoCharacter { minggu, member, kosong }

class EditBarangBody extends StatefulWidget {
  const EditBarangBody({super.key});

  @override
  State<EditBarangBody> createState() => _EditBarangBodyState();
}

class _EditBarangBodyState extends State<EditBarangBody> {
  bool checkboxValue1 = false;
  HargaCharacter? _character;
  PromoCharacter? _promoCharacter;
  bool _isChecked = false;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
        MaterialState.selected
      };
      if (states.any(interactiveStates.contains)) {
        return const Color.fromRGBO(217, 217, 217, 1);
      }

      return Colors.transparent;
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Container(
            width: displayWidth(context),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      'Foto Produk',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(),
                    ),
                  ],
                ),
                Container(height: 6),
                Column(
                  children: [
                    SizedBox(
                      height: 295,
                      width: 295,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(217, 217, 217, 1),
                            foregroundColor: Colors.black),
                        child: const Icon(Icons.photo_camera_outlined),
                      ),
                    )
                  ],
                ),
                Container(height: 25),
                Row(
                  children: [
                    Text(
                      'Nama Produk',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(),
                    ),
                  ],
                ),
                const Column(children: [TextField()]),
                Container(height: 25),
                CheckboxListTile(
                  title: const Text('Ubah Harga'),
                  checkColor: Colors.black,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value!;
                      _isExpanded = _isChecked;
                    });
                  },
                ),
                GestureDetector(
                    onTap: () {
                      if (_isChecked) {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      }
                    },
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: _isExpanded ? 450 : 0,
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    'Nominal Perubahan Harga',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(),
                                  ),
                                ],
                              ),
                              const TextField(),
                              const Divider(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Metode Perubahan Harga',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(),
                                  ),
                                ],
                              ),
                              Column(children: <Widget>[
                                RadioListTile<HargaCharacter>(
                                  title: const Text('Diskon'),
                                  value: HargaCharacter.diskon,
                                  groupValue: _character,
                                  onChanged: (HargaCharacter? value) {
                                    setState(() {
                                      _character = value;
                                    });
                                  },
                                ),
                                RadioListTile<HargaCharacter>(
                                  title: const Text('Penurunan Harga'),
                                  value: HargaCharacter.turun,
                                  groupValue: _character,
                                  onChanged: (HargaCharacter? value) {
                                    setState(() {
                                      _character = value;
                                    });
                                  },
                                ),
                              ]),
                              const Divider(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Jenis Promo yang Akan Berlangsung',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(),
                                  ),
                                ],
                              ),
                              Column(children: <Widget>[
                                RadioListTile<PromoCharacter>(
                                  title: const Text('Promo Minggu Ini'),
                                  value: PromoCharacter.minggu,
                                  groupValue: _promoCharacter,
                                  onChanged: (PromoCharacter? value) {
                                    setState(() {
                                      _promoCharacter = value;
                                    });
                                  },
                                ),
                                RadioListTile<PromoCharacter>(
                                  title: const Text('Promo Khusus Member'),
                                  value: PromoCharacter.member,
                                  groupValue: _promoCharacter,
                                  onChanged: (PromoCharacter? value) {
                                    setState(() {
                                      _promoCharacter = value;
                                    });
                                  },
                                ),
                                RadioListTile<PromoCharacter>(
                                  title: const Text('Tidak Ada'),
                                  value: PromoCharacter.kosong,
                                  groupValue: _promoCharacter,
                                  onChanged: (PromoCharacter? value) {
                                    setState(() {
                                      _promoCharacter = value;
                                    });
                                  },
                                ),
                              ])
                            ],
                          ),
                        ))),
                Container(height: 90),
                SizedBox(
                  height: 50,
                  width: 295,
                  child: ElevatedButton(
                    onPressed: () {
                      // oncardBarang();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const StatusBarangPage()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        backgroundColor: const Color.fromRGBO(227, 198, 48, 1),
                        foregroundColor: Colors.black),
                    child: const Text(
                      'UBAH',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
