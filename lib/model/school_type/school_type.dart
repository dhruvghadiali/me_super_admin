class SchoolType {
  String id;
  String schoolType;
  DateTime createdAt;

  SchoolType({
    required this.id,
    required this.schoolType,
    required this.createdAt,
  });

  factory SchoolType.fromJson(Map<String, dynamic> json) {
    return SchoolType(
      id: setId(json),
      schoolType: setSchoolType(json),
      createdAt: setCreatedAt(json),
    );
  }

  SchoolType copyWith({String? id, String? schoolType, DateTime? createdAt}) =>
      SchoolType(
        id: id ?? this.id,
        schoolType: schoolType ?? this.schoolType,
        createdAt: createdAt ?? this.createdAt,
      );

  static SchoolType defaultValues() =>
      SchoolType(id: '', schoolType: '', createdAt: DateTime(1500, 01, 01));

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
}
