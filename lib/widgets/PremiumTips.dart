import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipstugas/widgets/utilities/BottomNavigationbar.dart';
import 'package:tipstugas/widgets/utilities/CustomAppbar.dart';

class PremiumTips extends StatefulWidget
{
	final premiumList;
	PremiumTips(this.premiumList);

	@override
	_PremiumTipsState createState() => _PremiumTipsState(this.premiumList);
}

class _PremiumTipsState extends State<PremiumTips>
{
	final premiumList;
	_PremiumTipsState(this.premiumList);

	@override
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			backgroundColor: Colors.white,
			appBar: appBar("Premium Tips", context, false),
			body: body(),
			bottomSheet: bottomNavigationBar(context),
		);
  	}

	Widget body()
	{
		return Container
		(
			padding: EdgeInsets.all(2),
			margin: EdgeInsets.only(top: 20, bottom: 10),
			child: ListView.builder
			(
				itemCount: premiumList.length,
				itemBuilder: (BuildContext context, int index)
				{
					return Stack
					(
						children:
						[
							Container
							(
								margin: EdgeInsets.only(top: 5, left: 25, right: 5, bottom: 15),
								// height: 220,
								padding: EdgeInsets.all(25),
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
							// 	child:
							// ),
							// Positioned
							// (
							// 	top: 15,
							// 	left: 70,
								child: Container
								(
									// width: 250,
									// margin: EdgeInsets.all(10),
									padding: EdgeInsets.only(left: 50),
									// height: 100,
									color: Colors.white,
									child: Column
									(
										crossAxisAlignment: CrossAxisAlignment.start,
										children:
										[
											Wrap
											(
												children:
												[
													Text
													(
														this.premiumList[index]["league"],
														style: GoogleFonts.ibmPlexSans
														(
															fontSize: 14,
														),
													)
												],
											),
											Wrap
											(
												children:
												[
													Text
													(
														this.premiumList[index]["matchh"],
														style: GoogleFonts.ibmPlexSans
														(
															fontWeight: FontWeight.w500,
															fontSize: 14,
														),
													)
												],
											),
											Text
											(
												this.premiumList[index]["tip"],
												style: GoogleFonts.ibmPlexSans
												(
													fontSize: 12,
												),
											),
											Row
											(
												mainAxisAlignment: MainAxisAlignment.start,
												children:
												[
													Text
													(
														this.premiumList[index]["date"],
														style: GoogleFonts.ibmPlexSans
														(
															fontWeight: FontWeight.w500,
															fontSize: 14,
														),
													),
													SizedBox(width: 5),
												]
											),
											SizedBox(height: 25)
										]
									)
								)
							),
							Positioned
							(
								bottom: 45,
								left: 40,
								child: Row
								(
									children: 
									[
										this.premiumList[index]["paid"] == "" ? SizedBox.shrink() : Container
										(
											padding: EdgeInsets.all(5),
											decoration: BoxDecoration
											(
												borderRadius: BorderRadius.circular(15),
												color: Color(int.parse("0xff07AFFB"))
											),
											child: Text
											(
												this.premiumList[index]["paid"],
												style: GoogleFonts.ibmPlexSans
												(
													fontWeight: FontWeight.w500,
													color: Colors.white,
													fontSize: 12,
												),
											),
										),
										SizedBox(width: 5),
										this.premiumList[index]["status"] == "" ? SizedBox.shrink() : Container
										(
											padding: EdgeInsets.all(5),
											decoration: BoxDecoration
											(
												borderRadius: BorderRadius.circular(15),
												color: Colors.green
											),
											child: Text
											(
												this.premiumList[index]["status"],
												style: GoogleFonts.ibmPlexSans
												(
													fontWeight: FontWeight.w500,
													color: Colors.white,
													fontSize: 12,
												),
											),
										)
									],
								)
							),
							Positioned
							(
								child: Column
								(
									children:
									[
										Container
										(
											margin: EdgeInsets.only(left: 5, bottom: 5),
											height: 70,
											width: 70,
											child: Image.network(this.premiumList[index]["imgURL"])
										),
										Container
										(
											margin: EdgeInsets.only(left: 25, bottom: 5),
											height: 70,
											width: 70,
										child: Flexible
										(
											child: 
											// [
												Text
												(
													this.premiumList[index]["odd"],
													style: GoogleFonts.ibmPlexSans
													(
														fontSize: 14,
													)
												)
											// ],
										)
										)
									]
								)
							)
						]
					);
				}
			)
		);
	}
}