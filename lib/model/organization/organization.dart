import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/model/state/state.dart';
import 'package:me_super_admin/model/zipcode/zipcode.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/model/area_name/area_name.dart';

/*
 * Represents an organization with its details and associated location information.
 *
 * This model includes fields for organization identification, contact details,
 * government registration, address, and location hierarchy (state, district, city, etc.).
 * It also tracks metadata such as creation and update timestamps, and the users
 * responsible for these actions.
 */
class Organization {
  String id;
  String name;
  String shortName;
  String email;
  String phoneNumber;
  String governmentRegistrationNumber;
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

  Organization({
    required this.id,
    required this.name,
    required this.shortName,
    required this.email,
    required this.phoneNumber,
    required this.governmentRegistrationNumber,
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
   * Creates an `Organization` instance from a JSON object.
   *
   * This factory constructor parses the JSON object to initialize the fields of
   * the `Organization` model. It uses helper methods to handle nested objects
   * and default values for missing or invalid data.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - An `Organization` instance populated with data from the JSON object.
   */
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: setId(json),
      name: setName(json),
      shortName: setShortName(json),
      email: setEmail(json),
      phoneNumber: setPhoneNumber(json),
      governmentRegistrationNumber: setGovernmentRegistrationNumber(json),
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
   * Creates a copy of the current `Organization` instance with updated fields.
   *
   * This method allows selective updates to the fields of an `Organization` instance
   * while retaining the values of other fields.
   *
   * Parameters:
   * - Optional named parameters for each field in the `Organization` model.
   *
   * Returns:
   * - A new `Organization` instance with the updated fields.
   */
  Organization copyWith({
    String? id,
    String? name,
    String? shortName,
    String? email,
    String? phoneNumber,
    String? governmentRegistrationNumber,
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
  }) => Organization(
    id: id ?? this.id,
    name: name ?? this.name,
    shortName: shortName ?? this.shortName,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    governmentRegistrationNumber:
        governmentRegistrationNumber ?? this.governmentRegistrationNumber,
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
   * Provides default values for an `Organization` instance.
   *
   * This static method returns an `Organization` instance with default values
   * for all fields. It is useful for initializing forms or creating placeholder data.
   *
   * Returns:
   * - An `Organization` instance with default values.
   */
  static Organization defaultValues() => Organization(
    id: '',
    name: '',
    shortName: '',
    email: '',
    phoneNumber: '',
    governmentRegistrationNumber: '',
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
   * Converts the `Organization` instance to a JSON object.
   *
   * This method serializes the `Organization` instance into a map that can be
   * used for API requests or data storage.
   *
   * Returns:
   * - A map containing the JSON representation of the `Organization` instance.
   */
  Map<String, dynamic> toJson() => {
    'name': name,
    'shortName': shortName,
    'email': email,
    'phone_number': phoneNumber,
    'government_registration_number': governmentRegistrationNumber,
    'address': address,
    'state': state.id,
    'district': district.id,
    'city': city.id,
    'area_name': areaName.id,
    'zipcode': zipcode.id,
  };

  /*
   * Helper methods to parse and validate JSON fields.
   *
   * These static methods handle the extraction and validation of individual fields
   * from a JSON object. They provide default values for missing or invalid data.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - The parsed and validated value for the respective field.
   */

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
      if (json['id'] != null &&
          json['id'] is String &&
          json['id'].toString().isNotEmpty) {
        return json['id'];
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
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated name string.
   */
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

  /*
   * Parses and validates the short name field from a JSON object.
   *
   * This method extracts the 'short_name' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns an
   * empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated short name string.
   */
  static String setShortName(Map<String, dynamic> json) {
    if (json.containsKey('short_name')) {
      if (json['short_name'] != null &&
          json['short_name'] is String &&
          json['short_name'].toString().isNotEmpty) {
        return json['short_name'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the email field from a JSON object.
   *
   * This method extracts the 'email' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns an
   * empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated email string.
   */
  static String setEmail(Map<String, dynamic> json) {
    if (json.containsKey('email')) {
      if (json['email'] != null &&
          json['email'] is String &&
          json['email'].toString().isNotEmpty) {
        return json['email'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the phone number field from a JSON object.
   *
   * This method extracts the 'phone_number' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns an
   * empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated phone number string.
   */
  static String setPhoneNumber(Map<String, dynamic> json) {
    if (json.containsKey('phone_number')) {
      if (json['phone_number'] != null &&
          json['phone_number'] is String &&
          json['phone_number'].toString().isNotEmpty) {
        return json['phone_number'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the government registration number field from a JSON object.
   *
   * This method extracts the 'government_registration_number' field from the JSON object
   * and ensures it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated government registration number string.
   */
  static String setGovernmentRegistrationNumber(Map<String, dynamic> json) {
    if (json.containsKey('government_registration_number')) {
      if (json['government_registration_number'] != null &&
          json['government_registration_number'] is String &&
          json['government_registration_number'].toString().isNotEmpty) {
        return json['government_registration_number'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the address field from a JSON object.
   *
   * This method extracts the 'address' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns an
   * empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated address string.
   */
  static String setAddress(Map<String, dynamic> json) {
    if (json.containsKey('address')) {
      if (json['address'] != null &&
          json['address'] is String &&
          json['address'].toString().isNotEmpty) {
        return json['address'];
      }
    }

    return '';
  }

  /*
   * Parses and validates the state field from a JSON object.
   *
   * This method extracts the 'state' field from the JSON object and converts it
   * into a `State` object. If the field is missing or invalid, it returns a default
   * `State` instance.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A `State` object representing the organization's state.
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
   * This method extracts the 'district' field from the JSON object and converts it
   * into a `District` object. If the field is missing or invalid, it returns a default
   * `District` instance.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A `District` object representing the organization's district.
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
   * This method extracts the 'city' field from the JSON object and converts it
   * into a `City` object. If the field is missing or invalid, it returns a default
   * `City` instance.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A `City` object representing the organization's city.
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
   * This method extracts the 'area_name' field from the JSON object and converts it
   * into an `AreaName` object. If the field is missing or invalid, it returns a default
   * `AreaName` instance.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - An `AreaName` object representing the organization's area name.
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
   * This method extracts the 'zipcode' field from the JSON object and converts it
   * into a `Zipcode` object. If the field is missing or invalid, it returns a default
   * `Zipcode` instance.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A `Zipcode` object representing the organization's zipcode.
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
   * Parses and validates the active status field from a JSON object.
   *
   * This method extracts the 'is_active' field from the JSON object and ensures
   * it is a boolean value. If the field is missing or invalid, it returns `false`
   * as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A boolean indicating whether the organization is active.
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
   * Parses and validates the created by field from a JSON object.
   *
   * This method extracts the 'created_by' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns an
   * empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated created by string.
   */
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

  /*
   * Parses and validates the updated by field from a JSON object.
   *
   * This method extracts the 'updated_by' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns an
   * empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A validated updated by string.
   */
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

  /*
   * Parses and validates the created at timestamp from a JSON object.
   *
   * This method extracts the 'created_at' field from the JSON object and converts
   * it into a `DateTime` object. If the field is missing or invalid, it returns a
   * default `DateTime` instance.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A `DateTime` object representing the creation timestamp.
   */
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

  /*
   * Parses and validates the updated at timestamp from a JSON object.
   *
   * This method extracts the 'updated_at' field from the JSON object and converts
   * it into a `DateTime` object. If the field is missing or invalid, it returns a
   * default `DateTime` instance.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A `DateTime` object representing the update timestamp.
   */
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
}
