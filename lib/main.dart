
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_controller.dart';

import 'kampy_signup.dart';
import 'package:get/get.dart';



// call firebase
import 'package:firebase_core/firebase_core.dart';


//weather
// import './weather/data/models/dark_theme_model.dart';
// import './weather/data/models/theme_model.dart';
// import './weather/data/provider.dart';
// import './weather/data/repos/city_repo_impl.dart';
// import './weather/data/repos/full_weather_repo.dart';
// import './weather/data/repos/unit_system_repo_impl.dart';
// import './weather/domain/repos/city_repo.dart';
// import './weather/domain/repos/full_weather_repo.dart';
// import './weather/domain/repos/unit_system_repo.dart';
// import './weather/ui/screens/weather_screen.dart';
// import './weather/ui/state_notifiers/theme_state_notifier.dart' as t;
// import './weather/ui/state_notifiers/theme_state_notifier.dart'
//     show themeStateNotifierProvider;
// import './weather/ui/themes/black_theme.dart';
// import './weather/ui/themes/dark_theme.dart';
// import './weather/ui/themes/light_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';

// import './weather/ui/build_flavor.dart';
// import './weather/ui/themes/clima_theme.dart';






void main() async {
  // call firebase
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) => Get.put(AuthController()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),


      home: const SignUp(),



    );
  }
}
