class SchoolAdminValidationMessage {
  static const String firstNameRequired = 'First name is required';
  static const String firstNameMaxLength = 'First name must be at most 25 characters long';
  static const String firstNameMinLength = 'First name must be at least 2 characters long';
  static const String lastNameRequired = 'Last name is required';
  static const String lastNameMaxLength = 'Last name must be at most 25 characters long';
  static const String lastNameMinLength = 'Last name must be at least 2 characters long';
  static const String schoolAdminEmailRequired = "Email is required";
  static const String schoolAdminEmailMaxLength = "Email must be less then 100 characters";
  static const String schoolAdminEmailMinLength = "Email must be greater then 5 characters";
  static const String schoolAdminEmailInvalid = "Please enter a valid email address";
  static const String schoolAdminPhoneNumberRequired = "School admin phone number is required";
  static const String schoolAdminPhoneNumberLength = "Phone number must be 10 digits";
}
