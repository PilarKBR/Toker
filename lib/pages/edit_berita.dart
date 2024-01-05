import 'package:coba1/pages/list_berita.dart';
import 'package:coba1/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBeritaBody extends StatefulWidget {
  const EditBeritaBody({super.key});

  @override
  State<EditBeritaBody> createState() => _EditBeritaBodyState();
}

class _EditBeritaBodyState extends State<EditBeritaBody> {
  bool checkboxValue1 = false;

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
          title: Text('Edit Berita',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
          elevation: 0,
          backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 0, left: 0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  height: displayHeight(context) * 1.5,
                  width: 450,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Foto Berita',
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
                                      backgroundColor: const Color.fromRGBO(
                                          217, 217, 217, 1),
                                      foregroundColor: Colors.black),
                                  child:
                                      const Icon(Icons.photo_camera_outlined),
                                ),
                              )
                            ],
                          ),
                          Container(height: 25),
                          Row(
                            children: [
                              Text(
                                'Judul Berita',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(),
                              ),
                            ],
                          ),
                          const Column(children: [TextField()]),
                          Container(height: 25),
                          Row(
                            children: [
                              Text(
                                'Deskripsi Berita',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(),
                              ),
                            ],
                          ),
                          Column(children: [
                            TextField(
                              maxLines: 20,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                          ]),
                          Container(height: 25),
                          SizedBox(
                            height: 50,
                            width: 295,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ListBeritaPage()));
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  backgroundColor:
                                      const Color.fromRGBO(227, 198, 48, 1),
                                  foregroundColor: Colors.black),
                              child: const Text(
                                'UBAH BERITA',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
