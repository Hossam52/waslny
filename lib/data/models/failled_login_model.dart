class FailedUserLogin {
  FailedUserLogin({
    required this.message,
    required this.errors,
  });

  final String message;
  final Errors errors;

  factory FailedUserLogin.fromJson(Map<String, dynamic> json) =>
      FailedUserLogin(
        message: json["message"],
        errors: Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errors": errors.toJson(),
      };
}

class Errors {
  Errors({
    required this.mobile,
  });

  final List<String> mobile;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        mobile: List<String>.from(json["mobile"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "mobile": List<dynamic>.from(mobile.map((x) => x)),
      };
}
