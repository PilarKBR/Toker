import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_helpers.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
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
          title: Text('Berita Terbaru',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
          elevation: 0,
          backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Container(
            height: displayHeight(context),
            width: displayWidth(context),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(children: [
                Expanded(
                  child: SizedBox(
                    height: displayHeight(context) *
                        0.8, // Sesuaikan dengan kebutuhan
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 3.0,
                          mainAxisSpacing: 3,
                          mainAxisExtent: 110,
                        ),
                        itemCount: 5,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, i) {
                          return Card(
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        child: Image.asset(
                                          'assets/065121128_PilarKukuhBintangRachmadi_DESGRAF_T1_V1.png',
                                          scale: 7,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Judul Berita',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                'Lorem, ipsum dolor sit amet consect adipisicing elit. Minima similique dicta maiores dolorem assumenda! Culpaneque',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ]))
                                  ],
                                ),
                              ));
                        }),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
