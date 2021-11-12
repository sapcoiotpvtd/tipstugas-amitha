import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipstugas/widgets/utilities/BottomNavigationbar.dart';
import 'package:tipstugas/widgets/utilities/CustomAppbar.dart';

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
			bottomSheet: bottomNavigationBar(context),
		);
  	}

	Widget body()
	{
		print(this.list);
		return Container
		(
			margin: EdgeInsets.only(top: 20),
			child: ListView.builder
			(
				itemCount: 3,
				itemBuilder: (BuildContext context, int index)
				{
					return Stack
					(
						children:
						[
							Container
							(
								margin: EdgeInsets.only(top: 5, left: 25, right: 5, bottom: 15),
								height: 120,
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
								)
							),
							Positioned
							(
								top: 15,
								left: 70,
								child: Container
								(
									width: 250,
									margin: EdgeInsets.all(10),
									height: 100,
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
														this.list[index]["league"],
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
														this.list[index]["matchh"],
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
												this.list[index]["tip"],
												style: GoogleFonts.ibmPlexSans
												(
													fontSize: 12,
												),
											),
											Row
											(
												mainAxisAlignment: MainAxisAlignment.spaceBetween,
												children:
												[
													Text
													(
														this.list[index]["date"],
														style: GoogleFonts.ibmPlexSans
														(
															fontWeight: FontWeight.w500,
															fontSize: 14,
														),
													),
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
												]
											)
										]
									)
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
											margin: EdgeInsets.only(left: 10, bottom: 5),
											height: 70,
											width: 70,
											child: Image.network(this.list[index]["imgURL"],),
										),
										Text
										(
											this.list[index]["odd"],
											style: GoogleFonts.ibmPlexSans
											(
												fontSize: 14,
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