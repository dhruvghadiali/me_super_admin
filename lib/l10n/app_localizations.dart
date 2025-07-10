import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @apiRequestProcessingTitle.
  ///
  /// In en, this message translates to:
  /// **'Processing ...'**
  String get apiRequestProcessingTitle;

  /// No description provided for @apiRequestProcessingMessage.
  ///
  /// In en, this message translates to:
  /// **'Please wait your request is processing'**
  String get apiRequestProcessingMessage;

  /// No description provided for @signInFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Hello, Boss!!'**
  String get signInFormTitle;

  /// Common use for button text: Add button
  ///
  /// In en, this message translates to:
  /// **'add'**
  String get addButtonText;

  /// Common use for button text: Edit button
  ///
  /// In en, this message translates to:
  /// **'edit'**
  String get editButtonText;

  /// Common use for button text: Next button
  ///
  /// In en, this message translates to:
  /// **'next'**
  String get nextButtonText;

  /// Common use for button text: Previous button
  ///
  /// In en, this message translates to:
  /// **'previous'**
  String get previousButtonText;

  /// Common use for button text: Submit button
  ///
  /// In en, this message translates to:
  /// **'submit'**
  String get submitButtonText;

  /// Common use for dropdown text: State dropdown
  ///
  /// In en, this message translates to:
  /// **'Select State'**
  String get stateDropdownFieldLabelText;

  /// Common use for dropdown text: District dropdown
  ///
  /// In en, this message translates to:
  /// **'Select District'**
  String get districtDropdownFieldLabelText;

  /// Common use for dropdown text: City dropdown
  ///
  /// In en, this message translates to:
  /// **'Select City'**
  String get cityDropdownFieldLabelText;

  /// Common use for dropdown text: Area Name dropdown
  ///
  /// In en, this message translates to:
  /// **'Select Area Name'**
  String get areaNameDropdownFieldLabelText;

  /// Common use for dropdown text: Zipcode dropdown
  ///
  /// In en, this message translates to:
  /// **'Select Zipcode'**
  String get zipcodeDropdownFieldLabelText;

  /// Common use for text: Indian phone number code
  ///
  /// In en, this message translates to:
  /// **'+91'**
  String get indianPhoneNumberCodeText;

  /// Header text in new school summary
  ///
  /// In en, this message translates to:
  /// **'summary'**
  String get newSchoolSummaryHeaderText;

  /// Label text for organization tab in new school summary
  ///
  /// In en, this message translates to:
  /// **'organization'**
  String get newSchoolSummaryOrganizationTabLabelText;

  /// Label text for school tab in new school summary
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get newSchoolSummarySchoolTabLabelText;

  /// Label text for organization name in new school summary
  ///
  /// In en, this message translates to:
  /// **'organization name'**
  String get newSchoolSummaryOrganizationNameLabelText;

  /// Label text for organization short name in new school summary
  ///
  /// In en, this message translates to:
  /// **'organization short name'**
  String get newSchoolSummaryOrganizationShortNameLabelText;

  /// Label text for organization email in new school summary
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get newSchoolSummaryOrganizationEmailLabelText;

  /// Label text for organization phone number in new school summary
  ///
  /// In en, this message translates to:
  /// **'organization phone number'**
  String get newSchoolSummaryOrganizationPhoneNumberLabelText;

  /// Label text for organization government registration number in new school summary
  ///
  /// In en, this message translates to:
  /// **'government registration number'**
  String get newSchoolSummaryOrganizationGovernmentRegistrationNumberLabelText;

  /// Label text for organization address in new school summary
  ///
  /// In en, this message translates to:
  /// **'address'**
  String get newSchoolSummaryOrganizationAddressLabelText;

  /// Label text for organization state in new school summary
  ///
  /// In en, this message translates to:
  /// **'state'**
  String get newSchoolSummaryOrganizationStateLabelText;

  /// Label text for organization district in new school summary
  ///
  /// In en, this message translates to:
  /// **'district'**
  String get newSchoolSummaryOrganizationDistrictLabelText;

  /// Label text for organization city in new school summary
  ///
  /// In en, this message translates to:
  /// **'city'**
  String get newSchoolSummaryOrganizationCityLabelText;

  /// Label text for organization area name in new school summary
  ///
  /// In en, this message translates to:
  /// **'area name'**
  String get newSchoolSummaryOrganizationAreaNameLabelText;

  /// Label text for organization zipcode in new school summary
  ///
  /// In en, this message translates to:
  /// **'zipcode'**
  String get newSchoolSummaryOrganizationZipcodeLabelText;

  /// When organization model value is empty, show this value
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get newSchoolSummaryOrganizationEmptyValue;

  /// When organization members details not available in new school summary
  ///
  /// In en, this message translates to:
  /// **'Organization members details not available'**
  String get newSchoolSummaryOrganizationMembersNotFound;

  /// Title text for organization member in new school summary
  ///
  /// In en, this message translates to:
  /// **'organization member'**
  String get newSchoolSummaryOrganizationMemberTitle;

  /// When organization member model value is empty, show this value
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get newSchoolSummaryOrganizationMemberEmptyValue;

  /// Label text for organization member first name in new school summary
  ///
  /// In en, this message translates to:
  /// **'first name'**
  String get newSchoolSummaryOrganizationMemberFirstNameLabelText;

  /// Label text for organization member last name in new school summary
  ///
  /// In en, this message translates to:
  /// **'last name'**
  String get newSchoolSummaryOrganizationMemberLastNameLabelText;

  /// Label text for organization member email in new school summary
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get newSchoolSummaryOrganizationMemberEmailLabelText;

  /// Label text for organization member phone number in new school summary
  ///
  /// In en, this message translates to:
  /// **'phone number'**
  String get newSchoolSummaryOrganizationMemberPhoneNumberLabelText;

  /// Label text for organization member aadhaar number in new school summary
  ///
  /// In en, this message translates to:
  /// **'aadhaar number'**
  String get newSchoolSummaryOrganizationMemberAadhaarNumberLabelText;

  /// Label text for organization member position in new school summary
  ///
  /// In en, this message translates to:
  /// **'position'**
  String get newSchoolSummaryOrganizationMemberPositionLabelText;

  /// Label text for organization member address in new school summary
  ///
  /// In en, this message translates to:
  /// **'address'**
  String get newSchoolSummaryOrganizationMemberAddressLabelText;

  /// Label text for organization member state in new school summary
  ///
  /// In en, this message translates to:
  /// **'state'**
  String get newSchoolSummaryOrganizationMemberStateLabelText;

  /// Label text for organization member district in new school summary
  ///
  /// In en, this message translates to:
  /// **'district'**
  String get newSchoolSummaryOrganizationMemberDistrictLabelText;

  /// Label text for organization member city in new school summary
  ///
  /// In en, this message translates to:
  /// **'city'**
  String get newSchoolSummaryOrganizationMemberCityLabelText;

  /// Label text for organization member area name in new school summary
  ///
  /// In en, this message translates to:
  /// **'area name'**
  String get newSchoolSummaryOrganizationMemberAreaNameLabelText;

  /// Label text for organization member zipcode in new school summary
  ///
  /// In en, this message translates to:
  /// **'zipcode'**
  String get newSchoolSummaryOrganizationMemberZipcodeLabelText;

  /// Label text for school affiliate number in new school summary
  ///
  /// In en, this message translates to:
  /// **'school affiliate number'**
  String get newSchoolSummarySchoolAffiliateNumberLabelText;

  /// Label text for school name in new school summary
  ///
  /// In en, this message translates to:
  /// **'school name'**
  String get newSchoolSummarySchoolNameLabelText;

  /// Label text for school short name in new school summary
  ///
  /// In en, this message translates to:
  /// **'school short name'**
  String get newSchoolSummarySchoolShortNameLabelText;

  /// Label text for school email in new school summary
  ///
  /// In en, this message translates to:
  /// **'school email'**
  String get newSchoolSummarySchoolEmailLabelText;

  /// Label text for school phone number in new school summary
  ///
  /// In en, this message translates to:
  /// **'school phone number'**
  String get newSchoolSummarySchoolPhoneNumberLabelText;

  /// Label text for school established year in new school summary
  ///
  /// In en, this message translates to:
  /// **'school established year'**
  String get newSchoolSummarySchoolEstablishedYearLabelText;

  /// Label text for school type in new school summary
  ///
  /// In en, this message translates to:
  /// **'school type'**
  String get newSchoolSummarySchoolTypeLabelText;

  /// Label text for school education boards in new school summary
  ///
  /// In en, this message translates to:
  /// **'school education boards'**
  String get newSchoolSummarySchoolEducationBoardsLabelText;

  /// When school model value is empty, show this value
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get newSchoolSummarySchoolEmptyValue;

  /// When school address and admin details mismatch in new school summary
  ///
  /// In en, this message translates to:
  /// **'School Address and Admin details mismatch'**
  String get newSchoolSummarySchoolAddressesAndAdminsMissMatch;

  /// Title text for school address in new school summary
  ///
  /// In en, this message translates to:
  /// **'address'**
  String get newSchoolSummarySchoolAddressTitle;

  /// Title text for school admin in new school summary
  ///
  /// In en, this message translates to:
  /// **'admin'**
  String get newSchoolSummarySchoolAdminTitle;

  /// When school address model value is empty, show this value
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get newSchoolSummarySchoolAddressEmptyValue;

  /// When school admin model value is empty, show this value
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get newSchoolSummarySchoolAdminEmptyValue;

  /// Label text for school address in new school summary
  ///
  /// In en, this message translates to:
  /// **'address'**
  String get newSchoolSummarySchoolAddressLabelText;

  /// Label text for school state in new school summary
  ///
  /// In en, this message translates to:
  /// **'state'**
  String get newSchoolSummarySchoolStateLabelText;

  /// Label text for school district in new school summary
  ///
  /// In en, this message translates to:
  /// **'district'**
  String get newSchoolSummarySchoolDistrictLabelText;

  /// Label text for school city in new school summary
  ///
  /// In en, this message translates to:
  /// **'city'**
  String get newSchoolSummarySchoolCityLabelText;

  /// Label text for school area name in new school summary
  ///
  /// In en, this message translates to:
  /// **'area name'**
  String get newSchoolSummarySchoolAreaNameLabelText;

  /// Label text for school zipcode in new school summary
  ///
  /// In en, this message translates to:
  /// **'zipcode'**
  String get newSchoolSummarySchoolZipcodeLabelText;

  /// Label text for school admin first name in new school summary
  ///
  /// In en, this message translates to:
  /// **'first name'**
  String get newSchoolSummarySchoolAdminFirstNameLabelText;

  /// Label text for school admin last name in new school summary
  ///
  /// In en, this message translates to:
  /// **'last name'**
  String get newSchoolSummarySchoolAdminLastNameLabelText;

  /// Label text for school admin email in new school summary
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get newSchoolSummarySchoolAdminEmailLabelText;

  /// Label text for school admin phone number in new school summary
  ///
  /// In en, this message translates to:
  /// **'phone number'**
  String get newSchoolSummarySchoolAdminPhoneNumberLabelText;

  /// Text field label text for school affiliate number in school form
  ///
  /// In en, this message translates to:
  /// **'School affiliate number'**
  String get schoolFormSchoolAffiliateNumberTextFieldLabelText;

  /// Text field label text for school name in school form
  ///
  /// In en, this message translates to:
  /// **'School name'**
  String get schoolFormSchoolNameTextFieldLabelText;

  /// Text field label text for school short name in school form
  ///
  /// In en, this message translates to:
  /// **'School short name'**
  String get schoolFormSchoolShortNameTextFieldLabelText;

  /// Text field label text for school email in school form
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get schoolFormSchoolEmailTextFieldLabelText;

  /// Text field label text for school phone number in school form
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get schoolFormSchoolPhoneNumberTextFieldLabelText;

  /// Text field label text for school established year in school form
  ///
  /// In en, this message translates to:
  /// **'Established year'**
  String get schoolFormSchoolEstablishedYearTextFieldLabelText;

  /// Text field label text for school type in school form
  ///
  /// In en, this message translates to:
  /// **'School type'**
  String get schoolFormSchoolTypeDropdownLabelText;

  /// Text field label text for school education boards in school form
  ///
  /// In en, this message translates to:
  /// **'Education boards'**
  String get schoolFormSchoolEducationBoardsDropdownLabelText;

  /// Text field label text for organization name in organization form
  ///
  /// In en, this message translates to:
  /// **'Organization name'**
  String get organizationFormOrganizationNameTextFieldLabelText;

  /// Text field label text for organization short name in organization form
  ///
  /// In en, this message translates to:
  /// **'Organization short name'**
  String get organizationFormOrganizationShortNameTextFieldLabelText;

  /// Text field label text for organization email in organization form
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get organizationFormOrganizationEmailTextFieldLabelText;

  /// Text field label text for organization phone number in organization form
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get organizationFormOrganizationPhoneNumberTextFieldLabelText;

  /// Text field label text for organization government registration number in organization form
  ///
  /// In en, this message translates to:
  /// **'Government registration number'**
  String
  get organizationFormOrganizationGovernmentRegistrationNumberTextFieldLabelText;

  /// Text field label text for organization address in organization form
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get organizationFormOrganizationAddressTextFieldLabelText;

  /// Button text for adding a member in organization member form
  ///
  /// In en, this message translates to:
  /// **'add member'**
  String get organizationMemberFormAddMemberButtonText;

  /// Expansion tile title for organization member form
  ///
  /// In en, this message translates to:
  /// **'Organization Member Form'**
  String get organizationMemberFormExpansionTile;

  /// Text field label text for first name in organization member form
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get organizationMemberFormFirstNameTextFieldLabelText;

  /// Text field label text for last name in organization member form
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get organizationMemberFormLastNameTextFieldLabelText;

  /// Text field label text for email in organization member form
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get organizationMemberFormEmailTextFieldLabelText;

  /// Text field label text for phone number in organization member form
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get organizationMemberFormPhoneNumberTextFieldLabelText;

  /// Text field label text for aadhaar number in organization member form
  ///
  /// In en, this message translates to:
  /// **'Aadhaar number'**
  String get organizationMemberFormAadhaarNumberTextFieldLabelText;

  /// Text field label text for address in organization member form
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get organizationMemberFormAddressTextFieldLabelText;

  /// Dropdown field label text for position in organization member form
  ///
  /// In en, this message translates to:
  /// **'Select Position'**
  String get organizationMemberFormPositionDropdownFieldLabelText;

  /// Button text for adding a school address in school address form
  ///
  /// In en, this message translates to:
  /// **'Add School Address'**
  String get schoolAddressFormAddSchoolAddressButtonText;

  /// Expansion tile title for school address form
  ///
  /// In en, this message translates to:
  /// **'School Address Form'**
  String get schoolAddressFormExpansionTile;

  /// Text field label text for address in school address form
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get schoolAddressFormAddressTextFieldLabelText;

  /// Text field label text for first name in school admin form
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get schoolAdminFormFirstNameTextFieldLabelText;

  /// Text field label text for last name in school admin form
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get schoolAdminFormLastNameTextFieldLabelText;

  /// Text field label text for email in school admin form
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get schoolAdminFormEmailTextFieldLabelText;

  /// Text field label text for phone number in school admin form
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get schoolAdminFormPhoneNumberTextFieldLabelText;

  /// No description provided for @addSchoolFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Register School'**
  String get addSchoolFormTitle;

  /// No description provided for @deleteAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get deleteAlertTitle;

  /// No description provided for @deleteAlertSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete these record? This process cannot be undone'**
  String get deleteAlertSubtitle;

  /// No description provided for @restoreAlertSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to restore these record? This process cannot be undone'**
  String get restoreAlertSubtitle;

  /// No description provided for @noDataFoundTitleMessage.
  ///
  /// In en, this message translates to:
  /// **'No records found'**
  String get noDataFoundTitleMessage;

  /// No description provided for @noDataFoundSubtitleMessage.
  ///
  /// In en, this message translates to:
  /// **'Please try again later'**
  String get noDataFoundSubtitleMessage;

  /// No description provided for @usernameLabelText.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabelText;

  /// No description provided for @passwordLabelText.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabelText;

  /// No description provided for @schoolNameLabelText.
  ///
  /// In en, this message translates to:
  /// **'School name'**
  String get schoolNameLabelText;

  /// No description provided for @emailLabelText.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabelText;

  /// No description provided for @phoneNumberLabelText.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumberLabelText;

  /// No description provided for @establishedYearLabelText.
  ///
  /// In en, this message translates to:
  /// **'Established year'**
  String get establishedYearLabelText;

  /// No description provided for @affiliationNumberLabelText.
  ///
  /// In en, this message translates to:
  /// **'School affiliation number'**
  String get affiliationNumberLabelText;

  /// No description provided for @schoolTypeTextFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'School type'**
  String get schoolTypeTextFieldLabelText;

  /// No description provided for @academicClassTextFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'Academic class'**
  String get academicClassTextFieldLabelText;

  /// No description provided for @educationBoardTextFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'Education board'**
  String get educationBoardTextFieldLabelText;

  /// No description provided for @facilityTypeTextFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'Facility type'**
  String get facilityTypeTextFieldLabelText;

  /// No description provided for @facilityNameTextFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'Facility name'**
  String get facilityNameTextFieldLabelText;

  /// No description provided for @feeTypeTextFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'Fee type'**
  String get feeTypeTextFieldLabelText;

  /// No description provided for @admissionDocumentTextFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'Admission Document'**
  String get admissionDocumentTextFieldLabelText;

  /// No description provided for @stateTextFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get stateTextFieldLabelText;

  /// No description provided for @districtTextFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get districtTextFieldLabelText;

  /// No description provided for @cityTextFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get cityTextFieldLabelText;

  /// No description provided for @areaNameTextFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'Area Name'**
  String get areaNameTextFieldLabelText;

  /// No description provided for @zipcodeTextFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'Zipcode'**
  String get zipcodeTextFieldLabelText;

  /// No description provided for @schoolTypeDropdownFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'Select School Type'**
  String get schoolTypeDropdownFieldLabelText;

  /// No description provided for @educationBoardDropdownFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'Select Education Boards'**
  String get educationBoardDropdownFieldLabelText;

  /// No description provided for @schoolBoardLabelText.
  ///
  /// In en, this message translates to:
  /// **'School board'**
  String get schoolBoardLabelText;

  /// No description provided for @signInButtonText.
  ///
  /// In en, this message translates to:
  /// **'SIGNIN'**
  String get signInButtonText;

  /// No description provided for @registerSchoolButtonText.
  ///
  /// In en, this message translates to:
  /// **'REGISTER SCHOOL'**
  String get registerSchoolButtonText;

  /// No description provided for @cancelButtonText.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonText;

  /// No description provided for @deleteButtonText.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButtonText;

  /// No description provided for @restoreButtonText.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restoreButtonText;

  /// No description provided for @okButtonText.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButtonText;

  /// No description provided for @addSchoolAdminButtonText.
  ///
  /// In en, this message translates to:
  /// **'Add School Admin'**
  String get addSchoolAdminButtonText;

  /// No description provided for @organizationMemberFormValidationAlertMessage.
  ///
  /// In en, this message translates to:
  /// **'Please fill up all the organization member form details.'**
  String get organizationMemberFormValidationAlertMessage;

  /// No description provided for @schoolAdminFormExpansionTile.
  ///
  /// In en, this message translates to:
  /// **'School Admin Form'**
  String get schoolAdminFormExpansionTile;

  /// No description provided for @selectedDropdownItemsText.
  ///
  /// In en, this message translates to:
  /// **'items selected'**
  String get selectedDropdownItemsText;

  /// No description provided for @selectDropdownOptionsText.
  ///
  /// In en, this message translates to:
  /// **'select options'**
  String get selectDropdownOptionsText;

  /// No description provided for @selectDropdownOptionText.
  ///
  /// In en, this message translates to:
  /// **'select option'**
  String get selectDropdownOptionText;

  /// No description provided for @facilityTypeDropdownFieldLabelText.
  ///
  /// In en, this message translates to:
  /// **'Select Facility Type'**
  String get facilityTypeDropdownFieldLabelText;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
