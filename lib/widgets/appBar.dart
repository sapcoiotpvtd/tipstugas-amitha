import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget
{
	final image;
	final text;
	final AppBar appBar;
	CustomAppBar(this.image, this.text, this.appBar);

	Widget build(BuildContext context)
	{
		return AppBar
		(
			leading: null,
			// flexibleSpace: FancyShimmerImage
			// (
			// 	height: 100,
			// 	imageUrl: image == null ? "https://images.pexels.com/photos/242236/pexels-photo-242236.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500" : image["homebanner"].toString(),
			// 	shimmerBaseColor: Colors.grey[200],
			// 	shimmerBackColor: Colors.grey,
			// 	boxFit: BoxFit.cover,
			// ),
			title: Text(text),
			//  Image
			// (
			// 	image: NetworkImage(appBarImage),
			// 	fit: BoxFit.cover,
			// 	height: 100,
			// ),
			backgroundColor: Colors.transparent,
		);
	}

	@override
  	Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}