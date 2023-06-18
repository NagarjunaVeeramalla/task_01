import 'package:fin_info_com_task/model/dto/random_dog_image_dto.dart';
import 'package:fin_info_com_task/model/entity/random_dog_image_entity.dart';

abstract class RandomDogImageRepo {
  Future<RandomDogImageEntity> getImage();
}
