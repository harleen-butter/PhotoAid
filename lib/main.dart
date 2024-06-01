import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:PhotoAid/config/app_strings.dart';
import 'package:PhotoAid/controllers/storage_controller.dart';
import 'package:PhotoAid/localization/app_translation.dart';
import 'package:PhotoAid/view/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions( )
    );
  } catch (e) {
    print("Firebase initialization error: $e");
  }
  String? languageCode = await StorageController.instance.getLanguage();
  String? countryCode = await StorageController.instance.getCountryCode();
  runApp(MyApp(
    languageCode: languageCode,
    countryCode: countryCode,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.languageCode, this.countryCode});

  final String? languageCode;
  final String? countryCode;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translationsKeys: AppTranslation.translationsKeys,
      debugShowCheckedModeBanner: false,
      title: AppStrings.primeTaxiBooking,
      locale: Locale(languageCode ?? "en", countryCode ?? "US"),
      home: SplashScreen(),
    );
  }
}
