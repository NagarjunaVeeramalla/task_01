
import 'package:fin_info_com_task/model/entity/profile_entity.dart';

abstract class ProfileRepo {
  Future<ProfileEntity> getProfile();
}