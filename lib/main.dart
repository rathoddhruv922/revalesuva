import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:media_kit/media_kit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:revalesuva/firebase_options.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/audio_player_handler.dart';
import 'package:revalesuva/utils/local_cart_helper.dart';
import 'package:revalesuva/utils/local_lessons_video_helper.dart';
import 'package:revalesuva/utils/local_shopping_helper.dart';
import 'package:revalesuva/utils/local_storage.dart';
import 'package:revalesuva/utils/localization.dart';
import 'package:revalesuva/utils/notification_helper.dart';
import 'package:revalesuva/utils/router.dart';
import 'package:revalesuva/view_models/all_view_model_binding.dart';
import 'package:revalesuva/view_models/theme_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.testMode = true;

  MediaKit.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalStorage.instance.init();
  await Hive.initFlutter();
  await LocalShoppingHelper.instance.init();
  await LocalCartHelper.instance.init();
  await LocalLessonsVideoHelper.instance.init();
  await AudioPlayerHandler.instance.init();

  fcmSettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeViewModel themeViewModel = Get.put(ThemeViewModel(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(
            1.0,
          ),
        ),
        child: ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return GetMaterialApp(
              color: AppColors.surfaceGreenLight,
              initialBinding: AllViewModelBinding(),
              title: 'Revalesuva',
              translations: Localization(),
              locale: const Locale('he', 'IL'),
              // locale: const Locale('en', 'US'),
              fallbackLocale: const Locale('en', 'US'),
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('he', 'IL'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: themeViewModel.getTheme(),
              themeMode: themeViewModel.themeMode.value,
              debugShowCheckedModeBanner: false,
              defaultTransition: Transition.fade,
              initialRoute: RoutesName.splash,
              getPages: getPageRoute(),
              transitionDuration: const Duration(milliseconds: 500),
            );
          },
        ),
      ),
    );
  }
}

fcmSettings() async {
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    try {
      if (Platform.isIOS || Platform.isAndroid) {
        PermissionStatus status = await Permission.notification.status;
        if (!status.isGranted) {
          status = await Permission.notification.request();
        }
        await HelperNotification.initialize();
       // debugPrint("FCM Token : ${await HelperNotification.getFcmToken()}");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
