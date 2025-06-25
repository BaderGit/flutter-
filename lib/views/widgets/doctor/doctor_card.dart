import 'package:final_project/l10n/app_localizations.dart';
import 'package:final_project/models/doctor.dart';
import 'package:final_project/providers/language_provider.dart';
import 'package:final_project/utils/app_router.dart';
import 'package:final_project/utils/config.dart';
import 'package:final_project/views/screens/doctor/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel? doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final localizations = AppLocalizations.of(context)!;
    return Consumer<LanguageProvider>(
      builder: (context, lang, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 150,
          child: GestureDetector(
            child: Card(
              elevation: 5,
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    width: Config.widthSize * 0.33,
                    child: Image.asset("assets/doctor_8.jpg", fit: BoxFit.fill),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            doctor!.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            lang.getSpecialityLocalization(
                              doctor!.speciality,
                              localizations,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //pass the details to detail page
            onTap: () {
              AppRouter.navigateToWidget(DoctorDetails(doctor: doctor));
            },
          ),
        );
      },
    );
  }
}
