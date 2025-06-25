import 'package:final_project/models/appointment.dart';
import 'package:final_project/utils/config.dart';
import 'package:final_project/views/widgets/appointment/appointment_card.dart';
import 'package:intl/intl.dart';

class AppointmentToday {
  static getTodaysAppointment(List<AppointmentModel> allAppointments) {
    var now = DateTime.now();
    var currentDay = DateFormat('d').format(now).toString();
    var currentMonth = DateFormat('d').format(now).toString();
    var currentYear = DateFormat('d').format(now).toString();
    List<AppointmentModel> todaysAppointments = [];

    for (var i = 0; i < allAppointments.length; i++) {
      var appointmentDate = DateFormat(
        'M/d/yyyy',
      ).parse(allAppointments[i].date);

      var appointmentDay = appointmentDate.day.toString();
      var appointmentMonth = appointmentDate.month.toString();
      var appointmentYear = appointmentDate.year.toString();

      if (currentDay == appointmentDay &&
          currentMonth == appointmentMonth &&
          currentYear == appointmentYear) {
        todaysAppointments.add(allAppointments[i]);
      }
    }
    todaysAppointments.sort();
    return AppointmentCard(
      doctor: todaysAppointments[0].doctor,
      color: Config.primaryColor,
      appointment: todaysAppointments[0],
    );
  }
}
