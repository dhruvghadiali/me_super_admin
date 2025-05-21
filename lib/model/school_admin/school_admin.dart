/*
 * The `SchoolAdmin` class represents a school admin entity with various attributes
 * such as first name, last name, email, phone number, and username.
 *
 * Attributes:
 * - `id`: Unique identifier for the school admin.
 * - `firstName`: First name of the school admin.
 * - `lastName`: Last name of the school admin.
 * - `email`: Email address of the school admin.
 * - `phoneNumber`: Phone number of the school admin.
 * - `username`: Username of the school admin.
 * - `isActive`: Indicates if the school admin account is active.
 * - `isAccountVerified`: Indicates if the school admin account is verified.
 */
class SchoolAdmin {
  String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String username;
  bool isActive;
  bool isAccountVerified;

  /*
   * Constructor for the `SchoolAdmin` class.
   *
   * Parameters:
   * - All attributes are required to ensure a complete representation of the school admin.
   */
  SchoolAdmin({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.username,
    required this.isActive,
    required this.isAccountVerified,
  });

  /*
   * Factory method `fromJson` to create a `SchoolAdmin` instance from a JSON object.
   *
   * Parameters:
   * - `json`: A map containing key-value pairs representing the school admin attributes.
   *
   * Returns:
   * - A `SchoolAdmin` instance populated with data from the JSON object.
   */
  factory SchoolAdmin.fromJson(Map<String, dynamic> json) {
    return SchoolAdmin(
      id: setId(json),
      firstName: setFirstName(json),
      lastName: setLastName(json),
      email: setEmail(json),
      phoneNumber: setPhoneNumber(json),
      username: setUserName(json),
      isActive: setIsActive(json),
      isAccountVerified: setIsAccountVerified(json),
    );
  }

  /*
   * Method `copyWith` to create a new `SchoolAdmin` instance with updated attributes.
   *
   * Parameters:
   * - Optional named parameters for each attribute.
   *
   * Returns:
   * - A new `SchoolAdmin` instance with updated values for the specified attributes.
   */
  SchoolAdmin copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? username,
    bool? isActive,
    bool? isAccountVerified,
  }) => SchoolAdmin(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    username: username ?? this.username,
    isActive: isActive ?? this.isActive,
    isAccountVerified: isAccountVerified ?? this.isAccountVerified,
  );

  /*
   * Static method `defaultValues` to create a `SchoolAdmin` instance with default values.
   *
   * Returns:
   * - A `SchoolAdmin` instance with pre-defined default values for all attributes.
   */
  static SchoolAdmin defaultValues() =>
      SchoolAdmin(id: '', firstName: '', lastName: '', email: '', phoneNumber: '', username: '', isActive: false, isAccountVerified: false);

  /*
   * Method `toJson` to convert a `SchoolAdmin` instance into a JSON object.
   *
   * Returns:
   * - A map containing key-value pairs representing the school's attributes.
   */
  Map<String, dynamic> toJson() => {'first_name': firstName, 'last_name': lastName, 'email': email, 'phone_number': phoneNumber};

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
   * Parses and validates the first name field from a JSON object.
   *
   * This method extracts the 'first_name' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school address.
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
   * - `json`: A map containing the JSON representation of the school address.
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
   * - `json`: A map containing the JSON representation of the school address.
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
   * - `json`: A map containing the JSON representation of the school address.
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
   * Parses and validates the username field from a JSON object.
   *
   * This method extracts the 'username' field from the JSON object and ensures
   * it is a non-empty string. If the field is missing or invalid, it returns
   * an empty string as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school address.
   *
   * Returns:
   * - A validated username string.
   */
  static String setUserName(Map<String, dynamic> json) {
    if (json.containsKey('username')) {
      if (json['username'] != null && json['username'] is String && json['username'].toString().isNotEmpty) {
        return json['username'];
      }
    }
    return '';
  }

  /*
   * Parses and validates the isActive field from a JSON object.
   *
   * This method extracts the 'is_active' field from the JSON object and ensures
   * it is a boolean value. If the field is missing or invalid, it returns
   * false as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school address.
   *
   * Returns:
   * - A validated isActive boolean value.
   */
  static bool setIsActive(Map<String, dynamic> json) {
    if (json.containsKey('is_active')) {
      if (json['is_active'] != null) {
        if (json['is_active'] is bool) {
          return json['is_active'];
        } else if (json['is_active'] is int) {
          return json['is_active'] != 0;
        } else if (json['is_active'] is String) {
          return json['is_active'].toLowerCase() == 'true' || json['is_active'] == '1';
        }
      }
    }
    return false;
  }

  /*
   * Parses and validates the isAccountVerified field from a JSON object.
   *
   * This method extracts the 'is_account_verified' field from the JSON object and ensures
   * it is a boolean value. If the field is missing or invalid, it returns
   * false as the default value.
   *
   * Parameters:
   * - `json`: A map containing the JSON representation of the school address.
   *
   * Returns:
   * - A validated isAccountVerified boolean value.
   */
  static bool setIsAccountVerified(Map<String, dynamic> json) {
    if (json.containsKey('is_account_verified')) {
      if (json['is_account_verified'] != null) {
        if (json['is_account_verified'] is bool) {
          return json['is_account_verified'];
        } else if (json['is_account_verified'] is int) {
          return json['is_account_verified'] != 0;
        } else if (json['is_account_verified'] is String) {
          return json['is_account_verified'].toLowerCase() == 'true' || json['is_account_verified'] == '1';
        }
      }
    }
    return false;
  }
}
