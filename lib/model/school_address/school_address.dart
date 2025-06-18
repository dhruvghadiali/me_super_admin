import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/model/state/state.dart';
import 'package:me_super_admin/model/zipcode/zipcode.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/model/area_name/area_name.dart';

/*
 * The `SchoolAddress` class represents a school address entity with various attributes
 * such as address, state, district, city, area name, zipcode for tracking creation and updates.
 *
 * Attributes:
 * - `id`: Unique identifier for the school.
 * - `address`: Address of the school.
 * - `state`: State object representing the state of the school.
 * - `district`: District object representing the district of the school.
 * - `city`: City object representing the city of the school.
 * - `areaName`: AreaName object representing the area name of the school.
 * - `zipcode`: Zipcode object representing the zipcode of the school.
 * - `isActive`: Indicates if the school is currently active.
 * - `createdBy`, `updatedBy`: Metadata for tracking who created or updated the record.
 * - `createdAt`, `updatedAt`: Timestamps for creation and last update.
 */
class SchoolAddress {
  String id;
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
  String userId;

  /*
   * Constructor for the `SchoolAddress` class.
   *
   * Parameters:
   * - All attributes are required to ensure a complete representation of the school address.
   */
  SchoolAddress({
    required this.id,
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
    required this.userId,
  });

  /*
   * Factory method `fromJson` to create a `SchoolAddress` instance from a JSON object.
   *
   * Parameters:
   * - `json`: A map containing key-value pairs representing the school address attributes.
   *
   * Returns:
   * - A `SchoolAddress` instance populated with data from the JSON object.
   */
  factory SchoolAddress.fromJson(Map<String, dynamic> json) {
    return SchoolAddress(
      id: setId(json),
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
      userId: setUserId(json),
    );
  }

  /*
   * Method `copyWith` to create a new `SchoolAddress` instance with updated attributes.
   *
   * Parameters:
   * - Optional named parameters for each attribute.
   *
   * Returns:
   * - A new `SchoolAddress` instance with updated values for the specified attributes.
   */
  SchoolAddress copyWith({
    String? id,
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
    String? userId,
  }) => SchoolAddress(
    id: id ?? this.id,
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
    userId: userId ?? this.userId,
  );

  /*
   * Static method `defaultValues` to create a `SchoolAddress` instance with default values.
   *
   * Returns:
   * - A `SchoolAddress` instance with pre-defined default values for all attributes.
   */
  static SchoolAddress defaultValues() => SchoolAddress(
    id: '',
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
    userId: '',
  );

  /*
   * Method `toJson` to convert a `SchoolAddress` instance into a JSON object.
   *
   * Returns:
   * - A map containing key-value pairs representing the school's attributes.
   */
  Map<String, dynamic> toJson() => {
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
   * - `json`: A map containing the JSON representation of the school address.
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
   * Parses and validates the address field from a JSON object.
   *
   * This method extracts the 'address' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school address.
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
   * Parses and validates the isActive field from a JSON object.
   *
   * This method extracts the 'is_active' field from the JSON object and ensures
   * it is a boolean value. If the field is missing or invalid, it returns false as
   * the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the organization.
   *
   * Returns:
   * - A boolean indicating if the organization is active.
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
      if (json['updated_by'] != null && json['updated_by'] is String && json['updated_by'].toString().isNotEmpty) {
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

  /*
   * Parses and validates the user id field from a JSON object.
   *
   * This method extracts the 'user_id' field from the JSON object and ensures it is a
   * non-empty string. If the field is missing or invalid, it returns an empty string as
   * the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school address.
   *
   * Returns:
   * - An `String` value representing the school address user id.
   */
  static String setUserId(Map<String, dynamic> json) {
    if (json.containsKey('user_id')) {
      if (json['user_id'] != null && json['user_id'] is String && json['user_id'].toString().isNotEmpty) {
        return json['user_id'];
      }
    }
    return '';
  }
}
