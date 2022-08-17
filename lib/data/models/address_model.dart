class Results {
  late final String formattedAddress;

  Results(
    this.formattedAddress,
  );

  Results.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
  }
}
