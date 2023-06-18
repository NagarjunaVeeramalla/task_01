import 'package:fin_info_com_task/helper/sized_box_helper.dart';
import 'package:fin_info_com_task/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = 'profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: false).getProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Screen'),
        ),
        body: Center(
          child: provider.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBoxHelper.sizedBox20,
                    CircleAvatar(
                      maxRadius: 100,
                      backgroundImage: NetworkImage(provider.imageUrl),
                    ),
                    SizedBoxHelper.sizedBox20,
                    Text("Name: ${provider.name}"),
                    SizedBoxHelper.sizedBox20,
                    Text("Location: ${provider.location}"),
                    SizedBoxHelper.sizedBox20,
                    Text("Email: ${provider.email}"),
                    SizedBoxHelper.sizedBox20,
                    Text("DOB: ${provider.dob}"),
                    SizedBoxHelper.sizedBox20,
                    Text(
                        "Days since registered: ${provider.noOfDaysRegistered}"),
                  ],
                ),
        ),
      );
    });
    ;
  }
}
