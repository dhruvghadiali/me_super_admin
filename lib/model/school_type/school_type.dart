class SchoolType {
  String id;
  String schoolType;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;

  SchoolType({
    required this.id,
    required this.schoolType,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SchoolType.fromJson(Map<String, dynamic> json) {
    return SchoolType(
      id: setId(json),
      schoolType: setSchoolType(json),
      createdBy: setCreatedBy(json),
      updatedBy: setUpdatedBy(json),
      createdAt: setCreatedAt(json),
      updatedAt: setUpdatedAt(json),
    );
  }

  SchoolType copyWith({
    String? id,
    String? schoolType,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SchoolType(
    id: id ?? this.id,
    schoolType: schoolType ?? this.schoolType,
    createdBy: createdBy ?? this.createdBy,
    updatedBy: updatedBy ?? this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  static SchoolType defaultValues() => SchoolType(
    id: '',
    schoolType: '',
    createdBy: '',
    updatedBy: '',
    createdAt: DateTime(1500, 01, 01),
    updatedAt: DateTime(1500, 01, 01),
  );

  Map<String, dynamic> toJson() => {'school_type': schoolType};

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

  static String setSchoolType(Map<String, dynamic> json) {
    if (json.containsKey('school_type')) {
      if (json['school_type'] != null &&
          json['school_type'] is String &&
          json['school_type'].toString().isNotEmpty) {
        return json['school_type'];
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
          return DateTime.parse(json['updated_at']);
        } catch (e) {
          return DateTime(1500, 01, 01);
        }
      }
    }

    return DateTime(1500, 01, 01);
  }
}
