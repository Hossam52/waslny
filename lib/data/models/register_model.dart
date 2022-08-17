class RegistrationModel {
  RegistrationModel({
    required this.data,
  });
  late final Data data;

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.user,
    required this.token,
  });
  late final User user;
  late final String token;

  Data.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    _data['token'] = token;
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.status,
    required this.type,
    required this.gender,
    this.lat,
    this.lon,
    this.emailVerifiedAt,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String mobile;
  late final String status;
  late final String type;
  late final String gender;
  late final double? lat;
  late final double? lon;
  late final String? emailVerifiedAt;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    status = json['status'];
    type = json['type'];
    gender = json['gender'];
    lat = json['lat'];
    lon = json['lon'];
    emailVerifiedAt = json['email_verified_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['mobile'] = mobile;
    _data['status'] = status;
    _data['type'] = type;
    _data['gender'] = gender;
    _data['lat'] = lat;
    _data['lon'] = lon;
    _data['email_verified_at'] = emailVerifiedAt;
    return _data;
  }
}
