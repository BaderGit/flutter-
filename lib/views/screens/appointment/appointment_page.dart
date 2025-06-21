import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/utils/app_router.dart';
import 'package:final_project/utils/config.dart';
import 'package:final_project/views/screens/appointment/booking_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FireStoreProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Appointment Schedule',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Config.spaceSmall,

                  Expanded(
                    child: provider.allPatientAppointments.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 60,
                                  color: Colors.grey.withAlpha(102),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'No Appointments Scheduled',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.withAlpha(179),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Your upcoming appointments will appear here',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.withAlpha(128),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: provider.allPatientAppointments.length,
                            itemBuilder: ((context, index) {
                              print(
                                "${provider.allPatientAppointments.length}",
                              );
                              return Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                              "assets/doctor_9.jpg",
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                provider
                                                    .allPatientAppointments[index]!
                                                    .doctor
                                                    .name,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                provider
                                                    .allPatientAppointments[index]!
                                                    .doctor
                                                    .speciality,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      ScheduleCard(
                                        date: provider
                                            .allPatientAppointments[index]!
                                            .date,
                                        day: provider
                                            .allPatientAppointments[index]!
                                            .day,
                                        time: provider
                                            .allPatientAppointments[index]!
                                            .time,
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: OutlinedButton(
                                              onPressed: () {
                                                provider.deleteAppointment(
                                                  provider
                                                      .allPatientAppointments[index]!
                                                      .id!,
                                                );
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: Config.primaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor:
                                                    Config.primaryColor,
                                              ),
                                              onPressed: () {
                                                AppRouter.navigateToWidget(
                                                  BookingPage(
                                                    patient: provider.patient!,
                                                    doctor: provider
                                                        .allPatientAppointments[index]!
                                                        .doctor,
                                                    existingAppointment: provider
                                                        .allPatientAppointments[index],
                                                    isReschedule: true,
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Reschedule',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    super.key,
    required this.date,
    required this.day,
    required this.time,
  });
  final String date;
  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: Config.primaryColor,
            size: 15,
          ),
          const SizedBox(width: 5),
          Text(
            '$day, $date',
            style: const TextStyle(color: Config.primaryColor),
          ),
          const SizedBox(width: 20),
          const Icon(Icons.access_alarm, color: Config.primaryColor, size: 17),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              time,
              style: const TextStyle(color: Config.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
