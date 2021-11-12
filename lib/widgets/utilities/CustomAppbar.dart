import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipstugas/widgets/utilities/global.dart';

appBar(string, context, isHome)
{
	print(appBarBackgroundImage);

	return AppBar
	(
		title: Text
		(
			string == null ? "" : string,
			style: GoogleFonts.ibmPlexSans
			(
				fontWeight: FontWeight.w500,
				color: Colors.white
			)
		),
		flexibleSpace: FancyShimmerImage
		(
			height: 100,
			imageUrl: appBarBackgroundImage == null ? "https://images.pexels.com/photos/242236/pexels-photo-242236.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500" : appBarBackgroundImage.toString(),
			shimmerBaseColor: Colors.grey[200],
			shimmerBackColor: Colors.grey,
			boxFit: BoxFit.cover,
		),
		leading: isHome ? null : IconButton
		(
			icon: Icon(Icons.arrow_back_ios_new), 
			color: Colors.white,
			onPressed: ()
			{
				Navigator.pop(context);
			},
		),
		actions: isHome ? null :
		[
			IconButton
			(
				onPressed: null,
				icon: Icon(Icons.menu, color: Colors.white, size: 35)
			)
		],
		// flexibleSpace: Image
		// (
		// 	image: NetworkImage(appBarBackgroundImage),
		// 	fit: BoxFit.cover,
		// 	height: 100,
		// ),
		backgroundColor: Colors.transparent,
	);
}