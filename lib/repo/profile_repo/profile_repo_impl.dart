import 'package:fin_info_com_task/constants/app_api_constants.dart';
import 'package:fin_info_com_task/model/entity/profile_entity.dart';
import 'package:fin_info_com_task/repo/profile_repo/profile_repo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileRepoImpl extends ProfileRepo {
  @override
  Future<ProfileEntity> getProfile() async {
    final response = await http.get(Uri.parse(AppApiConstants.profileUrl));
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var user = ProfileEntity.fromJson(userMap);
    return ProfileEntity(results: user.results, info: user.info);
  }
}
