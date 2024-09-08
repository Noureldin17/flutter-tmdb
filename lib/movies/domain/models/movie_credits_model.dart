class Member {
  late bool adult;
  late int gender;
  late int id;
  late String knownForDepartment;
  late String name;
  late String originalName;
  late String profilePath;
  late String character;

  Member.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    profilePath = json['profile_path'] ?? '';
    character = json['character'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['gender'] = gender;
    data['id'] = id;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['original_name'] = originalName;
    data['profile_path'] = profilePath;
    data['character'] = character;
    return data;
  }
}
