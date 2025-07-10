import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/model/facility_type/facility_type.dart';

class Facility {
  String id;
  String facilityName;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  FacilityType facilityType;

  Facility({
    required this.id,
    required this.facilityName,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.facilityType,
  });

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      id: setId(json),
      facilityName: setFacilityName(json),
      createdBy: setCreatedBy(json),
      updatedBy: setUpdatedBy(json),
      createdAt: setCreatedAt(json),
      updatedAt: setUpdatedAt(json),
      facilityType: setFacilityType(json),
    );
  }

  Facility copyWith({
    String? id,
    String? facilityName,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    FacilityType? facilityType,
  }) => Facility(
    id: id ?? this.id,
    facilityName: facilityName ?? this.facilityName,
    createdBy: createdBy ?? this.createdBy,
    updatedBy: updatedBy ?? this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    facilityType: facilityType ?? this.facilityType,
  );

  static Facility defaultValues() => Facility(
    id: '',
    facilityName: '',
    createdBy: '',
    updatedBy: '',
    createdAt: DateTime(1500, 01, 01),
    updatedAt: DateTime(1500, 01, 01),
    facilityType: FacilityType.defaultValues(),
  );

  Map<String, dynamic> toJson() => {
    'facility_name': facilityName,
    'facility_type': facilityType.id,
  };

  static String setId(Map<String, dynamic> json) {
    if (json.containsKey('id')) {
      if (json['id'] != null && json['id'] is String && json['id'].toString().isNotEmpty) {
        return json['id'];
      }
    }

    return '';
  }

  static String setFacilityName(Map<String, dynamic> json) {
    if (json.containsKey('facility_name')) {
      if (json['facility_name'] != null &&
          json['facility_name'] is String &&
          json['facility_name'].toString().isNotEmpty) {
        return json['facility_name'];
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
          return Utils.formatToIST(json['created_at']);
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
          return Utils.formatToIST(json['updated_at']);
        } catch (e) {
          return DateTime(1500, 01, 01);
        }
      }
    }

    return DateTime(1500, 01, 01);
  }

  static FacilityType setFacilityType(Map<String, dynamic> json) {
    if (json.containsKey('facility_type')) {
      if (json['facility_type'] != null) {
        return FacilityType.fromJson(json['facility_type']);
      }
    }
    return FacilityType.defaultValues();
  }
}
