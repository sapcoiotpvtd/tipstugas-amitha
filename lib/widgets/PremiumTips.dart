import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipstugas/global.dart';
import 'package:tipstugas/widgets/Gudie.dart';
import 'package:tipstugas/widgets/utilities/BottomNavigationbar.dart';
import 'package:tipstugas/widgets/utilities/CustomAppbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

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
			body: Container
			(
				child: SingleChildScrollView
				(
					child: Column
					(
						crossAxisAlignment: CrossAxisAlignment.start,
						children:
						[
							telegramData != null ? Padding
							(
								padding: EdgeInsets.all(10),
								child: OutlinedButton
								(
									onPressed: ()
									{
										Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(telegramData["telegramBought"], "Telegram")));
									},
									style: ButtonStyle
									(
										backgroundColor: MaterialStateProperty.all(Colors.blue[400])
									),
									child: Text
									(
										'Telegram Channel',
										style: TextStyle(fontSize: 15, color: Colors.white),
									),
								)
							) : SizedBox.shrink(),
							Column
							(
								children: this.rows()
							)
						],
					)
				)
			),
			// bottomSheet: bottomNavigationBar(context),
		);
  	}

	Widget body()
	{
		return Container
		(
			padding: EdgeInsets.all(2),
			margin: EdgeInsets.only(top: 20, bottom: 100),
			child:ListView.builder
			(
				itemCount: premiumList.length,
				itemBuilder: (BuildContext context, int index)
				{
					return Card
					(
						child: ListTile
						(
							leading: Image.network(premiumList[index]["imgURL"]),
							title: Text
							(
								this.premiumList[index]["league"],
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
									Text
									(
										this.premiumList[index]["matchh"],
										style: GoogleFonts.ibmPlexSans
										(
											fontWeight: FontWeight.w500,
											fontSize: 14,
										),
									),
									Text
									(
										this.premiumList[index]["tip"],
										style: GoogleFonts.ibmPlexSans
										(
											fontSize: 12,
										),
									),
									Text
									(
										this.premiumList[index]["date"],
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
											SizedBox(height: 5),
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
									),
								],
							)
						)
					);
				}
			)
		);
	}

	List<Column> rows()
	{
		List <Column> rows = [];

		for(int index = 0; index < this.premiumList.length; index++)
		{
			rows.add
			(
				Column
				(
					children:
					[
						Card
						(
							elevation: 5,
							child: ListTile
							(
								leading: Image.network(premiumList[index]["imgURL"]),
								title: Text
								(
									this.premiumList[index]["league"],
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
										text: this.premiumList[index]["matchh"].toString(),
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
											this.premiumList[index]["tip"],
											style: GoogleFonts.ibmPlexSans
											(
												fontSize: 12,
											),
										),
										Text
										(
											this.premiumList[index]["date"],
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
												SizedBox(height: 5),
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
										),
									],
								)
							)
						)
					],
				)
			);
		}

		return rows;
	}

	_launchUrl(link) async
	{
  		var url = link.toString();

  		if (await canLaunch(url))
		{
    		await launch(url);
		}
		else
		{
    		throw 'Could not launch $url';
  		}
	}
}