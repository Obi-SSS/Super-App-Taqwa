import 'dart:async'; //timer coundown
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; //caroulsel slider
import 'package:http/http.dart' as http; //mengambil data
import 'package:geolocator/geolocator.dart'; //decade json
import 'package:geocoding/geocoding.dart'; //GPS
import 'package:intl/intl.dart'; //formater nummber
import 'package:permission_handler/permission_handler.dart'; //izin handler
import 'package:shared_preferences/shared_preferences.dart'; // chace lokal
import 'package:string_similarity/string_similarity.dart'; //fuzzy match

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _controllera = CarouselController();
  int _currentIndex = 0;

  final icDOa = 'assets/images/ic_menu_doa.png';

  final posterList = const <String>[
    'assets/images/idl-adh.png',
    'assets/images/idl-fotr.png',
    'assets/images/ramadan-kareem.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widget(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // ===========================
                // menu waktu sholat by Lokasi
                // ===========================
                _buildHeroSection(),

                /**
                 * ===================
                 * MENU SECTION
                 * ===================
                 */
                _buildMenuGridSection(),

                // =======================
                //  menu hero wiget
                // ========================

                // =======================
                // menu item wiget
                // =======================
                _buildCarouselSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //================
  //menu hero wiget
  //================
  Widget _buildHeroSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 290,
          decoration: BoxDecoration(
            color: Color(0xFFB3E5FC),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            image: DecorationImage(image: AssetImage('assets/images/bg-afternoon.png'),        
            fit: BoxFit.cover
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Assalamu\'alaikum',
                  style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  'Ngargoyoso',
                  style: TextStyle(fontFamily: 'PoppinsSemiBold', fontSize: 22,color: Colors.white),
                ),
                Text(
                  DateFormat('HH:mm').format(DateTime.now()),
                  style: TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 50,
                    height: 1.2,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(String iconPath, String title, String routeName) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.amber.withOpacity(0.2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconPath, width: 35),
              const SizedBox(height: 6),
              Text(
                'title',
                style: TextStyle(fontFamily: 'PoppinsRegular', fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuGridSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildMenuItem(
            'assets/images/ic_menu_doa.png', //title
            'doa harian', //item path
            '/doa', //route name
          ),
          _buildMenuItem(
            'assets/images/ic_menu_jadwal_sholat.png',
            'Jadwal sholat',
            '/doa',
          ),
          _buildMenuItem(
            'assets/images/ic_menu_video_kajian.png',
            'Video kajian',
            '/doa',
          ),
          _buildMenuItem('assets/images/ic_menu_zakat.png', 'Zakat', '/doa'),
          _buildMenuItem(
            'assets/images/ic_menu_doa.png', //title
            'doa harian', //item path
            '/doa', //route name
          ),
        ],
      ),
    );
  }

  //===========================
  //CAROULSEL SECTION WIGET
  //===========================

  Widget _buildCarouselSection() {
    return Column(
      children: [
        const SizedBox(height: 20),
        CarouselSlider.builder(
          itemCount: posterList.length,
          itemBuilder: (context, index, realIndex) {
            final poster = posterList[index];
            return Container(
              child: Container(
                margin: EdgeInsets.all(15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    poster,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            height: 300,
            enlargeCenterPage: true,
            viewportFraction: 0.7,
            onPageChanged: (index, reason) => {
              setState(() => _currentIndex = index),
            },
          ),
        ),

        //dot indikator coroulsel
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: posterList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _currentIndex.animateToPage(entry.key),
              child: Container(
                height: 10,
                width: 10,
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.amber
                      : Colors.grey[400],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

extension on int {
  void animateToPage(int key) {}
}
