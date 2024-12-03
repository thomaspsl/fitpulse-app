import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  static final NotificationsService _instance = NotificationsService._internal();

  factory NotificationsService() {
    return _instance;
  }

  NotificationsService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Initialisation du service de notifications
  Future<void> init() async {
    // Initialisation des notifications locales
    await _initLocalNotifications();

    // Initialisation des listeners Firebase Messaging
    _initFirebaseListeners();

    // Récupérer et imprimer le token FCM
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token : $token');
  }

  /// Initialisation des notifications locales
  Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
    );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  /// Gestion des messages Firebase Messaging
  void _initFirebaseListeners() {
    // Messages reçus en premier plan
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message reçu : ${message.notification?.title}');
      _showNotification(
        title: message.notification?.title ?? 'Notification',
        body: message.notification?.body ?? '',
      );
    });

    // Messages ouverts depuis une notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification cliquée : ${message.notification?.title}');
      // Gérer la redirection ou les actions ici
    });

    // Messages en arrière-plan
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Gestion des messages en arrière-plan
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Message reçu en arrière-plan : ${message.notification?.title}');
  }

  Future<void> _onDidReceiveNotificationResponse(NotificationResponse response) async {
    final String? payload = response.payload;
    print('Notification sélectionnée : $payload');
    // Gérez la redirection ou d'autres actions ici
  }

  /// Affichage d'une notification locale
  Future<void> _showNotification({required String title, required String body}) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotificationsPlugin.show(
      0, // ID unique de la notification
      title,
      body,
      notificationDetails,
    );
  }

  /// Gestion des actions lors de la sélection d'une notification
  Future<void> _onSelectNotification(String? payload) async {
    print('Notification sélectionnée : $payload');
    // Redirection ou actions spécifiques ici
  }
}