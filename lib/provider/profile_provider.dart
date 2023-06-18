import 'dart:io';

import 'package:fin_info_com_task/repo/profile_repo/profile_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileRepoImpl profileRepoImpl = ProfileRepoImpl();

  String _name = "";

  String get name => _name;

  String _location = "";

  String _email = "";

  String _dob = "";

  String _noOfDaysRegistered = "";

  String _imageUrl = "";

  String get location => _location;

  String get email => _email;

  String get dob => _dob;

  String get noOfDaysRegistered => _noOfDaysRegistered;

  String get imageUrl => _imageUrl;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  getProfileData() async {
    try {
      _isLoading = true;
      await profileRepoImpl.getProfile().then((value) {
        _name = value.results![0].name!.first!;
        _email = value.results![0].email!;
        _dob = DateFormat.yMMMd()
            .format(DateTime.parse(value.results![0].dob!.date!));
        _imageUrl = value.results![0].picture!.large!;
        _location = value.results![0].location!.country!;
        _noOfDaysRegistered =
            calculateDaysBetween(value.results![0].registered!.date!);
        _isLoading = false;
        notifyListeners();
      });
    } on HttpException catch (e) {
      _isLoading = false;
      print(e.message);
    }
  }

  String calculateDaysBetween(String registeredDate) {
    DateTime currentDateTime = DateTime.now();
    DateTime dateTime = DateTime.parse(registeredDate);
    String difference = "${currentDateTime.difference(dateTime).inDays}";
    return difference;
  }
}
