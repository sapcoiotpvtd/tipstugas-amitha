import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tipstugas/widgets/Gudie.dart';
import 'package:tipstugas/widgets/Home.dart';
import 'package:tipstugas/widgets/RatingScreen.dart';
import 'package:tipstugas/widgets/utilities/PremiumTipsPopup.dart';

bottomNavigationBar(context)
{
	return Container
	(
		height: MediaQuery.of(context).size.height * 0.07,
		margin: EdgeInsets.only(bottom: 3, left: 10, right: 10),
		padding: EdgeInsets.only(left: 10, right: 10),
		decoration: BoxDecoration
		(
			color: Colors.white10,
			borderRadius: BorderRadius.circular(15),
			boxShadow:
			[
				BoxShadow
				(
					color: Colors.white.withOpacity(0.8),
					spreadRadius: 5,
					blurRadius: 10,
					offset: Offset(10, 2), // changes position of shadow
				)
			]
		),
		child: Row
		(
			mainAxisAlignment: MainAxisAlignment.spaceAround,
			children:
			[
				GestureDetector
				(
					child: Icon(Icons.home, color: Colors.grey),
					onTap: ()
					{
						Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
					},
				),
				GestureDetector
				(
					child: Icon(Icons.notifications, color: Colors.grey),
					// child: Image.asset("assets/icons/notification_icon.png", height: 25, width: 25,),
					onTap: ()
					{
						// premiumTips(context);
					},
				),
				GestureDetector
				(
					child: Icon(Icons.chat, color: Colors.grey),
					// child: Image.asset("assets/icons/chat_icon.png", height: 25, width: 25,),
					onTap: ()
					{
						// ratingVideosSheet(context);
					},
				),
				// GestureDetector
				// (
				// 	child: Icon(Icons.book_sharp, color: Colors.grey),
				// 	// height: 25, width: 25,),
				// 	onTap: ()
				// 	{
				// 		Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WebViewScreen()));
				// 	}
				// )
			],
		)
	);
}