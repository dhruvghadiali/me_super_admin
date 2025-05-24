import 'package:me_super_admin/model/school_type/school_type.dart';
import 'package:me_super_admin/model/education_board/education_board.dart';

/*
 * The `School` class represents a school entity with various attributes
 * such as identification, contact details, and metadata for tracking creation and updates.
 *
 * Attributes:
 * - `id`: Unique identifier for the school.
 * - `affiliateNumber`: Affiliation number of the school.
 * - `name`, `shortName`: Name details of the school.
 * - `email`, `phoneNumber`: Contact details of the school.
 * - `establishedYear`: Year the school was established.
 * - `schoolType`: Type of the school (e.g., primary, secondary).
 * - `educationBoards`: List of education boards the school is affiliated with.
 * - `isActive`: Indicates if the school is currently active.
 * - `createdBy`, `updatedBy`: Metadata for tracking who created or updated the record.
 * - `createdAt`, `updatedAt`: Timestamps for creation and last update.
 */
class School {
  String id;
  String affiliateNumber;
  String name;
  String shortName;
  String email;
  String phoneNumber;
  int establishedYear;
  SchoolType schoolType;
  List<EducationBoard> educationBoards;
  bool isActive;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;

  /*
   * Constructor for the `School` class.
   *
   * Parameters:
   * - All attributes are required to ensure a complete representation of the school.
   */
  School({
    required this.id,
    required this.affiliateNumber,
    required this.name,
    required this.shortName,
    required this.email,
    required this.phoneNumber,
    required this.establishedYear,
    required this.schoolType,
    required this.educationBoards,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  /*
   * Factory method `fromJson` to create a `School` instance from a JSON object.
   *
   * Parameters:
   * - `json`: A map containing key-value pairs representing the school's attributes.
   *
   * Returns:
   * - A `School` instance populated with data from the JSON object.
   */
  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: setId(json),
      affiliateNumber: setAffiliateNumber(json),
      name: setName(json),
      shortName: setShortName(json),
      email: setEmail(json),
      phoneNumber: setPhoneNumber(json),
      establishedYear: setEstablishedYear(json),
      schoolType: setSchoolType(json),
      educationBoards: setEducationBoards(json),
      isActive: setIsActive(json),
      createdBy: setCreatedBy(json),
      updatedBy: setUpdatedBy(json),
      createdAt: setCreatedAt(json),
      updatedAt: setUpdatedAt(json),
    );
  }

