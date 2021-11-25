import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipstugas/widgets/utilities/BottomNavigationbar.dart';
import 'package:tipstugas/widgets/utilities/CustomAppbar.dart';
import 'package:url_launcher/url_launcher.dart';

class FreeTips extends StatefulWidget
{
	final freeList;
	FreeTips(this.freeList);

	@override
	_FreeTipsState createState() => _FreeTipsState(this.freeList);
}

class _FreeTipsState extends State<FreeTips>
{
	final freeList;
	_FreeTipsState(this.freeList);

	@override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			backgroundColor: Colors.white,
			appBar: appBar("Free Tips", context, false),
			body: body(),
			// bottomSheet: bottomNavigationBar(context),
		);
  	}

	Widget body()
	{
		return Container
		(
			padding: EdgeInsets.all(2),
			margin: EdgeInsets.only(top: 20, bottom: 50),
			child: ListView.builder
			(
				itemCount: freeList.length,
				itemBuilder: (BuildContext context, int index)
				{
					return Card
					(
						child: ListTile
						(
							leading: Image.network(freeList[index]["imgURL"]),
							title: Text
							(
								this.freeList[index]["league"],
								style: GoogleFonts.ibmPlexSans
								(
									fontSize: 14,
								),
							),
							subtitle: Column
							(
								crossAxisAlignment: CrossAxisAlignment.start,
								children:
								[
									Linkify
									(
										onOpen: (link) async 
										{
											if (await canLaunch(link.url)) {
											await launch(link.url);
										} else {
											throw 'Could not launch $link';
										}
									},
									text: this.freeList[index]["matchh"].toString(),
									style: GoogleFonts.ibmPlexSans
									(
										color: Colors.grey,
										fontWeight: FontWeight.w500,
										fontSize: 14,
									)
									// linkStyle: TextStyle(color: Colors.red),
									),
									Text
									(
										this.freeList[index]["tip"],
										style: GoogleFonts.ibmPlexSans
										(
											fontSize: 12,
										),
									),
									Text
									(
										this.freeList[index]["date"],
										style: GoogleFonts.ibmPlexSans
										(
											fontWeight: FontWeight.w500,
											fontSize: 14,
										),
									),
									Column
									(
										crossAxisAlignment: CrossAxisAlignment.start,
										children:
										[
											this.freeList[index]["paid"] == "" ? SizedBox.shrink() : Container
											(
												padding: EdgeInsets.all(5),
												decoration: BoxDecoration
												(
													borderRadius: BorderRadius.circular(15),
													color: Color(int.parse("0xff07AFFB"))
												),
												child: Text
												(
													this.freeList[index]["paid"],
													style: GoogleFonts.ibmPlexSans
													(
														fontWeight: FontWeight.w500,
														color: Colors.white,
														fontSize: 12,
													),
												),
											),
											SizedBox(height: 5),
											this.freeList[index]["status"] == "" ? SizedBox.shrink() : Container
											(
												padding: EdgeInsets.all(5),
												decoration: BoxDecoration
												(
													borderRadius: BorderRadius.circular(15),
													color: Colors.green
												),
												child: Text
												(
													this.freeList[index]["status"],
													style: GoogleFonts.ibmPlexSans
													(
														fontWeight: FontWeight.w500,
														color: Colors.white,
														fontSize: 12,
													),
												),
											)
										],
									),
								],
							)
						)
					);
				}
			)
		);
	}
}