import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/utils/config.dart';
import 'package:final_project/views/widgets/appointment/appointment_card.dart';
import 'package:final_project/views/widgets/category_card.dart';
import 'package:final_project/views/widgets/doctor/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:final_project/l10n/app_localizations.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final localizations = AppLocalizations.of(context)!;
    List<Map<String, dynamic>> medCat = [
      {
        "icon": FontAwesomeIcons.userDoctor,
        "category": AppLocalizations.of(context)!.general,
      },
      {
        "icon": FontAwesomeIcons.heartPulse,
        "category": AppLocalizations.of(context)!.cardiology,
      },
      {
        "icon": FontAwesomeIcons.lungs,
        "category": AppLocalizations.of(context)!.respirations,
      },
      {
        "icon": FontAwesomeIcons.hand,
        "category": AppLocalizations.of(context)!.dermatology,
      },
      {
        "icon": FontAwesomeIcons.personPregnant,
        "category": AppLocalizations.of(context)!.gynecology,
      },
      {
        "icon": FontAwesomeIcons.teeth,
        "category": AppLocalizations.of(context)!.dental,
      },
    ];

    return Consumer<FireStoreProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: provider.patient == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "${localizations.welcome} ${provider.patient!.name}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    provider.patient!.imgUrl,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Config.spaceSmall,
                          Text(
                            localizations.appointmentToday,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Config.spaceSmall,
                          provider.patienttodaysAppointments.isNotEmpty
                              ? AppointmentCard(
                                  doctor: provider
                                      .patienttodaysAppointments[0]!
                                      .doctor,
                                  appointment:
                                      provider.patienttodaysAppointments[0]!,
                                  color: Config.primaryColor,
                                )
                              : Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        localizations.noAppointmentToday,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          Config.spaceSmall,
                          Text(
                            localizations.category,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Config.spaceSmall,
                          SizedBox(
                            height: Config.heightSize * 0.05,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List<Widget>.generate(medCat.length, (
                                index,
                              ) {
                                return GestureDetector(
                                  onTap: () {
                                    provider.updateCurrentDoctors(
                                      medCat[index]["category"],
                                    );
                                  },
                                  child: CategoryCard(
                                    catName: medCat[index]["category"],
                                    catIcon: medCat[index]["icon"],
                                    currentCat: provider.currentCat,
                                  ),
                                );
                              }),
                            ),
                          ),
                          Config.spaceSmall,
                          Text(
                            localizations.topDoctors,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Config.spaceSmall,
                          Column(
                            children:
                                provider.filteredDoctors.isEmpty &&
                                    provider.currentCat == ""
                                ? List.generate(
                                    provider.allDoctors.length,
                                    (index) => DoctorCard(
                                      doctor: provider.allDoctors[index],
                                    ),
                                  )
                                : provider.filteredDoctors.isEmpty
                                ? [Text(localizations.noDoctorsAvailable)]
                                : List.generate(
                                    provider.filteredDoctors.length,
                                    (index) => DoctorCard(
                                      doctor: provider.filteredDoctors[index],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
