// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomePatient => 'Welcome Patient';

  @override
  String get welcomeDoctor => 'Welcome Doctor';

  @override
  String get welcomeAdmin => 'Welcome Staff';

  @override
  String get signInText => 'Sign in to your account';

  @override
  String get registerText => 'Create an account';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get signUpPrompt => 'Don\'t have an account?';

  @override
  String get signInPrompt => 'Already have an account?';

  @override
  String get signInButton => 'Sign In';

  @override
  String get signUpButton => 'Sign Up';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get backButtonTooltip => 'Go back';

  @override
  String get emailHint => 'Email Address';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordHint => 'Password';

  @override
  String get passwordLabel => 'Password';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get uploadPhoto => 'Upload photo';

  @override
  String get fullNameHint => 'Full name';

  @override
  String get ageHint => 'Age';

  @override
  String get genderHint => 'Gender';

  @override
  String get createAccount => 'Create account';

  @override
  String get addNewDoctor => 'Add New Doctor';

  @override
  String get logout => 'Logout';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get specialityHint => 'Speciality';

  @override
  String get specialityLabel => 'Speciality';

  @override
  String get welcomeText => 'Welcome';

  @override
  String get selectUserType => 'Select your user type:';

  @override
  String get patient => 'Patient';

  @override
  String get doctor => 'Doctor';

  @override
  String get staff => 'Staff';

  @override
  String get continueText => 'Continue';

  @override
  String get selectTypeError => 'Please select your user type';

  @override
  String get welcome => 'Welcome';

  @override
  String get appointmentToday => 'Appointment Today';

  @override
  String get noAppointmentToday => 'No Appointment Today';

  @override
  String get category => 'Category';

  @override
  String get topDoctors => 'Top Doctors';

  @override
  String get noDoctorsAvailable => 'No doctors available';

  @override
  String get yearsOld => 'Years Old';

  @override
  String get profile => 'Profile';

  @override
  String get appointmentSchedule => 'Appointment Schedule';

  @override
  String get noAppointments => 'No Appointments Scheduled';

  @override
  String get upcomingAppointments => 'Your upcoming appointments will appear here';

  @override
  String get cancel => 'Cancel';

  @override
  String get reschedule => 'Reschedule';

  @override
  String get historyTitle => 'History';

  @override
  String get noAppointmentsFound => 'No Appointments Found';

  @override
  String get appointmentHistoryHint => 'Your appointment history will appear here';

  @override
  String get deleteButton => 'Delete';

  @override
  String get appointmentTitle => 'Appointment';

  @override
  String get selectConsultationTime => 'Select Consultation Time';

  @override
  String get weekendNotAvailable => 'Weekend is not available, please select another date';

  @override
  String get timeAm => 'AM';

  @override
  String get timePm => 'PM';

  @override
  String get updateAppointment => 'Update Appointment';

  @override
  String get makeAppointment => 'Make Appointment';

  @override
  String appointmentUpdatedSuccessfully(Object doctorName) {
    return 'Your appointment with $doctorName has been updated successfully.';
  }

  @override
  String appointmentScheduledSuccessfully(Object doctorName) {
    return 'Your appointment with $doctorName has been scheduled successfully.';
  }

  @override
  String get general => 'General';

  @override
  String get cardiology => 'Cardiology';

  @override
  String get respirations => 'Respirations';

  @override
  String get dermatology => 'Dermatology';

  @override
  String get gynecology => 'Gynecology';

  @override
  String get dental => 'Dental';

  @override
  String get doctorDetailsTitle => 'Doctor Details';

  @override
  String get bookAppointment => 'Book Appointment';

  @override
  String doctorNameTitle(Object name) {
    return 'Dr $name';
  }

  @override
  String get doctorQualifications => 'MBBS (International Medical University, Malaysia), MRCP (Royal College of Physicians, United Kingdom)';

  @override
  String get hospitalName1 => 'Sarawak General Hospital';

  @override
  String get hospitalName2 => 'Royal Cardiac Center';

  @override
  String get hospitalName3 => 'National Respiratory Institute';

  @override
  String get hospitalName4 => 'Harmony General Hospital';

  @override
  String get aboutDoctorTitle => 'About Doctor';

  @override
  String doctorDescription(Object hospitalName, Object name, Object speciality) {
    return 'Dr. $name is an experience $speciality Specialist at Sarawak, graduated since 2008, and completed his/her training at Sungai Buloh General Hospital.';
  }

  @override
  String get patientsLabel => 'Patients';

  @override
  String get experienceLabel => 'Experiences';

  @override
  String yearsOfExperience(Object years) {
    return '$years years';
  }

  @override
  String get ratingLabel => 'Rating';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get time_9am => '9:00 AM';

  @override
  String get time_10am => '10:00 AM';

  @override
  String get time_11am => '11:00 AM';

  @override
  String get time_12pm => '12:00 PM';

  @override
  String get time_1pm => '13:00 PM';

  @override
  String get time_2pm => '14:00 PM';

  @override
  String get time_3pm => '15:00 PM';

  @override
  String get time_4pm => '16:00 PM';

  @override
  String get home => 'Home';

  @override
  String get history => 'History';

  @override
  String get appointments => 'Appointments';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get male => 'male';

  @override
  String get female => 'female';

  @override
  String get markCompleted => 'Completed';

  @override
  String get bookingFailed => 'Unavailable Appointment';

  @override
  String get emailValidation => 'Incorrect email form';

  @override
  String get passwordValidation => 'password must be atleast 6 digits';

  @override
  String get nullValidation => 'This Field is Required';

  @override
  String get pictureValidation => 'Please Enter A Profile Picture';

  @override
  String get userNotFound => 'No user found for that email';

  @override
  String get wrongPassword => 'Wrong password provided for that user';

  @override
  String get emailInUse => 'email already in use';

  @override
  String get weakPassword => 'The password provided is too weak';

  @override
  String get doctorAddSuccess => 'successfully added doctor';

  @override
  String get rightUserTypeValidation => 'please select the right user type';

  @override
  String get ok => 'Ok';

  @override
  String get resetPasswordRequest => 'request was sent to ur email';

  @override
  String get resetPasswordRequestButtonText => 'Send Password Reset';
}
