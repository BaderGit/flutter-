import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
                    'History',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Config.spaceSmall,
                  provider.allStoredAppointments.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 60,
                                  color: Colors.grey.withAlpha(128),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'No Appointments Found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.withAlpha(178),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Your appointment history will appear here',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.withAlpha(128),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: provider.allStoredAppointments.length,
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
                                                provider
                                                    .allStoredAppointments[index]!
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
                                                    .allStoredAppointments[index]!
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
                                            .allStoredAppointments[index]!
                                            .date,
                                        day: provider
                                            .allStoredAppointments[index]!
                                            .day,
                                        time: provider
                                            .allStoredAppointments[index]!
                                            .time,
                                      ),
                                      const SizedBox(height: 15),
                                      OutlinedButton(
                                        onPressed: () {
                                          provider.deleteStoredAppointment(
                                            provider
                                                .allStoredAppointments[index]!
                                                .id!,
                                          );
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Config.primaryColor,
                                          ),
                                        ),
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
