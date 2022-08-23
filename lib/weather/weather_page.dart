import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import './controllers/weather_controller.dart';
import 'package:simple_shadow/simple_shadow.dart';

// hex color
import 'package:hexcolor/hexcolor.dart';

import 'package:flutter_application_1/kampy_create_posts.dart';

import '../kampy_map.dart';
import '../kampy_event.dart';
//import create blogs
import '../kampy_create_posts.dart';

// hex color
import 'package:hexcolor/hexcolor.dart';
// firebase auth
import 'package:firebase_auth/firebase_auth.dart';
// firestore
import 'package:cloud_firestore/cloud_firestore.dart';

// navbar

import '../navbar_animated.dart';

import '../chat/chat_main.dart';
import '.././kampy_welcome.dart';
import '../kampy_shops.dart';
import '../auth_controller.dart';
import '../kampy_posts.dart';


// import reaction button



class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(WeatherController());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var day = DateFormat.d().format(DateTime.now());
    var month = DateFormat.LLLL().format(DateTime.now());
    TextEditingController cityText = TextEditingController();

  final List<Widget> _pages = [const KampyEvent(), Shops(),const  Posts(),const CreatePost()];
// plus button array of pages
  final List<Widget> _views = [  MapKampy(), MapKampy(),const  Chat(), Welcome()];
  int index = 0;

     handleSearchCity() {
      c.fetchWeather(cityText.text);
      // Close keyboard after enter
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
    Widget searchCity() {
      return Container(
        margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
        width: double.infinity,
        child: Row(
          children: [
            Icon(
              Icons.search_outlined,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 5),
            Expanded(
              child: TextField(
                controller: cityText,
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  handleSearchCity();
                },
                style: const TextStyle(color: Colors.white, fontSize: 24),
                decoration: const  InputDecoration(
                  hintText: 'Search City',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 24),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget weatherIcon() {
      return Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          height: height * 0.2,
          child: SimpleShadow(
            opacity: 0.20,
            color: Colors.black,
            offset: Offset(3, 10),
            sigma: 30,
            child: c.isLoading.value
                ? const Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : LottieBuilder.network(
                    c.weatherIcon.value,
                    fit: BoxFit.cover,
                    width: width * 0.4,
                  ),
          ),
        ),
      );
    }

    Widget weatherInformation() {
      return Container(
        margin: const EdgeInsets.fromLTRB(30, 40, 30, 0),
        padding: const EdgeInsets.fromLTRB(0, 17, 0, 17),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          border: Border.all(
            color: Color(0xffB2C9DD),
            width: 2,
          ),
          color: const Color(0xffFFFFFF).withOpacity(0.30),
        ),
        child: c.isLoading.value
            ? const Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Column(
                children: [
                  // Date
                  Container(
                    child: Text(
                      'Today, $day $month',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Temperature
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: SimpleShadow(
                      opacity: 0.25,
                      color: Colors.black,
                      offset: Offset(3, 7),
                      sigma: 25,
                      child: Text(
                        '${(c.weather.value.temp / 10).toStringAsFixed(0)}\u00B0',
                        style:const  TextStyle(
                          fontSize: 90,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Weather Description
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      '${c.weather.value.description.toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Weather Detail
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 27, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:const  [
                            Icon(
                              Icons.flag_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(height: 13),
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(height: 13),
                            Icon(
                              Icons.air,
                              color: Colors.white,
                            ),
                            SizedBox(height: 13),
                            Icon(
                              Icons.water_damage_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        // Type
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Country',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 13),
                            Text(
                              'City',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 13),
                            Text(
                              'Wind',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 13),
                            Text(
                              'Humidity',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        // Divider
                        Column(
                          children: const [
                            Text(
                              '|',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 13),
                            Text(
                              '|',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 13),
                            Text(
                              '|',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 13),
                            Text(
                              '|',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        // Number
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${c.weather.value.country}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 13),
                            Text(
                              '${c.weather.value.name}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 13),
                            Text(
                              '${c.weather.value.speed} km/h',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 13),
                            Text(
                              '${c.weather.value.humidity} %',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      );
    }

    return Obx(
      () => Scaffold(
         appBar: AppBar(
        title: const Text("Weather"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [HexColor('#675975'), HexColor('#7b94c4')]),
          ),
        ),
      ),
      
      // navbar bottom
      bottomNavigationBar: Builder(
        
          builder: (context) => AnimatedBottomBar(
                defaultIconColor: HexColor('#7b94c4'),
                activatedIconColor: HexColor('#7b94c4'),
                background: Colors.white,
                buttonsIcons: const [
                  Icons.sunny_snowing,
                  Icons.explore_sharp,
                  Icons.messenger_outlined,
                  Icons.person
                ],
                buttonsHiddenIcons: const [
                  Icons.campaign_rounded,
                  Icons.shopping_bag,
                  Icons.image_rounded,
                  Icons.post_add_rounded
                ],
                backgroundColorMiddleIcon:HexColor('#7b94c4'),
                onTapButton: (i) {
  
                    index = i;
    
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => _views[i]),
                  );
                },
                // navigate between pages
                onTapButtonHidden: (i) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => _pages[i]),
                  );
                },
              )),
              backgroundColor: Color.fromARGB(255, 214, 204, 228),
        body:
         Container(
          height: height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 133, 147, 155),
                Color.fromARGB(255, 124, 93, 167),
              ],
            ),
          ),
          child: ListView(
            children: [
              searchCity(),
              weatherIcon(),
              weatherInformation(),
            ],
          ),
        ),
      ),
    );
  }
}
