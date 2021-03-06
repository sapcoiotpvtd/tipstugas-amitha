
import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tipstugas/Server.dart';
import 'package:tipstugas/global.dart';
import 'package:tipstugas/widgets/DirRecovered.dart';
import 'package:tipstugas/widgets/FreeTips.dart';
import 'package:tipstugas/widgets/Gudie.dart';
import 'package:tipstugas/widgets/PremiumTips.dart';
import 'package:tipstugas/widgets/RatingScreen.dart';
import 'package:tipstugas/widgets/ResumoTips.dart';
import 'package:tipstugas/widgets/appBar.dart';
import 'package:tipstugas/widgets/utilities/BottomNavigationbar.dart';
import 'package:tipstugas/widgets/utilities/CustomAppbar.dart';
import 'package:tipstugas/widgets/utilities/global.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum Availability { LOADING, AVAILABLE, UNAVAILABLE }

enum BestTutorSite { monthly, threemonths}

class HomeScreen extends StatefulWidget
{
	@override
	_HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
	List premiumList = [];
	List freeList = [];
	List strategyList = [];
	List resumoList = [];
	List socialMediaList = [];
	List carouselList = [];

	int index = 0;
  	int val = 0;

	bool isLoading = true;

	var bannerImage;
	var appBarImage;

  	String _platformVersion = 'Unknown';

	late StreamSubscription _purchaseUpdatedSubscription;
	late StreamSubscription _purchaseErrorSubscription;
	late StreamSubscription _conectionSubscription;

	final InAppReview inAppReview = InAppReview.instance;
	final InAppPurchase _inAppPurchase = InAppPurchase.instance;

	final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

	late StreamSubscription<List<PurchaseDetails>> _subscription;

	 List<IAPItem> items = [];

	final List<String> _productLists =  ['threemonths','monthly',];

	List<ProductDetails> products = [];
	List<PurchasedItem> _purchases = [];

	FirebaseMessaging? _firebaseMessaging;

	var _site;

	@override
	void initState()
	{
    	super.initState();
		initPlatformState();
		loadData();

  	}

	loadData() async
	{
		// await Firebase.initializeApp();

		// var x =  await _firebaseMessaging!.onTokenRefresh;

		// print(x);
		// _firebaseMessaging!.getToken().then((value) => print(value));

		getImages();
		getPremiumTips();
		getFreeTips();
		getStrategyTips();
		getResumoTips();
		await getItems();
		await _getPurchaseHistory();
	}

	Future<void> getItems() async
	{
		const Set<String> _kIds = <String>{'monthly', 'threemonths'};

		final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(_kIds);
		if (response.notFoundIDs.isNotEmpty) 
		{
			// Handle the error.
		}
		products = response.productDetails;
	}

	@override
	void dispose()
	{
		super.dispose();
	}

	Future<void> initPlatformState() async
	{
    	var platformVersion;
    	// Platform messages may fail, so we use a try/catch PlatformException.
    	try
		{
      		platformVersion = await FlutterInappPurchase.instance.platformVersion;
    	}
		on PlatformException
		{
      		platformVersion = 'Failed to get platform version.';
    	}

		// prepare
		var result = await FlutterInappPurchase.instance.initConnection;
		print('result: $result');

    	items = await FlutterInappPurchase.instance.getSubscriptions(_productLists);

		// If the widget was removed from the tree while the asynchronous platform
		// message was in flight, we want to discard the reply rather than calling
		// setState to update our non-existent appearance.
		if (!mounted) return;

		setState(()
		{
			_platformVersion = platformVersion;
		});

		// refresh items for android
		try
		{
			String msg = await FlutterInappPurchase.instance.consumeAllItems;
			print('consumeAllItems: $msg');
		}
		catch (err)
		{
			print('consumeAllItems error: $err');
		}

		_conectionSubscription = FlutterInappPurchase.connectionUpdated.listen((connected)
		{
			print('connected: $connected');
		});

		_purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen((productItem)
		{
			print('purchase-updated: $productItem');
		});

		_purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen((purchaseError)
		{
			print('purchase-error: $purchaseError');
		});
	}

