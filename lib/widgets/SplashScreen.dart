// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tipstugas/widgets/Home.dart';
import 'package:tipstugas/widgets/utilities/TextStyle.dart';

class SplashScreen extends StatefulWidget 
{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{
	// late FirebaseMessaging _firebaseMessaging;
	String messageTitle = "Empty";
	String notificationAlert = "alert";
	String messageDescription = "";


	@override 
	void initState()
	{
		super.initState();
		
	}

	Widget build(BuildContext context)
	{

		Future.delayed(Duration(seconds: 3), () 
		{
  			Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
		});

		return Scaffold
		(
			body: Stack
			(
				children: 
				[
					Container
					(
						height: double.infinity,
						child: Image.asset("assets/images/Splash_Screen_img.jpg", fit: BoxFit.fill)
					),
					Align
					(
						alignment: Alignment.bottomCenter,
						child: Padding
						(
							padding: EdgeInsets.only(bottom: 100),
							child: Image.asset("assets/images/Logo_glow.png", fit: BoxFit.contain, width: 250)
						),
					),
					Align
					(
						alignment: Alignment.bottomCenter,
						child: Padding
						(
							padding: EdgeInsets.only(bottom: 20),
							child: Text
							(
								"Designed and Developed by Sapco IOT Pvt. Ltd",
								style: textStyle(),
							)
						),
					), 	
				],
			)
		);
	}

	firebaseInitialize()
	{
		print("Firebase initialized");

		FirebaseMessaging messaging = FirebaseMessaging.instance;

		// firebaseMessaging.configure
		// (
		// 	onMessage: (Map<String, dynamic> message) async
		// 	{
		// 		print("onMessage: $message");
		// 	},
		// 	onLaunch: (Map<String, dynamic> message) async // Called when app is terminated
		// 	{
		// 		print("onLaunch: $message");

		// 		var data = message["data"];

		// 		print(data);
		// 	},
		// 	onResume: (Map<String, dynamic> message) async
		// 	{
		// 		print("onResume: $message");


		// 		var data = message["data"];
		// 	}
		// );

		// firebaseMessaging.subscribeToTopic("news");
	}
}