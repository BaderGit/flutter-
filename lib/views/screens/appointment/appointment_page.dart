import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/providers/language_provider.dart';
import 'package:final_project/utils/app_router.dart';
import 'package:final_project/utils/config.dart';
import 'package:final_project/views/screens/appointment/booking_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/l10n/app_localizations.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Consumer2<FireStoreProvider, LanguageProvider>(
      builder: (context, fireStore, lang, child) {
        var filteredPatientAppointments = fireStore.allAppointments
            .where((app) => app!.patient.id == fireStore.patient!.id)
            .toList();
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    localizations.appointmentSchedule,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Config.spaceSmall,
                  Expanded(
                    child: filteredPatientAppointments.isEmpty
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
                                  localizations.noAppointments,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.withAlpha(179),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  localizations.upcomingAppointments,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.withAlpha(128),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: filteredPatientAppointments.length,
                            itemBuilder: ((context, index) {
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
                                                filteredPatientAppointments[index]!
                                                    .doctor
                                                    .name,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                lang.getSpecialityLocalization(
                                                  filteredPatientAppointments[index]!
                                                      .doctor
                                                      .speciality,
                                                  localizations,
                                                ),
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
                                        date:
                                            filteredPatientAppointments[index]!
                                                .date,
                                        day: filteredPatientAppointments[index]!
                                            .day,
                                        time:
                                            filteredPatientAppointments[index]!
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
                                                fireStore.deleteAppointment(
                                                  filteredPatientAppointments[index]!
                                                      .id!,
                                                );
                                              },
                                              child: Text(
                                                localizations.cancel,
                                                style: const TextStyle(
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
                                                    patient: fireStore.patient!,
                                                    doctor:
                                                        filteredPatientAppointments[index]!
                                                            .doctor,
                                                    existingAppointment:
                                                        filteredPatientAppointments[index],
                                                    isReschedule: true,
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                localizations.reschedule,
                                                style: const TextStyle(
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
    final localizations = AppLocalizations.of(context)!;
    return Consumer<LanguageProvider>(
      builder: (context, lang, child) {
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
                '${lang.getDayLocalization(day, localizations)}, $date',
                style: const TextStyle(color: Config.primaryColor),
              ),
              const SizedBox(width: 20),
              const Icon(
                Icons.access_alarm,
                color: Config.primaryColor,
                size: 17,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  lang.getTimeLocalization(time, localizations),
                  style: const TextStyle(color: Config.primaryColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
