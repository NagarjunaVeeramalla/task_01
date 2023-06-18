import 'package:fin_info_com_task/constants/app_api_constants.dart';
import 'package:fin_info_com_task/model/entity/random_dog_image_entity.dart';
import 'package:fin_info_com_task/repo/random_dog_image_repo/random_dog_image_repo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RandomDogImageRepoImpl extends RandomDogImageRepo {
  @override
  Future<RandomDogImageEntity> getImage() async {
    final response = await http.get(Uri.parse(AppApiConstants.randomDogImage));
    final json = jsonDecode(response.body);
    return RandomDogImageEntity(
      message: json['message'],
      status: json['status'],
    );
  }
}
