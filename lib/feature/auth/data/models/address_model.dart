class Address {
  final String addressName;
  final String village;
  final String district;
  final String province;
  final String googleMap;

  Address({
    required this.addressName,
    required this.village,
    required this.district,
    required this.province,
    required this.googleMap,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressName: json['address_name'],
      village: json['village'],
      district: json['district'],
      province: json['province'],
      googleMap: json['google_map'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address_name': addressName,
      'village': village,
      'district': district,
      'province': province,
      'google_map': googleMap,
    };
  }

  @override
  String toString() {
    return 'Address(addressName: $addressName, village: $village, district: $district, province: $province, googleMap: $googleMap)';
  }
}
