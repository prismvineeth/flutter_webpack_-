import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ng_companion/api/api.dart';
import 'package:ng_companion/api/profile_model.dart';
import 'package:ng_companion/pages/team_profile.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List> getUserData() async {
    var data = await api().getData();
    print(data);
    return data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Testing'),
        ),
        body: customBody());
  }

  customBody() {
    if (kIsWeb) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 8),
        itemCount: profileData.length,
        itemBuilder: (context, index) {
          Profile _profile = Profile.fromJson(profileData[index]);
          return TeamProfile(
            profile: _profile,
          );
        },
      );
    } else {
      return ListView.builder(
        itemCount: profileData.length,
        itemBuilder: (context, index) {
          Profile _profile = Profile.fromJson(profileData[index]);
          return TeamProfile(
            profile: _profile,
          );
        },
      );
    }
  }
}
