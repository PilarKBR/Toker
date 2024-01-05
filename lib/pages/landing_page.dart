import 'package:coba1/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<String> images = [
    'assets/1700735199654.jpeg',
    'assets/1700735199665.jpg',
    'assets/1700735199678.jpg',
  ];

  late PageController _pageController;
  int currentIndex = 0;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);

    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      if (currentIndex < images.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutQuad,
      );
    });
  }

  @override
  void dispose() {
    // Hentikan timer dan controller saat widget dihapus
    timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: images.length + 1, // Tambah satu gambar palsu di akhir
            onPageChanged: (index) {
              setState(() {
                currentIndex = index % images.length;
              });
            },
            itemBuilder: (context, index) {
              return buildImage(
                  index == images.length ? images.first : images[index]);
            },
          ),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildImage(String imageUrl) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: 350,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromRGBO(251, 255, 194, 1).withOpacity(0.0),
              const Color.fromRGBO(251, 255, 194, 1).withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Konten atau elemen lainnya di atas gambar
              const Text(
                'Toker',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Selamat datang di Toko Serba Ada - Destinasi Utama untuk Keperluan Anda! Temukan keajaiban belanja dengan koleksi lengkap produk pilihan kami. Dari kebutuhan sehari-hari hingga hobi Anda, kami hadir untuk memenuhi semua keinginan Anda. Nikmati kenyamanan belanja tanpa batas, kualitas terjamin, dan harga terbaik di setiap sudut toko.\n\nToko Serba Ada - Tempat di mana keinginan Anda menjadi kenyataan.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 50,
                width: 380,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    backgroundColor: const Color.fromRGBO(227, 198, 48, 1),
                    elevation: 0,
                  ),
                  child: const Text(
                    'MULAI BELANJA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
            ]),
      ),
    );
  }

  Widget buildIndicator() {
    return Positioned(
      bottom: 16.0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          images.length,
          (index) => buildIndicatorItem(index),
        ),
      ),
    );
  }

  Widget buildIndicatorItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentIndex == index
              ? const Color.fromRGBO(227, 198, 48, 1)
              : Colors.grey,
        ),
      ),
    );
  }
}
