enum AppEnvironment { production, uat, development, demo }

enum AppHttpRequestStatus {
  isSuccessfullyServiced,
  unAuthorizedUser,
  notSuccessfullyServiced,
  error,
}

enum AppRequiredDocumentStatus { required, notRequired, optional }

enum AppSnackbarStatus { success, warning, error }

enum AppColorScheme { primary, secondary }

enum SchoolFormStepName { organization, organizationMembers, school, schoolAddresses, schoolAdmin }

enum EditSchoolInformationHeader { organization, organizationMembers, school, schoolAddress }
