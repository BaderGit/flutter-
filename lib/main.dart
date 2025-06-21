import 'package:final_project/firebase_options.dart';
import 'package:final_project/splash_screen.dart';

import 'package:final_project/utils/local_notification.dart';

import 'package:final_project/providers/auth_provider.dart';

import 'package:final_project/providers/firestore_provider.dart';

import 'package:final_project/utils/app_router.dart';
import 'package:final_project/utils/config.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalNotification.localNotification.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppAuthProvider>(
          create: (context) => AppAuthProvider(),
        ),
        ChangeNotifierProvider<FireStoreProvider>(
          create: (context) => FireStoreProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  // void dispose() {
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppRouter.navKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        //pre-define input decoration
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.primaryColor,
          border: Config.outlinedBorder,
          focusedBorder: Config.focusBorder,
          errorBorder: Config.errorBorder,
          enabledBorder: Config.outlinedBorder,
          floatingLabelStyle: TextStyle(color: Config.primaryColor),
          prefixIconColor: Colors.black38,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Config.primaryColor,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade700,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
