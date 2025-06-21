import 'package:final_project/models/doctor.dart';
import 'package:final_project/utils/app_router.dart';
import 'package:final_project/utils/config.dart';
import 'package:final_project/views/screens/doctor/doctor_details.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel? doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
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
                        doctor!.speciality,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: const <Widget>[
                      //     Icon(
                      //       Icons.star_border,
                      //       color: Colors.yellow,
                      //       size: 16,
                      //     ),
                      //     Spacer(flex: 1),
                      //     Text('4.5'),
                      //     Spacer(flex: 1),
                      //     Text('Reviews'),
                      //     Spacer(flex: 1),
                      //     Text('(20)'),
                      //     Spacer(flex: 7),
                      //   ],
                      // ),
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
  }
}
