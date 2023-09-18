class Profile {
  Profile({
    required this.name,
    required this.id,
    required this.videourl,
  });
  late final String name;
  late final String id;
  late final String videourl;

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    videourl = json['videourl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['videourl'] = videourl;
    return _data;
  }
}
