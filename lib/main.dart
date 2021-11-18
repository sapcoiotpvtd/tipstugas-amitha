// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tipstugas/widgets/Home.dart';
import 'package:tipstugas/widgets/SplashScreen.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

void main() async
{
	WidgetsFlutterBinding.ensureInitialized();
	FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
	SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

	if(defaultTargetPlatform == TargetPlatform.android)
	{
		InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
	}

	runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
	// If you're going to use other Firebase services in the background, such as Firestore,
	// make sure you call `initializeApp` before using other Firebase services.
	await Firebase.initializeApp();

	print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget
{
	Widget build(BuildContext context)
	{
		SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

		return MaterialApp
		(
      		debugShowCheckedModeBanner: false,
      		title: 'Tipstugas',
      		themeMode: ThemeMode.light,
      		theme: ThemeData
			(
				accentColor: Color(int.parse("0xff40555f")),
        		primaryColor: Color(int.parse("0xffe4f1fa")),
      		),
      		home: SplashScreen(),
      		// home: HomeScreen(),
		);
	}
}