  /*
   * Method `copyWith` to create a new `School` instance with updated attributes.
   *
   * Parameters:
   * - Optional named parameters for each attribute.
   *
   * Returns:
   * - A new `School` instance with updated values for the specified attributes.
   */
  School copyWith({
    String? id,
    String? affiliateNumber,
    String? name,
    String? shortName,
    String? email,
    String? phoneNumber,
    int? establishedYear,
    SchoolType? schoolType,
    List<EducationBoard>? educationBoards,
    bool? isActive,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => School(
    id: id ?? this.id,
    affiliateNumber: affiliateNumber ?? this.affiliateNumber,
    name: name ?? this.name,
    shortName: shortName ?? this.shortName,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    establishedYear: establishedYear ?? this.establishedYear,
    schoolType: schoolType ?? this.schoolType,
    educationBoards: educationBoards ?? this.educationBoards,
    isActive: isActive ?? this.isActive,
    createdBy: createdBy ?? this.createdBy,
    updatedBy: updatedBy ?? this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  /*
   * Static method `defaultValues` to create a `School` instance with default values.
   *
   * Returns:
   * - A `School` instance with pre-defined default values for all attributes.
   */
  static School defaultValues() => School(
    id: '',
    affiliateNumber: '',
    name: '',
    shortName: '',
    email: '',
    phoneNumber: '',
    establishedYear: 0,
    schoolType: SchoolType.defaultValues(),
    educationBoards: [],
    isActive: false,
    createdBy: '',
    updatedBy: '',
    createdAt: DateTime(1500, 01, 01),
    updatedAt: DateTime(1500, 01, 01),
  );

  /*
   * Method `toJson` to convert a `School` instance into a JSON object.
   *
   * Returns:
   * - A map containing key-value pairs representing the school's attributes.
   */
  Map<String, dynamic> toJson() => {
    'affiliate_number': affiliateNumber,
    'name': name,
    'short_name': shortName,
    'email': email,
    'phone_number': phoneNumber,
    'established_year': establishedYear,
    'school_type': schoolType.id,
    'education_boards': educationBoards.map((e) => e.id).toList(),
  };

  /*
   * Parses and validates the ID field from a JSON object.
   *
   * This method extracts the 'id' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A validated ID string.
   */
  static String setId(Map<String, dynamic> json) {
    if (json.containsKey('id')) {
      if (json['id'] != null && json['id'] is String && json['id'].toString().isNotEmpty) {
        return json['id'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the affiliate number field from a JSON object.
   *
   * This method extracts the 'affiliate_number' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A validated affiliate number string.
   */
  static String setAffiliateNumber(Map<String, dynamic> json) {
    if (json.containsKey('affiliate_number')) {
      if (json['affiliate_number'] != null && json['affiliate_number'] is String && json['affiliate_number'].toString().isNotEmpty) {
        return json['affiliate_number'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the name field from a JSON object.
   *
   * This method extracts the 'name' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A validated name string.
   */
  static String setName(Map<String, dynamic> json) {
    if (json.containsKey('name')) {
      if (json['name'] != null && json['name'] is String && json['name'].toString().isNotEmpty) {
        return json['name'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the short name field from a JSON object.
   *
   * This method extracts the 'short_name' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A validated short name string.
   */
  static String setShortName(Map<String, dynamic> json) {
    if (json.containsKey('short_name')) {
      if (json['short_name'] != null && json['short_name'] is String && json['short_name'].toString().isNotEmpty) {
        return json['short_name'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the email field from a JSON object.
   *
   * This method extracts the 'email' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A validated email string.
   */
  static String setEmail(Map<String, dynamic> json) {
    if (json.containsKey('email')) {
      if (json['email'] != null && json['email'] is String && json['email'].toString().isNotEmpty) {
        return json['email'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the phone number field from a JSON object.
   *
   * This method extracts the 'phone_number' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A validated phone number string.
   */
  static String setPhoneNumber(Map<String, dynamic> json) {
    if (json.containsKey('phone_number')) {
      if (json['phone_number'] != null && json['phone_number'] is String && json['phone_number'].toString().isNotEmpty) {
        return json['phone_number'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the established year field from a JSON object.
   *
   * This method extracts the 'established_year' field from the JSON object and ensures
   * it is an integer. If the field is missing or invalid, it returns 0 as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A validated established year integer.
   */
  static int setEstablishedYear(Map<String, dynamic> json) {
    if (json.containsKey('established_year')) {
      if (json['established_year'] != null && json['established_year'] is int) {
        return json['established_year'];
      }
    }

    return 0;
  }

  /*
   * Parses and validates the school type field from a JSON object.
   *
   * This method extracts the 'school_type' field from the JSON object and ensures
   * it is a valid `SchoolType` object. If the field is missing or invalid, it returns
   * a default `SchoolType` instance.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A validated `SchoolType` object.
   */
  static SchoolType setSchoolType(Map<String, dynamic> json) {
    if (json.containsKey('school_type')) {
      if (json['school_type'] != null && json['school_type'] is Map<String, dynamic>) {
        return SchoolType.fromJson(json['school_type']);
      }
    }

    return SchoolType.defaultValues();
  }

  /*
   * Parses and validates the education boards field from a JSON object.
   *
   * This method extracts the 'education_boards' field from the JSON object and ensures
   * it is a list of `EducationBoard` objects. If the field is missing or invalid, it returns
   * an empty list as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A list of validated `EducationBoard` objects.
   */
  static List<EducationBoard> setEducationBoards(Map<String, dynamic> json) {
    if (json.containsKey('education_boards')) {
      if (json['education_boards'] != null && json['education_boards'] is List) {
        return (json['education_boards'] as List).map((e) => EducationBoard.fromJson(e as Map<String, dynamic>)).toList();
      }
    }

    return [];
  }

  /*
   * Parses and validates the active status field from a JSON object.
   *
   * This method extracts the 'is_active' field from the JSON object and ensures
   * it is a boolean. If the field is missing or invalid, it returns false as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A validated boolean indicating the active status.
   */
  static bool setIsActive(Map<String, dynamic> json) {
    if (json.containsKey('is_active')) {
      if (json['is_active'] != null && json['is_active'] is bool) {
        return json['is_active'];
      }
    }

    return false;
  }

  /*
   * Parses and validates the created by field from a JSON object.
   *
   * This method extracts the 'created_by' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A validated created by string.
   */
  static String setCreatedBy(Map<String, dynamic> json) {
    if (json.containsKey('created_by')) {
      if (json['created_by'] != null && json['created_by'] is String && json['created_by'].toString().isNotEmpty) {
        return json['created_by'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the updated by field from a JSON object.
   *
   * This method extracts the 'updated_by' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A validated updated by string.
   */
  static String setUpdatedBy(Map<String, dynamic> json) {
    if (json.containsKey('updated_by')) {
      if (json['updated_by'] != null && json['updated_by'] is String && json['updated_by'].toString().isNotEmpty) {
        return json['updated_by'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the created at timestamp from a JSON object.
   *
   * This method extracts the 'created_at' field from the JSON object and ensures
   * it is a valid `DateTime` object. If the field is missing or invalid, it returns
   * a default `DateTime` instance.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A validated `DateTime` object for the creation timestamp.
   */
  static DateTime setCreatedAt(Map<String, dynamic> json) {
    if (json.containsKey('created_at')) {
      if (json['created_at'] != null && json['created_at'] is String && json['created_at'].toString().isNotEmpty) {
        try {
          return DateTime.parse(json['created_at']);
        } catch (e) {
          return DateTime(1500, 01, 01);
        }
      }
    }

    return DateTime(1500, 01, 01);
  }

  /*
   * Parses and validates the updated at timestamp from a JSON object.
   *
   * This method extracts the 'updated_at' field from the JSON object and ensures
   * it is a valid `DateTime` object. If the field is missing or invalid, it returns
   * a default `DateTime` instance.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school.
   *
   * Returns:
   * - A validated `DateTime` object for the update timestamp.
   */
  static DateTime setUpdatedAt(Map<String, dynamic> json) {
    if (json.containsKey('updated_at')) {
      if (json['updated_at'] != null && json['updated_at'] is String && json['updated_at'].toString().isNotEmpty) {
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
