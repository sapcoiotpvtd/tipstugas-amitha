import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipstugas/widgets/utilities/BottomNavigationbar.dart';
import 'package:tipstugas/widgets/utilities/CustomAppbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeTipsScreen extends StatefulWidget
{
	final list;
	ResumeTipsScreen(this.list);

	@override
	_ResumeTipsScreenState createState() => _ResumeTipsScreenState(this.list);
}

class _ResumeTipsScreenState extends State<ResumeTipsScreen>
{
	final list;
	_ResumeTipsScreenState(this.list);

	@override
	Widget build(BuildContext context)
	{
		print(this.list);

		return Scaffold
		(
			backgroundColor: Colors.white,
			appBar: appBar("Resumo Tips", context, false),
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
				itemCount: list.length,
				itemBuilder: (BuildContext context, int index)
				{
					return Card
					(
						child: ListTile
						(
							leading: Image.network(list[index]["imgURL"]),
							title: Text
							(
								this.list[index]["league"],
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
									text: this.list[index]["matchh"].toString(),
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
										this.list[index]["tip"],
										style: GoogleFonts.ibmPlexSans
										(
											fontSize: 12,
										),
									),
									Text
									(
										this.list[index]["date"],
										style: GoogleFonts.ibmPlexSans
										(
											fontWeight: FontWeight.w500,
											fontSize: 14,
										),
									),
									SizedBox(height: 5),
									Row
									(
										crossAxisAlignment: CrossAxisAlignment.start,
										children:
										[
											this.list[index]["paid"] == "" ? SizedBox.shrink() : Container
											(
												padding: EdgeInsets.all(5),
												decoration: BoxDecoration
												(
													borderRadius: BorderRadius.circular(15),
													color: Color(int.parse("0xff07AFFB"))
												),
												child: Text
												(
													this.list[index]["paid"],
													style: GoogleFonts.ibmPlexSans
													(
														fontWeight: FontWeight.w500,
														color: Colors.white,
														fontSize: 12,
													),
												),
											),
											SizedBox(width: 5),
											this.list[index]["status"] == "" ? SizedBox.shrink() : Container
											(
												padding: EdgeInsets.all(5),
												decoration: BoxDecoration
												(
													borderRadius: BorderRadius.circular(15),
													color: Colors.green
												),
												child: Text
												(
													this.list[index]["status"],
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

	// Widget body()
	// {
	// 	return Container
	// 	(
	// 		padding: EdgeInsets.all(2),
	// 		margin: EdgeInsets.only(top: 20, bottom: 10),
	// 		child: ListView.builder
	// 		(
	// 			itemCount: list.length,
	// 			itemBuilder: (BuildContext context, int index)
	// 			{
	// 				return Stack
	// 				(
	// 					children:
	// 					[
	// 						Container
	// 						(
	// 							margin: EdgeInsets.only(top: 5, left: 25, right: 5, bottom: 15),
	// 							// height: 220,
	// 							padding: EdgeInsets.all(25),
	// 							decoration: BoxDecoration
	// 							(
	// 								color: Colors.white,
	// 								borderRadius: BorderRadius.circular(10),
	// 								boxShadow:
	// 								[
	// 									BoxShadow
	// 									(
	// 										color: Colors.grey.withOpacity(0.5),
	// 										spreadRadius: 5,
	// 										blurRadius: 10,
	// 										offset: Offset(0, 2), // changes position of shadow
	// 									)
	// 								]
	// 							),
	// 						// 	child:
	// 						// ),
	// 						// Positioned
	// 						// (
	// 						// 	top: 15,
	// 						// 	left: 70,
	// 							child: Container
	// 							(
	// 								// width: 250,
	// 								// margin: EdgeInsets.all(10),
	// 								padding: EdgeInsets.only(left: 50),
	// 								// height: 100,
	// 								color: Colors.white,
	// 								child: Column
	// 								(
	// 									crossAxisAlignment: CrossAxisAlignment.start,
	// 									children:
	// 									[
	// 										Wrap
	// 										(
	// 											children:
	// 											[
	// 												Text
	// 												(
	// 													this.list[index]["league"],
	// 													style: GoogleFonts.ibmPlexSans
	// 													(
	// 														fontSize: 14,
	// 													),
	// 												)
	// 											],
	// 										),
	// 										Wrap
	// 										(
	// 											children:
	// 											[
	// 												Text
	// 												(
	// 													this.list[index]["matchh"],
	// 													style: GoogleFonts.ibmPlexSans
	// 													(
	// 														fontWeight: FontWeight.w500,
	// 														fontSize: 14,
	// 													),
	// 												)
	// 											],
	// 										),
	// 										Text
	// 										(
	// 											this.list[index]["tip"],
	// 											style: GoogleFonts.ibmPlexSans
	// 											(
	// 												fontSize: 12,
	// 											),
	// 										),
	// 										Row
	// 										(
	// 											mainAxisAlignment: MainAxisAlignment.start,
	// 											children:
	// 											[
	// 												Text
	// 												(
	// 													this.list[index]["date"],
	// 													style: GoogleFonts.ibmPlexSans
	// 													(
	// 														fontWeight: FontWeight.w500,
	// 														fontSize: 14,
	// 													),
	// 												),
	// 												SizedBox(width: 5),
	// 											]
	// 										),
	// 										SizedBox(height: 25)
	// 									]
	// 								)
	// 							)
	// 						),
	// 						Positioned
	// 						(
	// 							bottom: 35,
	// 							left: 90,
	// 							child: Row
	// 							(
	// 								children: 
	// 								[
	// 									this.list[index]["paid"] == "" ? SizedBox.shrink() : Container
	// 									(
	// 										padding: EdgeInsets.all(5),
	// 										decoration: BoxDecoration
	// 										(
	// 											borderRadius: BorderRadius.circular(15),
	// 											color: Color(int.parse("0xff07AFFB"))
	// 										),
	// 										child: Text
	// 										(
	// 											this.list[index]["paid"],
	// 											style: GoogleFonts.ibmPlexSans
	// 											(
	// 												fontWeight: FontWeight.w500,
	// 												color: Colors.white,
	// 												fontSize: 12,
	// 											),
	// 										),
	// 									),
	// 									SizedBox(width: 5),
	// 									this.list[index]["status"] == "" ? SizedBox.shrink() : Container
	// 									(
	// 										padding: EdgeInsets.all(5),
	// 										decoration: BoxDecoration
	// 										(
	// 											borderRadius: BorderRadius.circular(15),
	// 											color: Colors.green
	// 										),
	// 										child: Text
	// 										(
	// 											this.list[index]["status"],
	// 											style: GoogleFonts.ibmPlexSans
	// 											(
	// 												fontWeight: FontWeight.w500,
	// 												color: Colors.white,
	// 												fontSize: 12,
	// 											),
	// 										),
	// 									)
	// 								],
	// 							)
	// 						),
	// 						Positioned
	// 						(
	// 							child: Column
	// 							(
	// 								children:
	// 								[
	// 									Container
	// 									(
	// 										margin: EdgeInsets.only(left: 5, bottom: 5),
	// 										height: 70,
	// 										width: 70,
	// 										child: Image.network(this.list[index]["imgURL"])
	// 									),
	// 									Container
	// 									(
	// 										margin: EdgeInsets.only(left: 25, bottom: 5),
	// 										height: 70,
	// 										width: 70,
	// 									child: Flexible
	// 									(
	// 										child: 
	// 										// [
	// 											Text
	// 											(
	// 												this.list[index]["odd"],
	// 												style: GoogleFonts.ibmPlexSans
	// 												(
	// 													fontSize: 14,
	// 												)
	// 											)
	// 										// ],
	// 									)
	// 									)
	// 								]
	// 							)
	// 						)
	// 					]
	// 				);
	// 			}
	// 		)
	// 	);
	// }
}