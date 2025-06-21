import 'package:final_project/providers/firestore_provider.dart';

import 'package:final_project/utils/config.dart';

import 'package:final_project/views/widgets/appointment_card.dart';
import 'package:final_project/views/widgets/category_card.dart';
import 'package:final_project/views/widgets/doctor_card.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Consumer<FireStoreProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          //if user is empty, then return progress indicator
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
                                "Welcome ${provider.patient!.name}",
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
                          const Text(
                            'Appointment Today',
                            style: TextStyle(
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
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        'No Appointment Today',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          Config.spaceSmall,
                          const Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Config.spaceSmall,
                          SizedBox(
                            height: Config.heightSize * 0.05,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List<Widget>.generate(
                                provider.medCat.length,
                                (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      provider.updateCurrentDoctors(
                                        provider.medCat[index]["category"],
                                      );
                                    },
                                    child: CategoryCard(
                                      catName:
                                          provider.medCat[index]["category"],
                                      catIcon: provider.medCat[index]["icon"],
                                      currentCat: provider.currentCat,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Config.spaceSmall,

                          const Text(
                            'Top Doctors',
                            style: TextStyle(
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
                                ? [Text("no doctores")]
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
