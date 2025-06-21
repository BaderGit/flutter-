import 'package:final_project/models/doctor.dart';
import 'package:final_project/models/patient.dart';
import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/utils/app_router.dart';
import 'package:final_project/utils/config.dart';

import 'package:final_project/views/screens/appointment/booking_page.dart';

import 'package:final_project/views/widgets/button.dart';
import 'package:final_project/views/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key, required this.doctor});
  final DoctorModel? doctor;

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  late DoctorModel doctor;
  late PatientModel patient;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<FireStoreProvider>(context, listen: false);
      provider.getPatient();
      patient = provider.patient!;
    });
    doctor = widget.doctor!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Doctor Details',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AboutDoctor(doctor: doctor),
            DetailBody(doctor: doctor),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Button(
                width: double.infinity,
                title: 'Book Appointment',
                onPressed: () {
                  AppRouter.navigateToWidget(
                    BookingPage(doctor: doctor, patient: patient),
                  );
                },
                disable: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutDoctor extends StatelessWidget {
  const AboutDoctor({Key? key, required this.doctor}) : super(key: key);

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 65.0,
            backgroundImage: AssetImage("assets/doctor_1.jpg"),
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          Text(
            "Dr ${doctor.name}",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'MBBS (International Medical University, Malaysia), MRCP (Royal College of Physicians, United Kingdom)',
              style: TextStyle(color: Colors.grey, fontSize: 15),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'Sarawak General Hospital',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({Key? key, required this.doctor}) : super(key: key);
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Config.spaceSmall,
          DoctorInfo(patients: 15, exp: 4),
          Config.spaceMedium,
          const Text(
            'About Doctor',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Config.spaceSmall,
          Text(
            'Dr. ${doctor.name} is an experience ${doctor.speciality} Specialist at Sarawak, graduated since 2008, and completed his/her training at Sungai Buloh General Hospital.',
            style: const TextStyle(fontWeight: FontWeight.w500, height: 1.5),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({Key? key, required this.patients, required this.exp})
    : super(key: key);

  final int patients;
  final int exp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InfoCard(label: 'Patients', value: '$patients'),
        const SizedBox(width: 15),
        InfoCard(label: 'Experiences', value: '$exp years'),
        const SizedBox(width: 15),
        const InfoCard(label: 'Rating', value: '4.6'),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.label, required this.value})
    : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Config.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
