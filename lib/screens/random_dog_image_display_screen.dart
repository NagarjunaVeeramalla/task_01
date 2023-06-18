import 'package:fin_info_com_task/provider/random_dog_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RandomDogImageDisplayScreen extends StatefulWidget {
  static String routeName = '/randomDogImageDisplay';

  const RandomDogImageDisplayScreen({super.key});

  @override
  State<RandomDogImageDisplayScreen> createState() =>
      _RandomDogImageDisplayScreenState();
}

class _RandomDogImageDisplayScreenState
    extends State<RandomDogImageDisplayScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RandomDogImageProvider>(context, listen: false)
          .callRandomDogImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RandomDogImageProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Random dog image display'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: provider.isLoading
                  ? Image.asset('assets/loader.gif')
                  : Image.network(provider.imageUrl),
            ),
            MaterialButton(
                color: Colors.amberAccent,
                onPressed: () {
                  provider.callRandomDogImages();
                },
                child: const Text('Refresh')),
          ],
        ),
      );
    });
  }
}
