import 'package:fin_info_com_task/screens/profile_screen.dart';
import 'package:fin_info_com_task/screens/random_dog_image_display_screen.dart';
import 'package:flutter/material.dart';

import 'enable_bluetooth_screen.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = 'homeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fin Info Task list'),
        ),
        body: Column(
          children: [
            ListTile(
              title: const Text('Random dog Images'),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(RandomDogImageDisplayScreen.routeName);
              },
            ),
            ListTile(
              title: const Text('Enable bluetooth'),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(EnableBlueToothScreen.routeName);
              },
            ),
            ListTile(
              title: const Text('Profile'),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
            ),
          ],
        ));
  }
}
