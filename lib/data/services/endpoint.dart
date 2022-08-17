class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = 'https://maps.googleapis.com/maps/api';

  //google map
  static const String geocode = '/geocode/json?';
  static const String placeAutoComplete = '/place/autocomplete/json?';
  static const String placeDetails = '/place/details/json?';
  static const String directions = '/directions/json?';
  static const String bookingStore="/booking/store";

  //api
  static const String baseApi = 'http://q.kareemashraf.com/api';
  static const String register = '/register';
  static const String login = '/login';
  static const String profile = '/profile';
  static const String changeName="/profile/change-name";
  static const String changePassowrd = '/profile/change-password';
  static const String changeAvatar="/profile/change-avatar";
}
