import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/models/appointment.dart';
import 'package:final_project/models/doctor.dart';
import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/providers/language_provider.dart';
import 'package:final_project/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentCard extends StatefulWidget {
  AppointmentCard({
    Key? key,
    required this.doctor,
    required this.color,
    required this.appointment,
  }) : super(key: key);

  final DoctorModel doctor;
  final AppointmentModel appointment;
  final Color color;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Consumer2<FireStoreProvider, LanguageProvider>(
      builder: (context, fireStore, lang, child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  //insert Row here
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/doctor_1.jpg"),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            localizations.doctorNameTitle(widget.doctor.name),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            lang.getSpecialityLocalization(
                              widget.doctor.speciality,
                              localizations,
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Config.spaceSmall,
                  //Schedule info here
                  ScheduleCard(appointment: widget.appointment),
                  Config.spaceSmall,
                  //action button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text(
                            localizations.cancel,
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            fireStore.deleteAppointment(widget.appointment.id!);
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            fireStore.deleteAppointment(widget.appointment.id!);
                          },
                          child: Text(
                            localizations.markCompleted,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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

//Schedule Widget
class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key, required this.appointment}) : super(key: key);
  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Consumer<LanguageProvider>(
      builder: (context, lang, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.calendar_today, color: Colors.white, size: 15),
              const SizedBox(width: 5),
              Text(
                '${lang.getDayLocalization(appointment.day, localizations)}, ${appointment.date}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 20),
              const Icon(Icons.access_alarm, color: Colors.white, size: 17),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  lang.getTimeLocalization(appointment.time, localizations),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
