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
  final List<Widget> _views = [KampyEvent(), MapKampy(), Chat(), Welcome()];

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  // map builder
   static const CameraPosition _Tunisie = CameraPosition(
    target: LatLng(36.799748880595764, 10.171296710937465),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
           debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kampy Map'),
          centerTitle: true,
           flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [HexColor('#675975'), HexColor('#7b94c4')]),
          ),
        ),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: _Tunisie
        ),
          // navbar bottom
          
          bottomNavigationBar: Builder(
          builder: (context) => AnimatedBottomBar(
                defaultIconColor:  HexColor('#7b94c4'),
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
                backgroundColorMiddleIcon:  HexColor('#7b94c4'),
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




