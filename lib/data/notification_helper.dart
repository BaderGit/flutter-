// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// class NotificationService {
//   NotificationService._();
//   static  final NotificationService _notificationService = 
//       NotificationService._();

//   factory NotificationService() {
//     return _notificationService;
//   }

  

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
//       FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     // Initialize timezone database
//     tz.initializeTimeZones();
//     createNotificationChannel();

//     const AndroidInitializationSettings initializationSettingsAndroid = 
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//     );

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         // Handle notification tap here
//       },
//     );
//   }

//   Future<void> createNotificationChannel() async {
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description: 'This channel is used for important notifications.',
//     importance: Importance.max,
//   );

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
// }

// Future<void> showNotification({
//   required int id,
//   required String title,
//   required String body,
// }) async {
//   const AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails(
//     'high_importance_channel',
//     'High Importance Notifications',
//     channelDescription: 'This channel is used for important notifications.',
//     importance: Importance.max,
//     priority: Priority.high,
//     ticker: 'ticker',
//   );

//   const DarwinNotificationDetails iosNotificationDetails =
//       DarwinNotificationDetails(
//     presentAlert: true,
//     presentBadge: true,
//     presentSound: true,
//   );

//   const NotificationDetails notificationDetails = NotificationDetails(
//     android: androidNotificationDetails,
//     iOS: iosNotificationDetails,
//   );

//   await flutterLocalNotificationsPlugin.show(
//     id,
//     title,
//     body,
//     notificationDetails,
//   );
// }



// }