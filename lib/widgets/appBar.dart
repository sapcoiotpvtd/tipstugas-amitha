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
			title: Text(text),
			backgroundColor: Colors.transparent,
		);
	}

	@override
  	Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}