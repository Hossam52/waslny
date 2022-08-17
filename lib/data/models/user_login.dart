class UserLogin {
  UserLogin({
    required this.data,
  });

  late final Data data;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.user,
    required this.token,
  });

  late final User user;
  late final String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
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
    required this.photo,
  });

  late final int id;
  late final String name;
  late final String email;
  late final String mobile;
  late final String status;
  late final String type;
  late final String gender;
  late final String photo;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        status: json["status"],
        type: json["type"],
        gender: json["gender"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "status": status,
        "type": type,
        "gender": gender,
        "photo": photo,
      };
}
