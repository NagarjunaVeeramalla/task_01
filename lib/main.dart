import 'package:fin_info_com_task/provider/profile_provider.dart';
import 'package:fin_info_com_task/provider/random_dog_image_provider.dart';
import 'package:fin_info_com_task/screens/enable_bluetooth_screen.dart';
import 'package:fin_info_com_task/screens/home_screen.dart';
import 'package:fin_info_com_task/screens/profile_screen.dart';
import 'package:fin_info_com_task/screens/random_dog_image_display_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RandomDogImageProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.lime),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          RandomDogImageDisplayScreen.routeName: (_) =>
              const RandomDogImageDisplayScreen(),
          EnableBlueToothScreen.routeName: (_) => const EnableBlueToothScreen(),
          ProfileScreen.routeName: (_) => const ProfileScreen(),
        },
      ),
    );
  }
}
