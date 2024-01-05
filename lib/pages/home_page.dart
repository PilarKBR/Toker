// import 'dart:async';

// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba1/addons_carousel.dart';
import 'package:coba1/pages/admin.dart';
import 'package:coba1/pages/berita.dart';
import 'package:coba1/pages/idcard_page.dart';
import 'package:coba1/pages/profile_page.dart';
import 'package:coba1/pages/promo_member.dart';
import 'package:coba1/pages/promo_minggu.dart';
import 'package:coba1/pages/riwayat_page.dart';
import 'package:coba1/pages/search_page.dart';
import 'package:coba1/size_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [const IsiHomePage(), const Profile()];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _children[_selectedIndex],
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: BottomNavigationBar(
                selectedItemColor: Colors.black,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Beranda',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profil',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          SizedBox(
            child: FittedBox(
              child: FloatingActionButton(
                  backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
                  foregroundColor: Colors.black,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const IdCardPage()));
                  },
                  child: Image.asset(
                    'assets/barcode_scanner_FILL0_wght400_GRAD0_opsz24.png',
                    scale: 0.8,
                  )),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Kartu',
          ),
          const SizedBox(
            height: 8,
          ),
        ]));
  }
}

class IsiHomePage extends StatefulWidget {
  const IsiHomePage({super.key});

  @override
  State<IsiHomePage> createState() => _IsiHomePageState();
}

class _IsiHomePageState extends State<IsiHomePage> {
  Future<DocumentSnapshot<Map<String, dynamic>>>
      getUserDataFromFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Mengambil dokumen pengguna dari Firestore
        return await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
      } else {
        // Mengembalikan dokumen kosong jika pengguna tidak terautentikasi
        return FirebaseFirestore.instance.doc('users/empty').get();
      }
    } catch (e) {
      // Mengembalikan dokumen kosong jika terjadi kesalahan
      return FirebaseFirestore.instance.doc('users/empty').get();
    }
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late PageController _pageController;
  int _currentIndex = 0;

  List cardList = [const Item1(), const Item2(), const Item3()];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
        appBar: AppBar(
          elevation: 0,
          leading: Image.asset(
            'assets/065121128_PilarKukuhBintangRachmadi_DESGRAF_T1_V1.png',
            scale: 15,
          ),
          backgroundColor: const Color.fromRGBO(251, 255, 194, 1),
          title: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: getUserDataFromFirestore(),
              builder: (context, snapshot) {
                var userData = snapshot.data?.data();
                return Text(
                  'Hi, ${userData?['name'] ?? "N/A"}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                );
              }),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SearchPage()));
              },
            ),
            Builder(builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              );
            })
          ],
          foregroundColor: Colors.black,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Column(children: [
              Column(
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                      height: displayHeight(context) * 0.23,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 10),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1000),
                      autoPlayCurve: Curves.easeInOutQuad,
                      pauseAutoPlayOnTouch: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: cardList.map((card) {
                      return Builder(builder: (BuildContext context) {
                        return SizedBox(
                          height: displayHeight(context) * 0.30,
                          width: displayWidth(context),
                          child: Card(
                            color: Colors.blueAccent,
                            child: card,
                          ),
                        );
                      });
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(cardList, (index, url) {
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.blueAccent
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              Container(
                height: displayHeight(context) * 1.7,
                width: displayWidth(context),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16.0,
                    20.0,
                    16.0,
                    16.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Promo Minggu Ini',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PromoMingguPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Lihat Semua',
                                style: TextStyle(fontSize: 12),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: displayHeight(context) *
                            0.31, // Sesuaikan dengan kebutuhan
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.0,
                            crossAxisSpacing: 3.0,
                            mainAxisSpacing: 3,
                            mainAxisExtent: displayWidth(context) * 0.39,
                          ),
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (ctx, i) {
                            return Card(
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: SizedBox(
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
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, bottom: 8, right: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Salak',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Rp10.000,-',
                                            style: GoogleFonts.poppins(
                                                color: const Color.fromRGBO(
                                                    202, 27, 27, 1),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Rp13.000,-',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              'Periode 23/10 - 30/10',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 9),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Promo Khusus Member',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PromoMemberPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Lihat Semua',
                                style: TextStyle(fontSize: 12),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: displayHeight(context) *
                            0.31, // Sesuaikan dengan kebutuhan
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.0,
                            crossAxisSpacing: 3.0,
                            mainAxisSpacing: 3,
                            mainAxisExtent: displayWidth(context) * 0.39,
                          ),
                          itemCount: 5,
                          itemBuilder: (ctx, i) {
                            return Card(
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: SizedBox(
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
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, bottom: 8, right: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Salak',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Rp10.000,-',
                                            style: GoogleFonts.poppins(
                                                color: const Color.fromRGBO(
                                                    202, 27, 27, 1),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Rp13.000,-',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              'Periode 23/10 - 30/10',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 9),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Berita Terbaru',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const BeritaPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Lihat Semua',
                                style: TextStyle(fontSize: 12),
                              ))
                        ],
                      ),
                      SizedBox(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
        endDrawer: Drawer(
          backgroundColor: const Color.fromRGBO(220, 224, 145, 1),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 100,
              ),
              ListTile(
                title: Row(children: [
                  const Icon(Icons.receipt_long),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Riwayat Transaksi',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ]),
                selected: _selectedIndex == 0,
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RiwayatPage()));
                },
              ),
              ListTile(
                title: Row(children: [
                  const Icon(Icons.inventory_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Admin',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ]),
                selected: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                  //buat develop ke backendnya bikin if else statement jika dia user/admin navigatornya
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AdminPage()));
                },
              ),
            ],
          ),
        ));
  }
}
