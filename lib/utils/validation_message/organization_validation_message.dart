class OrganizationValidationMessage {
  static const String organizationNameRequired = "Organization name is required";
  static const String organizationNameMaxLength =
      "Organization name must be less then 100 characters";
  static const String organizationNameMinLength =
      "Organization name must be greater then 2 characters";
  static const String organizationShortNameMaxLength =
      "Organization name must be less then 50 characters";
  static const String organizationShortNameMinLength =
      "Organization name must be greater then 2 characters";
  static const String organizationEmailRequired = "Organization email is required";
  static const String organizationEmailMaxLength =
      "Organization email must be less then 100 characters";
  static const String organizationEmailMinLength =
      "Organization email must be greater then 10 characters";
  static const String organizationEmailInvalid = "Please enter a valid email address";
  static const String organizationPhoneNumberRequired = "Organization phone number is required";
  static const String organizationPhoneNumberLength = "Phone number must be 10 digits";
  static const String organizationGovernmentRegistrationNumberRequired =
      "Government registration number is required";
  static const String organizationGovernmentRegistrationNumberMaxLength =
      "Government registration number must be less then 50 characters";
  static const String organizationGovernmentRegistrationNumberMinLength =
      "Government registration number must be greater then 5 characters";
  static const String organizationAddressRequired = "Organization address is required";
  static const String organizationAddressMaxLength =
      "Organization address must be less then 500 characters";
  static const String organizationAddressMinLength =
      "Organization address must be greater then 10 characters";
}
