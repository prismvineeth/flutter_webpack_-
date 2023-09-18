import 'package:dio/dio.dart';

class api {
  Dio dio = Dio();

  String url = 'https://theinstallersapi.worksaar.com/api';

  static Map<String, String> getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  getData() async {
    Response responsed;

    responsed = await dio.get(
      "$url/get-details",
      options: Options(
        headers: getHeaders(),
      ),
    );

    // responsed = await dio.get(
    //   "$url/get-details",
    //   options: Options(
    //     followRedirects: false,
    //     headers: getHeaders(),
    //   ),
    // );

    return responsed.data;
  }

  storeData({String? name, String? email, String? desc}) async {
    Response response;
    print("user id isi $name and email is $email");
    response = await dio.post(
      "$url/store-data",
      data: {"name": name, "email": email, "description": desc},
      options: Options(
        headers: getHeaders(),
      ),
    );
// print(response.data.toString());
    return response.data;
  }
}

List profileData = [
  {
    "name": "Profile-1",
    "id": "profile-1",
    "videourl":
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
  },
  {
    'name': 'Profile-2',
    'id': 'profile-2',
    'videourl':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
  },
  {
    'name': 'Profile-3',
    'id': 'profile-3',
    'videourl':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4'
  },
  {
    'name': 'Profile-4',
    'id': 'profile-4',
    'videourl':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4'
  }
];