	void _requestPurchase(item) async
	{

		try
		{
			final PurchaseParam purchaseParam = PurchaseParam(productDetails: products[item]);
			InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam).whenComplete(()
			{
				_scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text("Sucess")));
			} );

			// From here the purchase flow will be handled by the underlying store.
			// Updates will be delivered to the `InAppPurchase.instance.purchaseStream`.
			// await FlutterInappPurchase.instance.requestSubscription(item.toString()).then((value)
			// {
			// 	print(value);
				// _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text("Success")));
			// });

			await _getPurchaseHistory();
		}
		catch(e)
		{
			print(e);
			_scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
		}
	}

	_getPurchaseHistory() async
	{
    	List<PurchasedItem>? items = await FlutterInappPurchase.instance.getPurchaseHistory();
    	for (var item in items!)
		{
			print(item);
      		this._purchases.add(item);
    	}

    	setState(()
		{
			// this._items = [];
			// this._purchases = items;
			print(this._purchases);

    	});
  	}

	Widget build(BuildContext context)
	{
		getItems();

		return RefreshIndicator
		(
			onRefresh: ()
			{
				return Future.delayed(Duration(seconds: 3), ()
				{
					loadData();
				});
			},
			child: Scaffold
			(
				key: _scaffoldKey,
				backgroundColor: Colors.blue[100],
				appBar: appBarImage == null ? AppBar(backgroundColor: Colors.grey[400]) : appBar(appBarImage["hometext"], context, true),
				body: Container
				(
					color: Colors.blue[100],
					child: isLoading ? Center(child: CircularProgressIndicator()) : body(),
				),
				// bottomNavigationBar: bottomNavigationBar(context),
			)
		);
	}

	Widget body()
	{
		return SingleChildScrollView
		(
			child: Column
			(
				children:
				[
					carouselList.length == 0 ? Text("") :  slider(),
					socialMediaList.length == 0 ? SizedBox.shrink() : banner(),
					socialMediaList.length == 0 ? SizedBox.shrink() : socialMediaIcons(),
					componenets(),
				],
			)
		);
	}

	Widget slider()
	{
		return Stack
		(
			children:
			[
				Padding
				(
					padding: EdgeInsets.only(top: 20),
					child: CarouselSlider.builder
					(
						itemCount: carouselList.length,
						options: CarouselOptions
						(
							viewportFraction: 0.6,
							// height: 170,
							autoPlay: true,
						),
						itemBuilder: (BuildContext context, int index, realIndex)
						{
							return Padding
							(
								padding: EdgeInsets.only(right: 25),
								child: GestureDetector
								(
									child: ClipRRect
									(
										borderRadius: BorderRadius.circular(16.0),
										child: Container
										(
											// color: Colors.blue,
											height: MediaQuery.of(context).size.height,
											width: MediaQuery.of(context).size.width,
											decoration: BoxDecoration
											(
												image: DecorationImage
												(
													image: NetworkImage(carouselList[index]["image"]),
													fit: BoxFit.fill
												)
											)
										)
									),
									onTap: ()
									{
										switch (carouselList[index]["status"])
										{

											case "premium":
												if(this._purchases.length == 0)
												{
													premiumTips(context);
												}
												else
												{
													Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumTips(premiumList)));
												}
												break;

											case "free":
												Navigator.push(context, MaterialPageRoute(builder: (context) => FreeTips(freeList)));
												break;

											case "rating":
												ratingVideosSheet(context);
												break;

											case "free":
												Navigator.push(context, MaterialPageRoute(builder: (context) => FreeTips(freeList)));
												break;

											case "resumo":
												Navigator.push(context, MaterialPageRoute(builder: (context) => ResumeTipsScreen(resumoList)));
												break;
										  	default:
										}
									}
								)
							);
						}
					)
				)
			],
		);
	}

	Widget banner()
	{
		// print(bannerImage);

		return InkWell
		(
			child: Container
			(
				height: 200, width: double.infinity,
				margin: EdgeInsets.only(top: 35	, left: 20, right: 20, bottom: 20),
				child: ClipRRect
				(
					borderRadius: BorderRadius.circular(5),
					child: FancyShimmerImage
					(
						imageUrl: bannerImage["image"],
						shimmerBaseColor: Colors.grey[200],
						shimmerBackColor: Colors.grey,
					)
					// FadeInImage.memoryNetwork(placeholder: "assets/images/", image: image)
					//  Image.network(bannerImage["image"], fit: BoxFit.fill),
				),
			),
			onTap: ()
			{
				_launchUrl(bannerImage["link"]);
			},
		);
	}

	Widget socialMediaIcons()
	{
		return Container
		(
			child: Row
			(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children:
				[
					GestureDetector
					(
						child: Container
						(
							margin: EdgeInsets.only(right: 8, left: 8, bottom: 2),
							padding: EdgeInsets.all(10),
							decoration: BoxDecoration
							(
								color: Colors.white,
								borderRadius: BorderRadius.circular(50),
								boxShadow:
								[
									BoxShadow
									(
										color: Colors.grey.withOpacity(0.5),
										spreadRadius: 2,
										blurRadius: 4,
										offset: Offset(0, 2), // changes position of shadow
									)
								]
							),
							child: Image.network
							(
								socialMediaList[0]["image"],
								height: 35,
								width: 35,
							),
						),
						onTap: ()
						{
							// if(socialMediaList[0]["status"] == false)
							// {
								_launchUrl(socialMediaList[0]["link"]);
							// }
							// else
							// {
							// 	Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(socialMediaList[0]["link"])));
							// }
						}
					),
					GestureDetector
					(
						child: Container
						(
							margin: EdgeInsets.only(right: 8, left: 8, bottom: 2),
							padding: EdgeInsets.all(10),
							decoration: BoxDecoration
							(
								color: Colors.white,
								borderRadius: BorderRadius.circular(50),
								boxShadow:
								[
									BoxShadow
									(
										color: Colors.grey.withOpacity(0.5),
										spreadRadius: 2,
										blurRadius: 4,
										offset: Offset(0, 2), // changes position of shadow
									)
								]
							),
							child: Image.network
							(
								socialMediaList[1]["image"],
								height: 35,
								width: 35,
							),
						),
						onTap: ()
						{
							// if(socialMediaList[1]["status"] == false)
							// {
								_launchUrl(socialMediaList[1]["link"]);
							// }
							// else
							// {
							// 	Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(socialMediaList[1]["link"])));
							// }
						}
					),
					GestureDetector
					(
						child: Container
						(
							margin: EdgeInsets.only(right: 8, left: 8, bottom: 2),
							padding: EdgeInsets.all(10),
							decoration: BoxDecoration
							(
								color: Colors.white,
								borderRadius: BorderRadius.circular(50),
								boxShadow:
								[
									BoxShadow
									(
										color: Colors.grey.withOpacity(0.5),
										spreadRadius: 2,
										blurRadius: 4,
										offset: Offset(0, 2), // changes position of shadow
									)
								]
							),
							child: Image.network
							(
								socialMediaList[2]["image"],
								height: 35,
								width: 35,
							),
						),
						onTap: ()
						{
							// if(socialMediaList[2]["status"] == false)
							// {
								_launchUrl(socialMediaList[2]["link"]);
							// }
							// else
							// {
							// 	Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(socialMediaList[2]["link"])));
							// }
						}
					),
					GestureDetector
					(
						child: Container
						(
							margin: EdgeInsets.only(right: 8, left: 8, bottom: 2),
							padding: EdgeInsets.all(10),
							decoration: BoxDecoration
							(
								color: Colors.white,
								borderRadius: BorderRadius.circular(50),
								boxShadow:
								[
									BoxShadow
									(
										color: Colors.grey.withOpacity(0.5),
										spreadRadius: 2,
										blurRadius: 4,
										offset: Offset(0, 2), // changes position of shadow
									)
								]
							),
							child: Image.network
							(
								socialMediaList[3]["image"],
								height: 35,
								width: 35,
							),
						),
						onTap: ()
						{
							// if(socialMediaList[3]["status"] == false)
							// {
							// 	_launchUrl(socialMediaList[3]["link"]);
							// }
							// else
							// {
								Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen("https://www.tipstugas.pt/betguideapp.html", "Betting Guide")));
							// }
						}
					),
					GestureDetector
					(
						child: Container
						(
							margin: EdgeInsets.only(right: 8, left: 8, bottom: 2),
							padding: EdgeInsets.all(10),
							decoration: BoxDecoration
							(
								color: Colors.white,
								borderRadius: BorderRadius.circular(50),
								boxShadow:
								[
									BoxShadow
									(
										color: Colors.grey.withOpacity(0.5),
										spreadRadius: 2,
										blurRadius: 4,
										offset: Offset(0, 2), // changes position of shadow
									)
								]
							),
							child: Image.network
							(
								socialMediaList[4]["image"],
								height: 35,
								width: 35,
							),
						),
						onTap: ()
						{
							// if(socialMediaList[4]["status"] == false)
							// {
							// 	_launchUrl(socialMediaList[4]["link"]);
							// }
							// else
							// {
								Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen("https://www.tipstugas.pt/oddsapp.html", "Oddspedia")));
							// }
						}
					)
				]
			)
		);
	}

	getLinks()
	{
		List <Row> rows = [];

		for(int i = 0; i < 5; i++)
		{
			rows.add( Row
			(
				children :
				[
					GestureDetector
					(
						child: Container
						(
							padding: EdgeInsets.all(10),
							decoration: BoxDecoration
							(
								color: Colors.white,
								borderRadius: BorderRadius.circular(50),
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
							child: Image.asset
							(
								"assets/icons/telegram_icon.png",
								height: 35,
								width: 35,
							),
						),
						onTap: _launchTelegramURL
					)
				]
			));
		}

		return rows;
	}

	Widget componenets()
	{
		return Container
		(
			height: 70,
			margin: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 50),
			child: Row
			(
				mainAxisAlignment: MainAxisAlignment.spaceAround,
				children:
				[
					GestureDetector
						(
							child: Column
							(
								children:
								[
									Container
									(
										height: 40, width: 40,
										child: Lottie.network("https://assets4.lottiefiles.com/packages/lf20_ZnU5Bj.json",),
									),
									// SizedBox(height: 15),
									Text
									(
										"Dir",
										style: GoogleFonts.ibmPlexSans
										(
											color: Colors.black,
											fontWeight: FontWeight.bold,
											fontSize: 12
										),
									)
								],
							),
							onTap: ()
							{
								Navigator.push(context, MaterialPageRoute(builder: (context) => DirRecovered(strategyList)));
							},
						// )
					),
					VerticalDivider(width: 10, color: Colors.black),
					// Expanded
					// (
					// 	child:
						GestureDetector
						(
							child: Column
							(
								children:
								[
									Container
									(
										height: 40, width: 75,
										child: Lottie.network("https://assets4.lottiefiles.com/temporary_files/fp4488.json", fit: BoxFit.fill),
									),
									// SizedBox(height: 15),
									Text
									(
										"Privacidade",
										style: GoogleFonts.ibmPlexSans
										(
											color: Colors.black,
											fontWeight: FontWeight.bold,
											fontSize: 12
										),
									)
								],
							),
							onTap: ()
							{
								_launchDirURL();
							},
						// ),
					),
					VerticalDivider(width: 5, color: Colors.black),
					// Expanded
					// (
					// 	child:
						GestureDetector
						(
							child: Column
							(
								children:
								[
									Container
									(
										height: 40, width: 75,
										child: Lottie.network("https://assets5.lottiefiles.com/packages/lf20_hrnheqki/data.json", fit: BoxFit.fill),
									),
									// SizedBox(height: 15),
									Text
									(
										"@faleconosco",
										style: GoogleFonts.ibmPlexSans
										(
											color: Colors.black,
											fontWeight: FontWeight.bold,
											fontSize: 12
										),
									)
								],
							),
							onTap: _sendMail
						// )
					),
					VerticalDivider(width: 5, color: Colors.black),
					// Expanded
					// (
					// 	child:
						GestureDetector
						(
							child: Column
							(
								children:
								[
									Container
									(
										height: 40, width: 70,
										child: Lottie.network("https://assets5.lottiefiles.com/datafiles/aORHMsazgTKXM4h/data.json", fit: BoxFit.cover),
									),
									// SizedBox(height: 15),
									Text
									(
										"Share",
										style: GoogleFonts.ibmPlexSans
										(
											color: Colors.black,
											fontWeight: FontWeight.bold,
											fontSize: 12
										),
									)
								],
							),
							onTap: ()
							{
								shareApp();
							}
						)
					// ),
				]
			)
		);
	}

	void premiumTips(BuildContext context)
	{
		int checkedValue = 0;

		AlertDialog alert = AlertDialog
		(
			// backgroundColor: Colors.black38,
			content: StatefulBuilder
			(
            	builder: (BuildContext context, StateSetter setState)
				{
					return Column
					(
						mainAxisAlignment: MainAxisAlignment.center,
						mainAxisSize: MainAxisSize.min,
						children: <Widget>
						[
							Align
							(
								alignment: Alignment.topRight,
								child: IconButton
								(
									onPressed: () => Navigator.pop(context),
									icon: Icon(Icons.close)
								),
							),
							Text
							(
								"Escolha a subscri????o, renova automaticamente para poder aceder ao PREMIUM",
								style: GoogleFonts.ibmPlexSans
								(
									fontWeight: FontWeight.w500
								),
							),
							ListTile
							(
          						title:  Text(products[0].title.toString().split("(")[0].toString() + " - " + products[0].price.toString()),
								leading: Radio
								(
									value: products[0].id.toString(),
									groupValue: _site,
									onChanged: (value)
									{
										setState(()
										{
											_site = value;
											checkedValue = 0;
										});
									},
								),
							),
							ListTile
							(
          						title:  Text(products[1].title.toString().split("(")[0].toString() + " - " + products[1].price.toString()),
								leading: Radio
								(
									value: products[1].id.toString(),
									groupValue: _site,
									onChanged: (value)
									{
										setState(() 
										{
											_site = value!;
											checkedValue = 1;
										});
									}
								)
							),
							Row
							(
								mainAxisAlignment: MainAxisAlignment.end,
								children:
								[
									GestureDetector
									(
										child: Text
										(
											"se nao cancelar".toUpperCase(),
											style: GoogleFonts.ibmPlexSans
											(
												fontWeight: FontWeight.w500,
												color: Colors.blue,
												fontSize: 12,
											),
										),
										onTap: ()
										{
											Navigator.pop(context);
										}
									),
									SizedBox(width: 10),
									GestureDetector
									(
										child: Text
										(
											"CONTINUAR",
											style: GoogleFonts.ibmPlexSans
											(
												fontWeight: FontWeight.w500,
												color: Colors.blue,
												fontSize: 12,
											),
										),
										onTap: ()
										{
											this._requestPurchase(checkedValue);
											Navigator.pop(context);
										}
									)
								],
							)
						],
					);
				}
			)
		);

		showDialog
		(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context)
			{
				return alert;
			}
		);
	}

	_launchDirURL() async
	{
  		const url = 'http://tipstugas.com/privacy.html';
  		if (await canLaunch(url))
		{
    		await launch(url);
		}
		else
		{
    		throw 'Could not launch $url';
  		}
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

	_launchTelegramURL() async
	{
  		const url = 'https://t.me/joinchat/J1HzSxVsdBmzqKTe8xy7nw';
  		if (await canLaunch(url))
		{
    		await launch(url);
		}
		else
		{
    		throw 'Could not launch $url';
  		}
	}

	_sendMail() async
	{
		// Android and iOS
		const uri = 'mailto:tipstugas@gmail.com?';

		if (await canLaunch(uri))
		{
			await launch(uri);
		}
		else
		{
			throw 'Could not launch $uri';
		}
	}

	shareApp() async
	{
		Share.share('Install Tipstugas and Enjoy! https://play.google.com/store/apps/details?id=com.tips.tugas.pt', subject: 'Install Tipstugas and Enjoy!');
	}

	getPremiumTips() async
	{
		premiumList.clear();

		var response = await Server.premiumTips();

		if(response["status"] == "true")
		{
			for(int i = 0; i < response["data"].length; i++)
			{
				premiumList.add(response["data"][i]);

				setState(()
				{
				});
			}
		}
	}

	getFreeTips() async
	{
		freeList.clear();

		var response = await Server.freeTips();

		if(response["status"] == "true")
		{
			for(int i = 0; i < response["data"].length; i++)
			{
				freeList.add(response["data"][i]);

				setState(()
				{
					// print(freeList);
				});
			}
		}
	}

	getStrategyTips() async
	{
		strategyList.clear();

		var response = await Server.strategyTips();

		if(response["status"] == "true")
		{
			for(int i = 0; i < response["data"].length; i++)
			{
				strategyList.add(response["data"][i]);

				setState(()
				{
					// print(strategyList);
				});
			}
		}
	}

	getResumoTips() async
	{
		resumoList.clear();

		var response = await Server.resumoTips();

		if(response["status"] == "true")
		{
			for(int i = 0; i < response["data"].length; i++)
			{
				resumoList.add(response["data"][i]);

				setState(()
				{
					isLoading = false;
				});
			}
		}
	}

	getImages() async
	{
		socialMediaList.clear();
		carouselList.clear();
		bannerImage = null;
		appBarBackgroundImage = null;

		var response = await Server.images();

		if(response["status"] == "true")
		{
			bannerImage = response["banner"];
			appBarImage = response["data"][0];
			appBarBackgroundImage = appBarImage["homebanner"];
			telegramData = response["setting"];

			setState(() {
			});

			for(int i = 0; i < response["socialimages"].length; i++)
			{
				socialMediaList.add(response["socialimages"][i]);

				setState(()
				{
				});
			}

			for(int i = 0; i < response["otherimages"].length; i++)
			{
				carouselList.add(response["otherimages"][i]);

				setState(()
				{
				});
			}
		}
	}

	Future<void> _requestReview() => inAppReview.requestReview();
}