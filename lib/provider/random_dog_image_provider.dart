import 'dart:io';
import 'package:fin_info_com_task/repo/random_dog_image_repo/random_dog_image_repo_impl.dart';
import 'package:flutter/material.dart';

class RandomDogImageProvider extends ChangeNotifier {
  RandomDogImageRepoImpl randomDogImageRepoImpl = RandomDogImageRepoImpl();
  String _imageUrl = "";

  String get imageUrl => _imageUrl;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  callRandomDogImages() async {
    try {
      _isLoading = true;
      notifyListeners();
      await randomDogImageRepoImpl.getImage().then((value) {
        _isLoading = false;
        _imageUrl = value.message!;
        notifyListeners();
      });
    } on HttpException catch (e) {
      print(e.message);
    }
  }
}
