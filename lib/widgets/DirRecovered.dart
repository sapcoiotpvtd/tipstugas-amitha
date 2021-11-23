import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipstugas/global.dart';
import 'package:tipstugas/widgets/utilities/BottomNavigationbar.dart';
import 'package:tipstugas/widgets/utilities/CustomAppbar.dart';
import 'package:tipstugas/widgets/utilities/TextStyle.dart';

class DirRecovered extends StatefulWidget
{
	final list;
	DirRecovered(this.list);

	@override
	_DirRecoveredState createState() => _DirRecoveredState(this.list);
}

class _DirRecoveredState extends State<DirRecovered>
{
	final list;
	_DirRecoveredState(this.list);

	@override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			backgroundColor: Colors.white,
			appBar: appBar("Strategy Tips", context, false),
			body: body(),
			// bottomSheet: bottomNavigationBar(context),
		);
  	}

	Widget body()
	{
		return Container
		(
			margin: EdgeInsets.only(top: 10, bottom: 10),
			child: ListView.builder
			(
				padding: EdgeInsets.only(bottom: 25),
				itemCount: this.list.length,
				itemBuilder: (BuildContext context, int index)
				{
					return Container
					(
						margin: EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 25),
						decoration: BoxDecoration
						(
							color: Colors.white,
							borderRadius: BorderRadius.circular(10),
							boxShadow:
							[
								BoxShadow
								(
									color: Colors.grey.withOpacity(0.5),
									spreadRadius: 5,
									blurRadius: 10,
									offset: Offset(0, 2), // changes position of shadow
								)
							]
						),
						child: Column
						(
							crossAxisAlignment: CrossAxisAlignment.start,
							children:
							[
								Container
								(
									padding: EdgeInsets.all(5),
									decoration: BoxDecoration
									(
										color: Colors.blue,
										borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomRight: Radius.circular(5))
									),
									child: Text
									(
										this.list[index]["strategytitle"], 
										style: GoogleFonts.ibmPlexSans(color: Colors.white),
									),
								),
								Padding
								(
									padding: EdgeInsets.all(10),
									child: Text
									(
										this.list[index]["strategytext"],
										style: GoogleFonts.ibmPlexSans
										(
											fontSize: 12,
										)
									)
								),
								SizedBox(height: 10)
							]
						)
					);
				}
			)
		);
	}
}