import 'dart:developer';

import 'package:final_project/main_layout.dart';
import 'package:final_project/models/appointment.dart';
import 'package:final_project/utils/app_router.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  LocalNotification._();
  static LocalNotification localNotification = LocalNotification._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse response) {
    if (response.payload != null) {
      // Use a navigator key or other method to handle navigation
      AppRouter.navigateToWidgetWithReplacment(MainLayout());
    }
  }

  Future init() async {
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );

    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,
    );
  }

  void showScheduledNotification(TZDateTime appointmentTime) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "appointment_reminders",
        "Appointment Reminders",
        importance: Importance.max,
        priority: Priority.max,
        channelDescription: "Notifications for upcoming appointments",
      ),
    );

    // Calculate the reminder time (1 day before appointment)

    String formattedTime = DateFormat('h:mm a').format(appointmentTime);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      appointmentTime.millisecondsSinceEpoch ~/ 1000, // Using timestamp as ID
      "Appointment Reminder",
      "You have an appointment tomorrow at $formattedTime",
      appointmentTime,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  void getRightTime(AppointmentModel appointment) async {
    // Initialize timezone database
    tz.initializeTimeZones();
    // Set local location to Africa/Cairo
    final cairo = tz.getLocation('Africa/Cairo');
    tz.setLocalLocation(cairo);

    // Get current time in Cairo
    final now = tz.TZDateTime.now(cairo);
    // final tzTime = DateFormat('HH:mm a').format(now);

    final appointmentDateTime = DateFormat(
      'M/dd/yyyy HH:mm',
    ).parse("${appointment.date} ${appointment.time}");

    final appointmentReminder = appointmentDateTime.subtract(Duration(days: 1));
    final scheduledAppointmentTime = tz.TZDateTime.from(
      appointmentReminder,
      cairo,
    );

    if (scheduledAppointmentTime.subtract(Duration(days: 1)).day == now.day) {
      if (appointmentReminder.isAfter(now)) {
        showScheduledNotification(scheduledAppointmentTime);
      }
    }

    // final testTzDateTime = tz.TZDateTime.from(
    //   tz.TZDateTime.now(tz.local).add(Duration(days: 2)),
    //   cairo,
    // );
    // log(testTzDateTime.toString());
    // final reminder = testTzDateTime.subtract(Duration(days: 1));
    // log(reminder.toString());

    // log(reminder.subtract(Duration(days: 1)).toString());
    // log(now.toString());

    // if (reminder.subtract(Duration(days: 1)).day == now.day) {
    //   if (reminder.isAfter(now)) {
    //     log("inside if $reminder");
    //     showSchduledNotification(reminder);
    //     log(reminder.toString());
    //     log(now.toString());
    //   }
    // }
    final testTzDateTime = tz.TZDateTime.from(
      now.add(Duration(seconds: 40)),
      cairo,
    );

    final reminder = testTzDateTime.subtract(Duration(seconds: 30));

    if (reminder.isAfter(now)) {
      log("inside if $reminder");
      showScheduledNotification(reminder);
    }

    // log('Appointment as TZDateTime: $appointmentTzDateTime');

    // Compare dates

    // if (tzDate == "6/21/2025") {
    //   if ("19:19 PM" == tzTime) {
    //     log(tzDate);
    //     log(tzTime);

    //     // showSchduledNotification(appointmentTzDateTime);
    //     log('test timezone time : $testTzDateTime');
    //     log('current timezone time : ${tz.TZDateTime.now(tz.local)}');
    //     showSchduledNotification(testTzDateTime.add(Duration(seconds: 10)));
    //   }
    // }
    // if (tzDate == appointment.date) {
    //   if ("18:41 PM" == tzTime) {

    //     // showSchduledNotification(appointmentTzDateTime);
    //     log('test timezone time : $testTzDateTime');
    //     showSchduledNotification(testTzDateTime);
    //   }
    // }
  }
}
