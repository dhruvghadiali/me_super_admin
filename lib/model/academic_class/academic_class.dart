import 'package:me_super_admin/utils/utils.dart';

class AcademicClass {
  String id;
  String academicClass;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;

  AcademicClass({
    required this.id,
    required this.academicClass,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AcademicClass.fromJson(Map<String, dynamic> json) {
    return AcademicClass(
      id: setId(json),
      academicClass: setAcademicClass(json),
      createdBy: setCreatedBy(json),
      updatedBy: setUpdatedBy(json),
      createdAt: setCreatedAt(json),
      updatedAt: setUpdatedAt(json),
    );
  }

  AcademicClass copyWith({
    String? id,
    String? academicClass,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AcademicClass(
    id: id ?? this.id,
    academicClass: academicClass ?? this.academicClass,
    createdBy: createdBy ?? this.createdBy,
    updatedBy: updatedBy ?? this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  static AcademicClass defaultValues() => AcademicClass(
    id: '',
    academicClass: '',
    createdBy: '',
    updatedBy: '',
    createdAt: DateTime(1500, 01, 01),
    updatedAt: DateTime(1500, 01, 01),
  );

  Map<String, dynamic> toJson() => {'academic_class': academicClass};

  static String setId(Map<String, dynamic> json) {
    if (json.containsKey('id')) {
      if (json['id'] != null && json['id'] is String && json['id'].toString().isNotEmpty) {
        return json['id'];
      }
    }

    return '';
  }

  static String setAcademicClass(Map<String, dynamic> json) {
    if (json.containsKey('academic_class')) {
      if (json['academic_class'] != null &&
          json['academic_class'] is String &&
          json['academic_class'].toString().isNotEmpty) {
        return json['academic_class'];
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
}
