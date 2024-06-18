class Address {
  final String addressName;
  final String village;
  final String district;
  final String province;
  final String googleMapLink;

  Address({
    required this.addressName,
    required this.village,
    required this.district,
    required this.province,
    required this.googleMapLink,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressName: json['address_name'],
      village: json['village'],
      district: json['district'],
      province: json['province'],
      googleMapLink: json['google_map'],
    );
  }
}
