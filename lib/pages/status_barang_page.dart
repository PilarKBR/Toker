// ignore_for_file: unused_field

import 'package:coba1/size_helpers.dart';
import 'package:flutter/material.dart';
import 'package:coba1/pages/tambah_barang_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coba1/pages/edit_barang_page.dart';

// Ini buat mancing si titlenya ke search
// onChanged: (value) {
//           setState(() {
//             _searchQuery = value;
//           });
//         },

class StatusBarangPage extends StatefulWidget {
  const StatusBarangPage({super.key});

  @override
  State<StatusBarangPage> createState() => _StatusBarangPageState();
}

class _StatusBarangPageState extends State<StatusBarangPage> {
  bool _isVisible = false;
  List<Widget> cards = [];
  int cardCount = 0;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';
  Widget _buildSearchField() {
    return SizedBox(
      width: 400,
      height: 40, // Sesuaikan lebar sesuai kebutuhan
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
            hintText: 'Cari Barang...', border: UnderlineInputBorder()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: _isSearching
                ? const Icon(Icons.close)
                : const Icon(Icons.search),
            onPressed: () {
              // Tampilkan atau sembunyikan field pencarian berdasarkan keadaan
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = '';
                }
              });
            },
          )
        ],
        centerTitle: true,
        title: _isSearching
            ? _buildSearchField()
            : Text('Status Barang',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3,
              mainAxisExtent: displayHeight(context) * 0.38,
            ),
            itemCount: 5,
            itemBuilder: (ctx, i) {
              return Card(
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: SizedBox(
                  height: displayHeight(context) - 665,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/snakefruit_bali_direct.jpg',
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Visibility(
                                    visible: _isVisible,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 45,
                                          width: 45,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                ),
                                                backgroundColor:
                                                    const Color.fromRGBO(0, 75,
                                                        255, 1), // background
                                                foregroundColor:
                                                    Colors.white, // foreground
                                                padding:
                                                    const EdgeInsets.all(8.0)),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const EditBarang()));
                                            },
                                            child: const Icon(
                                              Icons.edit_square,
                                              fill: 0,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        SizedBox(
                                            height: 45,
                                            width: 45,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                  ),
                                                  minimumSize:
                                                      const Size(40, 40),
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          220,
                                                          25,
                                                          25,
                                                          1), // background
                                                  foregroundColor: Colors
                                                      .white, // foreground
                                                  padding: const EdgeInsets.all(
                                                      8.0)),
                                              onPressed: () {},
                                              child: const Icon(Icons.delete),
                                            ))
                                      ],
                                    ),
                                  ),
                                ])),
                        const Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, bottom: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Salak',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Rp10.000,-',
                                style: GoogleFonts.poppins(
                                    color: const Color.fromRGBO(202, 27, 27, 1),
                                    fontWeight: FontWeight.w700),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Rp13.000,-',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'Periode 23/10 - 30/10',
                                  style: GoogleFonts.poppins(fontSize: 9),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),

      // Column(
      //   children: [
      //     Expanded(
      //       flex: 2,
      //       child: ListView.builder(
      //         itemCount: cards.length,
      //         itemBuilder: (context, index) {
      //           return cards[index];
      //         },
      //         scrollDirection:
      //             cardCount % 2 == 0 ? Axis.horizontal : Axis.vertical,
      //       ),
      //     )
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TambahBarang(cardBarang)));
        },
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromRGBO(227, 198, 48, 1),
        child: const Icon(Icons.add),
      ),
    );
  }

  void cardBarang() {
    cards.add(
      Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Image.asset(
                      'assets/snakefruit_bali_direct.jpg',
                      fit: BoxFit.cover,
                    ),
                    Visibility(
                      visible: _isVisible,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  backgroundColor: const Color.fromRGBO(
                                      0, 75, 255, 1), // background
                                  foregroundColor: Colors.white, // foreground
                                  padding: const EdgeInsets.all(8.0)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const EditBarang()));
                              },
                              child: const Icon(
                                Icons.edit_square,
                                fill: 0,
                              ),
                            ),
                          ),
                          Container(
                            height: 5,
                          ),
                          SizedBox(
                              height: 45,
                              width: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    minimumSize: const Size(40, 40),
                                    backgroundColor: const Color.fromRGBO(
                                        220, 25, 25, 1), // background
                                    foregroundColor: Colors.white, // foreground
                                    padding: const EdgeInsets.all(8.0)),
                                onPressed: () {},
                                child: const Icon(Icons.delete),
                              ))
                        ],
                      ),
                    ),
                  ])),
              const Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Salak',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Rp10.000,-',
                      style: GoogleFonts.poppins(
                          color: const Color.fromRGBO(202, 27, 27, 1),
                          fontWeight: FontWeight.w700),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Rp13.000,-',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Periode 23/10 - 30/10',
                        style: GoogleFonts.poppins(fontSize: 9),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    setState(() {
      cardCount++;
    });
  }
}
