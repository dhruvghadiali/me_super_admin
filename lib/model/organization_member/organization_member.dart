import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/model/state/state.dart';
import 'package:me_super_admin/model/zipcode/zipcode.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/model/area_name/area_name.dart';

/*
 * The `OrganizationMember` class represents an organization member with various attributes
 * such as personal details, address, and metadata for tracking creation and updates.
 *
 * Attributes:
 * - `id`: Unique identifier for the organization member.
 * - `firstName`, `lastName`: Personal name details.
 * - `email`: Contact email address.
 * - `phoneNumber`: Contact phone number.
 * - `position`: Role or position of the member in the organization.
 * - `aadhaarNumber`: Unique Aadhaar number for identification.
 * - `address`: Residential or official address.
 * - `state`, `district`, `city`, `areaName`, `zipcode`: Address components.
 * - `isActive`: Indicates if the member is currently active.
 * - `createdBy`, `updatedBy`: Metadata for tracking who created or updated the record.
 * - `createdAt`, `updatedAt`: Timestamps for creation and last update.
 */
class OrganizationMember {
  String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String position;
  String aadhaarNumber;
  String address;
  State state;
  District district;
  City city;
  AreaName areaName;
  Zipcode zipcode;
  bool isActive;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;

  /*
   * Constructor for the `OrganizationMember` class.
   *
   * Parameters:
   * - All attributes are required to ensure a complete representation of the member.
   */
  OrganizationMember({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.position,
    required this.aadhaarNumber,
    required this.address,
    required this.state,
    required this.district,
    required this.city,
    required this.areaName,
    required this.zipcode,
    required this.isActive,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  /*
   * Factory method `fromJson` to create an `OrganizationMember` instance from a JSON object.
   *
   * Parameters:
   * - `json`: A map containing key-value pairs representing the member's attributes.
   *
   * Returns:
   * - An `OrganizationMember` instance populated with data from the JSON object.
   */
  factory OrganizationMember.fromJson(Map<String, dynamic> json) {
    return OrganizationMember(
      id: setId(json),
      firstName: setFirstName(json),
      lastName: setLastName(json),
      email: setEmail(json),
      phoneNumber: setPhoneNumber(json),
      position: setPosition(json),
      aadhaarNumber: setAadhaarNumber(json),
      address: setAddress(json),
      state: setState(json),
      district: setDistrict(json),
      city: setCity(json),
      areaName: setAreaName(json),
      zipcode: setZipcode(json),
      isActive: setIsActive(json),
      createdBy: setCreatedBy(json),
      updatedBy: setUpdatedBy(json),
      createdAt: setCreatedAt(json),
      updatedAt: setUpdatedAt(json),
    );
  }

  /*
   * Method `copyWith` to create a new `OrganizationMember` instance with updated attributes.
   *
   * Parameters:
   * - Optional named parameters for each attribute.
   *
   * Returns:
   * - A new `OrganizationMember` instance with updated values for the specified attributes.
   */
  OrganizationMember copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? position,
    String? aadhaarNumber,
    String? address,
    State? state,
    District? district,
    City? city,
    AreaName? areaName,
    Zipcode? zipcode,
    bool? isActive,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => OrganizationMember(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    position: position ?? this.position,
    aadhaarNumber: aadhaarNumber ?? this.aadhaarNumber,
    address: address ?? this.address,
    state: state ?? this.state,
    district: district ?? this.district,
    city: city ?? this.city,
    areaName: areaName ?? this.areaName,
    zipcode: zipcode ?? this.zipcode,
    isActive: isActive ?? this.isActive,
    createdBy: createdBy ?? this.createdBy,
    updatedBy: updatedBy ?? this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  /*
   * Static method `defaultValues` to create an `OrganizationMember` instance with default values.
   *
   * Returns:
   * - An `OrganizationMember` instance with pre-defined default values for all attributes.
   */
  static OrganizationMember defaultValues() => OrganizationMember(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    phoneNumber: '',
    position: '',
    aadhaarNumber: '',
    address: '',
    state: State.defaultValues(),
    district: District.defaultValues(),
    city: City.defaultValues(),
    areaName: AreaName.defaultValues(),
    zipcode: Zipcode.defaultValues(),
    isActive: true,
    createdBy: '',
    updatedBy: '',
    createdAt: DateTime(1500, 01, 01),
    updatedAt: DateTime(1500, 01, 01),
  );

  /*
   * Method `toJson` to convert an `OrganizationMember` instance into a JSON object.
   *
   * Returns:
   * - A map containing key-value pairs representing the member's attributes.
   */
  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'phone_number': phoneNumber,
    'position': position,
    'aadhaar_number': aadhaarNumber,
    'address': address,
    'state': state.id,
    'district': district.id,
    'city': city.id,
    'area_name': areaName.id,
    'zipcode': zipcode.id,
  };

  /*
   * Parses and validates the ID field from a JSON object.
   *
   * This method extracts the 'id' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
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
   * Parses and validates the first name field from a JSON object.
   *
   * This method extracts the 'first_name' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated first name string.
   */
  static String setFirstName(Map<String, dynamic> json) {
    if (json.containsKey('first_name')) {
      if (json['first_name'] != null && json['first_name'] is String && json['first_name'].toString().isNotEmpty) {
        return json['first_name'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the last name field from a JSON object.
   *
   * This method extracts the 'last_name' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated last name string.
   */
  static String setLastName(Map<String, dynamic> json) {
    if (json.containsKey('last_name')) {
      if (json['last_name'] != null && json['last_name'] is String && json['last_name'].toString().isNotEmpty) {
        return json['last_name'];
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
   * - `json`: A map containing the JSON representation of the organization.
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
   * - `json`: A map containing the JSON representation of the organization.
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
   * Parses and validates the position field from a JSON object.
   *
   * This method extracts the 'position' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated position string.
   */
  static String setPosition(Map<String, dynamic> json) {
    if (json.containsKey('position')) {
      if (json['position'] != null && json['position'] is String && json['position'].toString().isNotEmpty) {
        return json['position'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the Aadhaar number field from a JSON object.
   *
   * This method extracts the 'aadhaar_number' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated Aadhaar number string.
   */
  static String setAadhaarNumber(Map<String, dynamic> json) {
    if (json.containsKey('aadhaar_number')) {
      if (json['aadhaar_number'] != null && json['aadhaar_number'] is String && json['aadhaar_number'].toString().isNotEmpty) {
        return json['aadhaar_number'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the address field from a JSON object.
   *
   * This method extracts the 'address' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated address string.
   */
  static String setAddress(Map<String, dynamic> json) {
    if (json.containsKey('address')) {
      if (json['address'] != null && json['address'] is String && json['address'].toString().isNotEmpty) {
        return json['address'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the state field from a JSON object.
   *
   * This method extracts the 'state' field from the JSON object and converts
   * it into a `State` object. If the field is missing or invalid, it returns
   * a default `State` object.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A `State` object.
   */
  static State setState(Map<String, dynamic> json) {
    if (json.containsKey('state')) {
      if (json['state'] != null) {
        return State.fromJson(json['state']);
      }
    }
    return State.defaultValues();
  }

  /*
   * Parses and validates the district field from a JSON object.
   *
   * This method extracts the 'district' field from the JSON object and converts
   * it into a `District` object. If the field is missing or invalid, it returns
   * a default `District` object.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A `District` object.
   */
  static District setDistrict(Map<String, dynamic> json) {
    if (json.containsKey('district')) {
      if (json['district'] != null) {
        return District.fromJson(json['district']);
      }
    }
    return District.defaultValues();
  }

  /*
   * Parses and validates the city field from a JSON object.
   *
   * This method extracts the 'city' field from the JSON object and converts
   * it into a `City` object. If the field is missing or invalid, it returns
   * a default `City` object.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A `City` object.
   */
  static City setCity(Map<String, dynamic> json) {
    if (json.containsKey('city')) {
      if (json['city'] != null) {
        return City.fromJson(json['city']);
      }
    }
    return City.defaultValues();
  }

  /*
   * Parses and validates the area name field from a JSON object.
   *
   * This method extracts the 'area_name' field from the JSON object and converts
   * it into an `AreaName` object. If the field is missing or invalid, it returns
   * a default `AreaName` object.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - An `AreaName` object.
   */
  static AreaName setAreaName(Map<String, dynamic> json) {
    if (json.containsKey('area_name')) {
      if (json['area_name'] != null) {
        return AreaName.fromJson(json['area_name']);
      }
    }
    return AreaName.defaultValues();
  }

  /*
   * Parses and validates the zipcode field from a JSON object.
   *
   * This method extracts the 'zipcode' field from the JSON object and converts
   * it into a `Zipcode` object. If the field is missing or invalid, it returns
   * a default `Zipcode` object.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A `Zipcode` object.
   */
  static Zipcode setZipcode(Map<String, dynamic> json) {
    if (json.containsKey('zipcode')) {
      if (json['zipcode'] != null) {
        return Zipcode.fromJson(json['zipcode']);
      }
    }
    return Zipcode.defaultValues();
  }

  /*
   * Parses and validates the isActive field from a JSON object.
   *
   * This method extracts the 'is_active' field from the JSON object and ensures
   * it is a boolean value. If the field is missing or invalid, it returns
   * `false` as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A boolean indicating whether the member is active.
   */
  static bool setIsActive(Map<String, dynamic> json) {
    if (json.containsKey('is_active')) {
      if (json['is_active'] != null) {
        return json['is_active'];
      }
    }
    return false;
  }

  /*
   * Parses and validates the createdBy field from a JSON object.
   *
   * This method extracts the 'created_by' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated createdBy string.
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
   * Parses and validates the updatedBy field from a JSON object.
   *
   * This method extracts the 'updated_by' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated updatedBy string.
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
   * Parses and validates the createdAt field from a JSON object.
   *
   * This method extracts the 'created_at' field from the JSON object and converts
   * it into a `DateTime` object. If the field is missing or invalid, it returns
   * a default `DateTime` object set to January 1, 1500.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A `DateTime` object representing the creation timestamp.
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
   * Parses and validates the updatedAt field from a JSON object.
   *
   * This method extracts the 'updated_at' field from the JSON object and converts
   * it into a `DateTime` object. If the field is missing or invalid, it returns
   * a default `DateTime` object set to January 1, 1500.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A `DateTime` object representing the last update timestamp.
   */
  static DateTime setUpdatedAt(Map<String, dynamic> json) {
    if (json.containsKey('updated_at')) {
      if (json['updated_at'] != null && json['updated_at'] is String && json['updated_at'].toString().isNotEmpty) {
        try {
          return DateTime.parse(json['updated_at']).toUtc();
        } catch (e) {
          return DateTime(1500, 01, 01);
        }
      }
    }

    return DateTime(1500, 01, 01);
  }
}
