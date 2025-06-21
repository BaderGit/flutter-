import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/firestore_provider.dart';
import 'package:final_project/views/screens/appointment/appointment_page.dart';
import 'package:final_project/views/screens/doctor/doctor_profile_page.dart';
import 'package:final_project/views/screens/doctor/doctor_home_page.dart';
import 'package:final_project/views/screens/patient/history_page.dart';

import 'package:final_project/views/screens/patient/patient_home_page.dart';
import 'package:final_project/views/screens/patient/patient_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final fireStore = Provider.of<FireStoreProvider>(context, listen: false);
      final auth = Provider.of<AppAuthProvider>(context, listen: false);
      if (auth.userType == "patient") {
        fireStore.getPatient();
        fireStore.getAllAppointments();
        fireStore.getAllDoctors();
      } else {
        fireStore.getDoctor();
      }
    });
  }

  //variable declaration
  int currentPage = 0;
  final PageController _page = PageController();
  @override
  Widget build(BuildContext context) {
    return Consumer2<AppAuthProvider, FireStoreProvider>(
      builder: (context, auth, fireStore, child) {
        return Scaffold(
          body: PageView(
            controller: _page,
            onPageChanged: ((value) {
              setState(() {
                currentPage = value;
              });
            }),
            children: <Widget>[
              if (auth.userType == "patient") ...[
                PatientHomePage(),
                HistoryPage(),
                AppointmentPage(),
                PatientProfilePage(),
              ],

              DoctorHomePage(),
              DoctorProfilePage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage,
            onTap: (page) {
              setState(() {
                currentPage = page;
                _page.animateToPage(
                  page,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              });
            },
            items: <BottomNavigationBarItem>[
              if (auth.userType == "patient") ...[
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.houseChimneyMedical),
                  label: 'Home',
                ),

                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.clockRotateLeft),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidCalendarCheck),
                  label: 'Appointments',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidUser),
                  label: 'Profile',
                ),
              ],
              if (auth.userType == "doctor") ...[
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.houseChimneyMedical),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidUser),
                  label: 'Profile',
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
