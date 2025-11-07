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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.amber,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/ic_menu_doa.png'),
                                Text(
                                  'doa & zikir',
                                  style: TextStyle(
                                    fontFamily: 'PoppinsRegular',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/ic_menu_zakat.png'),
                                Text(
                                  'Zakat',
                                  style: TextStyle(
                                    fontFamily: 'PoppinsRegular',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/ic_menu_jadwal_sholat.png',
                                ),
                                Text(
                                  'Jadwal Sholat',
                                  style: TextStyle(
                                    fontFamily: 'PoppinsRegular',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/ic_menu_video_kajian.png',
                                ),
                                Text(
                                  'Video Kajian',
                                  style: TextStyle(
                                    fontFamily: 'PoppinsRegular',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /**
             * ===================
             *  carousel section
             * ===================
             */
            _buildCarouselSection(),
          ],
        ),
      ),
    );
  }

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
