import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// Welcome message for patients
  ///
  /// In en, this message translates to:
  /// **'Welcome Patient'**
  String get welcomePatient;

  /// Welcome message for doctors
  ///
  /// In en, this message translates to:
  /// **'Welcome Doctor'**
  String get welcomeDoctor;

  /// Welcome message for admins
  ///
  /// In en, this message translates to:
  /// **'Welcome Staff'**
  String get welcomeAdmin;

  /// Sign in heading text
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account'**
  String get signInText;

  /// Registration heading text
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get registerText;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Prompt to sign up when in sign in mode
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get signUpPrompt;

  /// Prompt to sign in when in sign up mode
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get signInPrompt;

  /// Text for sign in button
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// Sign up button text
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// Change language button text
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// Tooltip for back button
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get backButtonTooltip;

  /// Hint text for email input field
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailHint;

  /// Label text for email input field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// Hint text for password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// Label text for password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Tooltip text for show password button
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// Tooltip text for hide password button
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// Tooltip for photo upload button
  ///
  /// In en, this message translates to:
  /// **'Upload photo'**
  String get uploadPhoto;

  /// Hint text for full name input field
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullNameHint;

  /// Hint text for age input field
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get ageHint;

  /// Hint text for gender input field
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderHint;

  /// Text for create account button
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// Title for adding new doctor screen
  ///
  /// In en, this message translates to:
  /// **'Add New Doctor'**
  String get addNewDoctor;

  /// Tooltip for logout button
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Label text for full name input field
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullNameLabel;

  /// Hint text for speciality dropdown
  ///
  /// In en, this message translates to:
  /// **'Speciality'**
  String get specialityHint;

  /// Label text for speciality dropdown
  ///
  /// In en, this message translates to:
  /// **'Speciality'**
  String get specialityLabel;

  /// No description provided for @welcomeText.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcomeText;

  /// No description provided for @selectUserType.
  ///
  /// In en, this message translates to:
  /// **'Select your user type:'**
  String get selectUserType;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// No description provided for @staff.
  ///
  /// In en, this message translates to:
  /// **'Staff'**
  String get staff;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// Error message when user doesn't select a type
  ///
  /// In en, this message translates to:
  /// **'Please select your user type'**
  String get selectTypeError;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @appointmentToday.
  ///
  /// In en, this message translates to:
  /// **'Appointment Today'**
  String get appointmentToday;

  /// No description provided for @noAppointmentToday.
  ///
  /// In en, this message translates to:
  /// **'No Appointment Today'**
  String get noAppointmentToday;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @topDoctors.
  ///
  /// In en, this message translates to:
  /// **'Top Doctors'**
  String get topDoctors;

  /// No description provided for @noDoctorsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No doctors available'**
  String get noDoctorsAvailable;

  /// No description provided for @yearsOld.
  ///
  /// In en, this message translates to:
  /// **'Years Old'**
  String get yearsOld;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @appointmentSchedule.
  ///
  /// In en, this message translates to:
  /// **'Appointment Schedule'**
  String get appointmentSchedule;

  /// No description provided for @noAppointments.
  ///
  /// In en, this message translates to:
  /// **'No Appointments Scheduled'**
  String get noAppointments;

  /// No description provided for @upcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'Your upcoming appointments will appear here'**
  String get upcomingAppointments;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @reschedule.
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get reschedule;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @noAppointmentsFound.
  ///
  /// In en, this message translates to:
  /// **'No Appointments Found'**
  String get noAppointmentsFound;

  /// No description provided for @appointmentHistoryHint.
  ///
  /// In en, this message translates to:
  /// **'Your appointment history will appear here'**
  String get appointmentHistoryHint;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @appointmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointmentTitle;

  /// No description provided for @selectConsultationTime.
  ///
  /// In en, this message translates to:
  /// **'Select Consultation Time'**
  String get selectConsultationTime;

  /// No description provided for @weekendNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Weekend is not available, please select another date'**
  String get weekendNotAvailable;

  /// No description provided for @timeAm.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get timeAm;

  /// No description provided for @timePm.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get timePm;

  /// No description provided for @updateAppointment.
  ///
  /// In en, this message translates to:
  /// **'Update Appointment'**
  String get updateAppointment;

  /// No description provided for @makeAppointment.
  ///
  /// In en, this message translates to:
  /// **'Make Appointment'**
  String get makeAppointment;

  /// No description provided for @appointmentUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your appointment with {doctorName} has been updated successfully.'**
  String appointmentUpdatedSuccessfully(Object doctorName);

  /// No description provided for @appointmentScheduledSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your appointment with {doctorName} has been scheduled successfully.'**
  String appointmentScheduledSuccessfully(Object doctorName);

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @cardiology.
  ///
  /// In en, this message translates to:
  /// **'Cardiology'**
  String get cardiology;

  /// No description provided for @respirations.
  ///
  /// In en, this message translates to:
  /// **'Respirations'**
  String get respirations;

  /// No description provided for @dermatology.
  ///
  /// In en, this message translates to:
  /// **'Dermatology'**
  String get dermatology;

  /// No description provided for @gynecology.
  ///
  /// In en, this message translates to:
  /// **'Gynecology'**
  String get gynecology;

  /// No description provided for @dental.
  ///
  /// In en, this message translates to:
  /// **'Dental'**
  String get dental;

  /// No description provided for @doctorDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Doctor Details'**
  String get doctorDetailsTitle;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointment;

  /// No description provided for @doctorNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Dr {name}'**
  String doctorNameTitle(Object name);

  /// No description provided for @doctorQualifications.
  ///
  /// In en, this message translates to:
  /// **'MBBS (International Medical University, Malaysia), MRCP (Royal College of Physicians, United Kingdom)'**
  String get doctorQualifications;

  /// No description provided for @hospitalName1.
  ///
  /// In en, this message translates to:
  /// **'Sarawak General Hospital'**
  String get hospitalName1;

  /// No description provided for @hospitalName2.
  ///
  /// In en, this message translates to:
  /// **'Royal Cardiac Center'**
  String get hospitalName2;

  /// No description provided for @hospitalName3.
  ///
  /// In en, this message translates to:
  /// **'National Respiratory Institute'**
  String get hospitalName3;

  /// No description provided for @hospitalName4.
  ///
  /// In en, this message translates to:
  /// **'Harmony General Hospital'**
  String get hospitalName4;

  /// No description provided for @aboutDoctorTitle.
  ///
  /// In en, this message translates to:
  /// **'About Doctor'**
  String get aboutDoctorTitle;

  /// No description provided for @doctorDescription.
  ///
  /// In en, this message translates to:
  /// **'Dr. {name} is an experience {speciality} Specialist at Sarawak, graduated since 2008, and completed his/her training at Sungai Buloh General Hospital.'**
  String doctorDescription(Object hospitalName, Object name, Object speciality);

  /// No description provided for @patientsLabel.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patientsLabel;

  /// No description provided for @experienceLabel.
  ///
  /// In en, this message translates to:
  /// **'Experiences'**
  String get experienceLabel;

  /// No description provided for @yearsOfExperience.
  ///
  /// In en, this message translates to:
  /// **'{years} years'**
  String yearsOfExperience(Object years);

  /// No description provided for @ratingLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get ratingLabel;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @time_9am.
  ///
  /// In en, this message translates to:
  /// **'9:00 AM'**
  String get time_9am;

  /// No description provided for @time_10am.
  ///
  /// In en, this message translates to:
  /// **'10:00 AM'**
  String get time_10am;

  /// No description provided for @time_11am.
  ///
  /// In en, this message translates to:
  /// **'11:00 AM'**
  String get time_11am;

  /// No description provided for @time_12pm.
  ///
  /// In en, this message translates to:
  /// **'12:00 PM'**
  String get time_12pm;

  /// No description provided for @time_1pm.
  ///
  /// In en, this message translates to:
  /// **'13:00 PM'**
  String get time_1pm;

  /// No description provided for @time_2pm.
  ///
  /// In en, this message translates to:
  /// **'14:00 PM'**
  String get time_2pm;

  /// No description provided for @time_3pm.
  ///
  /// In en, this message translates to:
  /// **'15:00 PM'**
  String get time_3pm;

  /// No description provided for @time_4pm.
  ///
  /// In en, this message translates to:
  /// **'16:00 PM'**
  String get time_4pm;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'female'**
  String get female;

  /// No description provided for @markCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get markCompleted;

  /// No description provided for @bookingFailed.
  ///
  /// In en, this message translates to:
  /// **'Unavailable Appointment'**
  String get bookingFailed;

  /// No description provided for @emailValidation.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email form'**
  String get emailValidation;

  /// No description provided for @passwordValidation.
  ///
  /// In en, this message translates to:
  /// **'password must be atleast 6 digits'**
  String get passwordValidation;

  /// No description provided for @nullValidation.
  ///
  /// In en, this message translates to:
  /// **'This Field is Required'**
  String get nullValidation;

  /// No description provided for @pictureValidation.
  ///
  /// In en, this message translates to:
  /// **'Please Enter A Profile Picture'**
  String get pictureValidation;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found for that email'**
  String get userNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password provided for that user'**
  String get wrongPassword;

  /// No description provided for @emailInUse.
  ///
  /// In en, this message translates to:
  /// **'email already in use'**
  String get emailInUse;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password provided is too weak'**
  String get weakPassword;

  /// No description provided for @doctorAddSuccess.
  ///
  /// In en, this message translates to:
  /// **'successfully added doctor'**
  String get doctorAddSuccess;

  /// No description provided for @rightUserTypeValidation.
  ///
  /// In en, this message translates to:
  /// **'please select the right user type'**
  String get rightUserTypeValidation;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @resetPasswordRequest.
  ///
  /// In en, this message translates to:
  /// **'request was sent to ur email'**
  String get resetPasswordRequest;

  /// No description provided for @resetPasswordRequestButtonText.
  ///
  /// In en, this message translates to:
  /// **'Send Password Reset'**
  String get resetPasswordRequestButtonText;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
