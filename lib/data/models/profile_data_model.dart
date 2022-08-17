class ProfileDataModel {
  ProfileData? data;

  ProfileDataModel({this.data});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? photo;
  String? licenseFront;
  String? licenseBack;
  String? type;
  String? gender;
  String? emailVerifiedAt;
  double? lon;
  double? lat;
  String? status;
  int? isOnline;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;

  ProfileData(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.photo,
      this.licenseFront,
      this.licenseBack,
      this.type,
      this.gender,
      this.emailVerifiedAt,
      this.lon,
      this.lat,
      this.status,
      this.isOnline,
      this.fcmToken,
      this.createdAt,
      this.updatedAt});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    photo = json['photo'];
    licenseFront = json['license_front'];
    licenseBack = json['license_back'];
    type = json['type'];
    gender = json['gender'];
    emailVerifiedAt = json['email_verified_at'];
    lon = json['lon'];
    lat = json['lat'];
    status = json['status'];
    isOnline = json['isOnline'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['photo'] = this.photo;
    data['license_front'] = this.licenseFront;
    data['license_back'] = this.licenseBack;
    data['type'] = this.type;
    data['gender'] = this.gender;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    data['status'] = this.status;
    data['isOnline'] = this.isOnline;
    data['fcm_token'] = this.fcmToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
