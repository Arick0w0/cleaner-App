class Area {
  final String id;
  final String area;
  final String areaCodeName;
  final String province;
  final String provinceCodeName;

  Area({
    required this.id,
    required this.area,
    required this.areaCodeName,
    required this.province,
    required this.provinceCodeName,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['_id'],
      area: json['area'],
      areaCodeName: json['area_code_name'],
      province: json['province'],
      provinceCodeName: json['province_code_name'],
    );
  }
}
