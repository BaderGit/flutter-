// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get welcomePatient => 'مرحباً بك أيها المريض';

  @override
  String get welcomeDoctor => 'مرحباً بك أيها الطبيب';

  @override
  String get welcomeAdmin => 'مرحباً بك أيها المسؤول';

  @override
  String get signInText => 'تسجيل الدخول إلى حسابك';

  @override
  String get registerText => 'إنشاء حساب جديد';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get signUpPrompt => 'ليس لديك حساب؟';

  @override
  String get signInPrompt => 'هل لديك حساب بالفعل؟';

  @override
  String get signInButton => 'تسجيل الدخول';

  @override
  String get signUpButton => 'التسجيل';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get backButtonTooltip => 'العودة';

  @override
  String get emailHint => 'البريد الإلكتروني';

  @override
  String get emailLabel => 'البريد';

  @override
  String get passwordHint => 'كلمة المرور';

  @override
  String get passwordLabel => 'كلمة السر';

  @override
  String get showPassword => 'إظهار كلمة المرور';

  @override
  String get hidePassword => 'إخفاء كلمة المرور';

  @override
  String get uploadPhoto => 'رفع صورة';

  @override
  String get fullNameHint => 'الاسم الكامل';

  @override
  String get ageHint => 'العمر';

  @override
  String get genderHint => 'الجنس';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get addNewDoctor => 'إضافة طبيب جديد';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get fullNameLabel => 'الاسم الكامل';

  @override
  String get specialityHint => 'التخصص';

  @override
  String get specialityLabel => 'التخصص';

  @override
  String get welcomeText => 'مرحباً';

  @override
  String get selectUserType => 'اختر نوع المستخدم:';

  @override
  String get patient => 'مريض';

  @override
  String get doctor => 'طبيب';

  @override
  String get staff => 'موظف';

  @override
  String get continueText => 'متابعة';

  @override
  String get selectTypeError => 'الرجاء اختيار نوع المستخدم';

  @override
  String get welcome => 'مرحباً';

  @override
  String get appointmentToday => 'الموعد اليوم';

  @override
  String get noAppointmentToday => 'لا يوجد موعد اليوم';

  @override
  String get category => 'الفئة';

  @override
  String get topDoctors => 'أفضل الأطباء';

  @override
  String get noDoctorsAvailable => 'لا يوجد أطباء متاحين';

  @override
  String get yearsOld => 'سنة';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get appointmentSchedule => 'جدول المواعيد';

  @override
  String get noAppointments => 'لا توجد مواعيد مجدولة';

  @override
  String get upcomingAppointments => 'ستظهر مواعيدك القادمة هنا';

  @override
  String get cancel => 'إلغاء';

  @override
  String get reschedule => 'إعادة جدولة';

  @override
  String get historyTitle => 'السجل';

  @override
  String get noAppointmentsFound => 'لا توجد مواعيد';

  @override
  String get appointmentHistoryHint => 'سوف تظهر سجل مواعيدك هنا';

  @override
  String get deleteButton => 'حذف';

  @override
  String get appointmentTitle => 'حجز موعد';

  @override
  String get selectConsultationTime => 'حدد وقت الاستشارة';

  @override
  String get weekendNotAvailable => 'العطلة الأسبوعية غير متاحة، يرجى اختيار تاريخ آخر';

  @override
  String get timeAm => 'ص';

  @override
  String get timePm => 'م';

  @override
  String get updateAppointment => 'تحديث الموعد';

  @override
  String get makeAppointment => 'حجز موعد';

  @override
  String appointmentUpdatedSuccessfully(Object doctorName) {
    return 'تم تحديث موعدك مع $doctorName بنجاح.';
  }

  @override
  String appointmentScheduledSuccessfully(Object doctorName) {
    return 'تم جدولة موعدك مع $doctorName بنجاح.';
  }

  @override
  String get general => 'عام';

  @override
  String get cardiology => 'قلب';

  @override
  String get respirations => 'تنفس';

  @override
  String get dermatology => 'جلدية';

  @override
  String get gynecology => 'نساء وتوليد';

  @override
  String get dental => 'أسنان';

  @override
  String get doctorDetailsTitle => 'تفاصيل الطبيب';

  @override
  String get bookAppointment => 'حجز موعد';

  @override
  String doctorNameTitle(Object name) {
    return 'د. $name';
  }

  @override
  String get doctorQualifications => 'بكالوريوس في الطب والجراحة (الجامعة الطبية الدولية، ماليزيا)، زمالة الكلية الملكية للأطباء (المملكة المتحدة)';

  @override
  String get hospitalName1 => 'مستشفى ساراواك العام';

  @override
  String get hospitalName2 => 'المركز الملكي للقلب';

  @override
  String get hospitalName3 => 'المعهد الوطني لأمراض الجهاز التنفسي';

  @override
  String get hospitalName4 => 'مستشفى هارموني العام';

  @override
  String get aboutDoctorTitle => 'حول الطبيب';

  @override
  String doctorDescription(Object hospitalName, Object name, Object speciality) {
    return 'الدكتور/ة $name هو/هي أخصائي $speciality ذو خبرة في ساراواك، تخرج منذ عام 2008، وأكمل تدريبه/ها في $hospitalName بولوه العام.';
  }

  @override
  String get patientsLabel => 'المرضى';

  @override
  String get experienceLabel => 'الخبرة';

  @override
  String yearsOfExperience(Object years) {
    return '$years سنوات';
  }

  @override
  String get ratingLabel => 'التقييم';

  @override
  String get monday => 'الاثنين';

  @override
  String get tuesday => 'الثلاثاء';

  @override
  String get wednesday => 'الأربعاء';

  @override
  String get thursday => 'الخميس';

  @override
  String get friday => 'الجمعة';

  @override
  String get saturday => 'السبت';

  @override
  String get sunday => 'الأحد';

  @override
  String get time_9am => '9:00 ص';

  @override
  String get time_10am => '10:00 ص';

  @override
  String get time_11am => '11:00 ص';

  @override
  String get time_12pm => '12:00 م';

  @override
  String get time_1pm => '13:00 م';

  @override
  String get time_2pm => '4:00 م';

  @override
  String get time_3pm => '15:00 م';

  @override
  String get time_4pm => '16:00 م';

  @override
  String get home => 'الرئيسية';

  @override
  String get history => 'السجل';

  @override
  String get appointments => 'المواعيد';

  @override
  String get today => 'اليوم';

  @override
  String get tomorrow => 'غداً';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get markCompleted => 'مكتمل';

  @override
  String get bookingFailed => 'هذا الموعد غير متاح';

  @override
  String get emailValidation => 'صيغة حساب خاطئة';

  @override
  String get passwordValidation => 'كلمة السر يجب ان تكون ستة خانات';

  @override
  String get nullValidation => 'هذا الحقل مطلوب';

  @override
  String get pictureValidation => 'الرجاء اختيار صورة';

  @override
  String get userNotFound => 'لم يتم العثور على المستخدم';

  @override
  String get wrongPassword => 'كلمة السر خاطئة';

  @override
  String get emailInUse => 'الحساب موجود بالفعل';

  @override
  String get weakPassword => 'كلمة السر ضعيفة';

  @override
  String get doctorAddSuccess => 'تم اضافة الطبيب بنجاح';

  @override
  String get rightUserTypeValidation => ' الرجاء اختيار المستخدم الصحيح';

  @override
  String get ok => 'تم';

  @override
  String get resetPasswordRequest => 'تم ارسال طلب اعادة تعيين كلمة السر';

  @override
  String get resetPasswordRequestButtonText => 'اعادة تعيين كلمة السر';
}
