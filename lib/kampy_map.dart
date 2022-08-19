// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// hex color
import 'package:hexcolor/hexcolor.dart';

//navbar
import 'navbar_animated.dart';
import 'kampy_posts.dart';
import 'kampy_event.dart';
import 'chat/chat_main.dart';
import 'kampy_welcome.dart';
import 'kampy_shops.dart';
import 'create_event.dart';
import "./weather/weather_page.dart";

class MapKampy extends StatefulWidget {
  MapKampy({Key? key}) : super(key: key);

  @override
  State<MapKampy> createState() => _MapKampyState();
}

class _MapKampyState extends State<MapKampy> {
  late GoogleMapController mapController;
  // plus button array of pages
  final List<Widget> _pages = [KampyEvent(), Shops(), Posts(), CreateEvent()];

// original navbar
  int index = 0;
  final List<Widget> _views = [WeatherPage(), MapKampy(), Chat(), Welcome()];

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // map builder
  static const CameraPosition _Tunisie = CameraPosition(
    target: LatLng(36.799748880595764, 10.171296710937465),
    zoom: 6,
  );

 // markers

 
  static Marker LakeMarker = Marker(
      markerId: const MarkerId('_crique'),
      infoWindow: const InfoWindow(title: 'Crique de Robinson',snippet: 'Crique de Robinson'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(36.846034566654936, 10.575138257081361));

 static Marker Kanassira = Marker(
      markerId: const MarkerId('_Aîn Kanassira'),
      infoWindow: const InfoWindow(title: 'Aîn Kanassira',snippet: 'Aîn Kanassira'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(36.840494821167944, 10.571922024556414));

   static Marker Cap_Serrat = Marker(
      markerId: const MarkerId('_Cap_Serrat'),
      infoWindow: const InfoWindow(title: 'Cap Serrat',snippet: 'Cap Serrat'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(37.24486448031525, 9.217378458669806));    
   
   static Marker Rtiba = Marker(
      markerId: const MarkerId('_Rtiba'),
      infoWindow: const InfoWindow(title: 'Rtiba',snippet: 'Rtiba'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(36.8842832489307, 10.760166235727997));    

   static Marker Barrak = Marker(
      markerId: const MarkerId('_Sidi El Barrak'),
      infoWindow: const InfoWindow(title: 'Sidi El Barrak',snippet: 'Sidi El Barrak'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(37.02490185818732, 8.936367539900889));    

   static Marker Mtir = Marker(
      markerId: const MarkerId('_Beni Mtir'),
      infoWindow: const InfoWindow(title: 'Beni Mtir',snippet: 'Beni Mtir'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(36.74665070651355, 8.739370972999476));    
  
   static Marker Soltane = Marker(
      markerId: const MarkerId('_Ain Soltane'),
      infoWindow: const InfoWindow(title: 'Ain Soltane',snippet: 'Ain Soltane'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(36.52647635171729, 8.33700075735917));    

   static Marker Zaghouan = Marker(
      markerId: const MarkerId('Zaghouan'),
      infoWindow: const InfoWindow(title: 'Zaghouan',snippet: 'Zaghouan'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(36.371409346258034, 10.109004931207926));    
   
   static Marker Seliana = Marker(
      markerId: const MarkerId('Djebel El Serraj seliana'),
      infoWindow: const InfoWindow(title: 'Djebel El Serraj seliana',snippet: 'Djebel El Serraj seliana'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(36.00289544595883, 9.540055290031274));    
   
   static Marker Kef = Marker(
      markerId: const MarkerId('Kef ghrab'),
      infoWindow: const InfoWindow(title: 'Kef ghrab',snippet: 'Kef ghrab'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(36.209042004965475, 8.726258326480083));    
  
   static Marker Kelibia = Marker(
      markerId: const MarkerId('Oued el ksab kelibia'),
      infoWindow: const InfoWindow(title: 'KOued el ksab kelibia',snippet: 'Oued el ksab kelibia'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(36.91280681463493, 11.10578612640312));    

   static Marker Angela = Marker(
      markerId: const MarkerId(''),
      infoWindow: const InfoWindow(title: 'Cap Angela',snippet: 'Cap Angela'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(37.34712315700237, 9.742293667921865));

   static Marker Korbous = Marker(
      markerId: const MarkerId(''),
      infoWindow: const InfoWindow(title: 'Ras fartas korbous',snippet: 'Ras fartas korbous'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: const LatLng(36.88313992059216, 10.611494222280704));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
           debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kampy Map'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [HexColor('#675975'), HexColor('#7b94c4')]
                  ),
            ),
          ),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: _Tunisie,
          markers: <Marker>{LakeMarker,Korbous,Kanassira,Cap_Serrat,Rtiba,Barrak,Mtir,Zaghouan,Seliana,Kef,Kelibia,Angela},
          zoomGesturesEnabled: true,      
          zoomControlsEnabled: true,
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
                    Icons.event_outlined,
                    Icons.shopping_bag,
                    Icons.image_rounded,
                    Icons.post_add_rounded
                  ],
                  backgroundColorMiddleIcon: HexColor('#7b94c4'),
                  onTapButton: (i) {
                    setState(() {
                      index = i;
                    });
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
        // navbar bottom ends here
      ),
    );
  }
}
