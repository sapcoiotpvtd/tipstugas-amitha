import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rate_my_app/rate_my_app.dart';

final InAppReview inAppReview = InAppReview.instance;


ratingVideosSheet(context)
{
	RateMyApp rateMyApp = RateMyApp
	(
		preferencesPrefix: 'rateMyApp_',
		minDays: 7,
		minLaunches: 10,
		remindDays: 7,
		remindLaunches: 10,
		googlePlayIdentifier: 'com.tips.tugas.pt',
		appStoreIdentifier: '1491556149',
	);

	rateMyApp.showStarRateDialog
	(
		context,
		title: "TIPSTUGAS",
		message: 'Classifica a tua experiencia connosco?',
      	actionsBuilder: (context, stars)
		{
        	return
			[
          		TextButton
				(
            		child: Text('OK'),
            		onPressed: () async
					{
              			print('Thanks for the ' + (stars == null ? '0' : stars.round().toString()) + ' star(s) !');

						var x = inAppReview.requestReview();

						print(x);
						Navigator.pop(context);
            		},
          		),
        	];
    	},
      	ignoreNativeDialog: Platform.isAndroid,
      	dialogStyle: const DialogStyle
		(
			titleAlign: TextAlign.center,
			messageAlign: TextAlign.center,
			messagePadding: EdgeInsets.only(bottom: 20),
      	),
      	starRatingOptions: const StarRatingOptions(),
      	onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
    );
}
