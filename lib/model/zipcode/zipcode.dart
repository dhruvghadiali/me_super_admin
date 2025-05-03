import 'package:me_super_admin/model/area_name/area_name.dart';

class Zipcode {
  String id;
  String zipcode;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  AreaName areaName;

  Zipcode({
    required this.id,
    required this.zipcode,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.areaName,
  });

  factory Zipcode.fromJson(Map<String, dynamic> json) {
    return Zipcode(
      id: setId(json),
      zipcode: setZipcode(json),
      createdBy: setCreatedBy(json),
      updatedBy: setUpdatedBy(json),
      createdAt: setCreatedAt(json),
      updatedAt: setUpdatedAt(json),
      areaName: setAreaName(json),
    );
  }

  Zipcode copyWith({
    String? id,
    String? zipcode,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    AreaName? areaName,
  }) => Zipcode(
    id: id ?? this.id,
    zipcode: zipcode ?? this.zipcode,
    createdBy: createdBy ?? this.createdBy,
    updatedBy: updatedBy ?? this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    areaName: areaName ?? this.areaName,
  );

  static Zipcode defaultValues() => Zipcode(
    id: '',
    zipcode: '',
    createdBy: '',
    updatedBy: '',
    createdAt: DateTime(1500, 01, 01),
    updatedAt: DateTime(1500, 01, 01),
    areaName: AreaName.defaultValues(),
  );

  Map<String, dynamic> toJson() => {'zipcode': zipcode, 'area_name': areaName.id};

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

  static String setZipcode(Map<String, dynamic> json) {
    if (json.containsKey('zipcode')) {
      if (json['zipcode'] != null &&
          json['zipcode'] is String &&
          json['zipcode'].toString().isNotEmpty) {
        return json['zipcode'];
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

  static AreaName setAreaName(Map<String, dynamic> json) {
    if (json.containsKey('area_name')) {
      if (json['area_name'] != null) {
        return AreaName.fromJson(json['area_name']);
      }
    }
    return AreaName.defaultValues();
  }
}
