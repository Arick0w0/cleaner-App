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
      addressName: json['address_name'] ?? '',
      village: json['village'] ?? '',
      district: json['district'] ?? '',
      province: json['province'] ?? '',
      googleMap: json['google_map'] ?? '',
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
    return 'Address{addressName: $addressName, village: $village, district: $district, province: $province, googleMap: $googleMap}';
  }
}

class ServiceTypess {
  final String id;
  final String serviceType;
  final String isActive;

  ServiceTypess({
    required this.id,
    required this.serviceType,
    required this.isActive,
  });

  factory ServiceTypess.fromJson(Map<String, dynamic> json) {
    return ServiceTypess(
      id: json['id'] ?? '',
      serviceType: json['service_type'] ?? '',
      isActive: json['is_active'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_type': serviceType,
      'is_active': isActive,
    };
  }

  @override
  String toString() {
    return 'ServiceTypess{id: $id, serviceType: $serviceType, isActive: $isActive}';
  }
}

class User {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String role;
  final String phone;
  final String imageProfile;
  final String token;
  final String customerCode;
  final List<Address> address;
  final List<ServiceTypess> serviceTypes;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.phone,
    required this.imageProfile,
    required this.token,
    required this.customerCode,
    required this.address,
    required this.serviceTypes,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // print('Deserializing User from JSON: $json'); // Debug print

    var addressList = json['address'] as List<dynamic>? ?? [];
    var serviceTypeList = json['service_types'] as List<dynamic>? ?? [];

    List<Address> address =
        addressList.map((i) => Address.fromJson(i)).toList();
    List<ServiceTypess> serviceTypes =
        serviceTypeList.map((i) => ServiceTypess.fromJson(i)).toList();

    final id = json['_id'] ?? '';
    // print('Deserialized id: $id'); // Debug print

    return User(
      id: id,
      username: json['username'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      role: json['role'] ?? '',
      phone: json['phone'] ?? '',
      imageProfile: json['image_profile'] ?? '',
      token: json['token'] ?? '',
      customerCode: json['customer_code'] ?? '',
      address: address,
      serviceTypes: serviceTypes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'role': role,
      'phone': phone,
      'image_profile': imageProfile,
      'token': token,
      'customer_code': customerCode,
      'address': address.map((i) => i.toJson()).toList(),
      'service_types': serviceTypes.map((i) => i.toJson()).toList(),
    };
  }

  // @override
  // String toString() {
  //   return 'User{id: $id, username: $username, firstName: $firstName, lastName: $lastName, role: $role, phone: $phone, imageProfile: $imageProfile, token: $token, customerCode: $customerCode, address: $address, serviceTypes: $serviceTypes}';
  // }
}
