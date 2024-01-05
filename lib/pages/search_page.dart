// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isVisible = false;
  List<Widget> cards = [];
  int cardCount = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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
          centerTitle: true,
          title: Text('List Barang',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
          elevation: 0,
          backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
          foregroundColor: Colors.black,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                      },
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 3,
                      mainAxisExtent: 310,
                    ),
                    itemCount: 5,
                    itemBuilder: (ctx, i) {
                      return Card(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: SizedBox(
                          height: 200,
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
                                          color: const Color.fromRGBO(
                                              202, 27, 27, 1),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Rp13.000,-',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.lineThrough),
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
                      );
                    }),
              ),
            ]))
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
