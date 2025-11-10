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

  final posterList = const <String>[
    'assets/images/ramadan-kareem.png',
    'assets/images/idl-adh.png',
    'assets/images/idh-fitr.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            /**
             * ===================
             * MENU SECTION
             * ===================
             */
            _buildMenuGridSection(),

            // =======================
            //  menu grid section
            // ========================

            // =======================
            // menu item wiget
            // =======================
            _buildCarouselSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String iconPath, String title, String routname) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
            ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 35),
            const SizedBox(height: 6,),
            Text(
              'title',
              style: TextStyle(fontFamily: 'PoppinsRegular', fontSize: 13),
            ),
          ],
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
