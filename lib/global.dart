import 'package:flutter/cupertino.dart';

var height;
var width;
var telegramData;

getHeight(context)
{
	height = MediaQuery.of(context).size.height;

	return height;
}

getWidth(context)
{
	width = MediaQuery.of(context).size.width;

	return width;
}