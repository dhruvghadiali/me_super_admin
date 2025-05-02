import 'package:me_super_admin/model/city/city.dart';

class AreaName {
  String id;
  String name;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  City city;

  AreaName({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.city,
  });

  factory AreaName.fromJson(Map<String, dynamic> json) {
    return AreaName(
      id: setId(json),
      name: setName(json),
      createdBy: setCreatedBy(json),
      updatedBy: setUpdatedBy(json),
      createdAt: setCreatedAt(json),
      updatedAt: setUpdatedAt(json),
      city: setCity(json),
    );
  }

  AreaName copyWith({
    String? id,
    String? name,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    City? city,
  }) => AreaName(
    id: id ?? this.id,
    name: name ?? this.name,
    createdBy: createdBy ?? this.createdBy,
    updatedBy: updatedBy ?? this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    city: city ?? this.city,
  );

  static AreaName defaultValues() => AreaName(
    id: '',
    name: '',
    createdBy: '',
    updatedBy: '',
    createdAt: DateTime(1500, 01, 01),
    updatedAt: DateTime(1500, 01, 01),
    city: City.defaultValues(),
  );

  Map<String, dynamic> toJson() => {'name': name, 'city': city.id};

  static String setId(Map<String, dynamic> json) {
    if (json.containsKey('id')) {
      if (json['id'] != null &&
          json['id'] is String &&
          json['id'].toString().isNotEmpty) {
        return json['id'];
      }
    }

    return '';
  }

  static String setName(Map<String, dynamic> json) {
    if (json.containsKey('name')) {
      if (json['name'] != null &&
          json['name'] is String &&
          json['name'].toString().isNotEmpty) {
        return json['name'];
      }
    }

    return '';
  }

  static String setCreatedBy(Map<String, dynamic> json) {
    if (json.containsKey('created_by')) {
      if (json['created_by'] != null &&
          json['created_by'] is String &&
          json['created_by'].toString().isNotEmpty) {
        return json['created_by'];
      }
    }

    return '';
  }

  static String setUpdatedBy(Map<String, dynamic> json) {
    if (json.containsKey('updated_by')) {
      if (json['updated_by'] != null &&
          json['updated_by'] is String &&
          json['updated_by'].toString().isNotEmpty) {
        return json['updated_by'];
      }
    }

    return '';
  }

  static DateTime setCreatedAt(Map<String, dynamic> json) {
    if (json.containsKey('created_at')) {
      if (json['created_at'] != null &&
          json['created_at'] is String &&
          json['created_at'].toString().isNotEmpty) {
        try {
          return DateTime.parse(json['created_at']);
        } catch (e) {
          return DateTime(1500, 01, 01);
        }
      }
    }

    return DateTime(1500, 01, 01);
  }

  static DateTime setUpdatedAt(Map<String, dynamic> json) {
    if (json.containsKey('updated_at')) {
      if (json['updated_at'] != null &&
          json['updated_at'] is String &&
          json['updated_at'].toString().isNotEmpty) {
        try {
          return DateTime.parse(json['updated_at']).toUtc();
        } catch (e) {
          return DateTime(1500, 01, 01);
        }
      }
    }

    return DateTime(1500, 01, 01);
  }

  static City setCity(Map<String, dynamic> json) {
    if (json.containsKey('city')) {
      if (json['city'] != null) {
        return City.fromJson(json['city']);
      }
    }
    return City.defaultValues();
  }
}
