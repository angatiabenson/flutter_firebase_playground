import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_playground/binding/general_bindings.dart';
import 'package:flutter_firebase_playground/presentation/theme/theme.dart';
import 'package:flutter_firebase_playground/presentation/theme/util.dart';
import 'package:flutter_firebase_playground/presentation/ui/controllers/notification_controller.dart';
import 'package:get/get.dart';

import 'data/crypto_api.dart';
import 'domain/repo/crypto_repository.dart';
import 'presentation/ui/crypto_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Get.put(NotificationController());
  Get.put(CryptoRepository(CryptoApi()));
  runApp(const MyApp());
}

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Handling a background message: ${message.messageId}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // Access NotificationController to set up listeners
    final NotificationController notificationController =
    Get.find<NotificationController>();

    // Initialize notification listeners
    notificationController.listenForegroundMessages();
    notificationController.listenTokenRefresh();

    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Space Mono", "Space Mono");

    MaterialTheme theme = MaterialTheme(textTheme);
    return GetMaterialApp(
      title: 'Flutter Firebase Playground',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const CryptoPage(),
      initialBinding: GeneralBindings(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
    );
  }
}
