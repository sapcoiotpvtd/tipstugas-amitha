import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tipstugas/widgets/utilities/BottomNavigationbar.dart';
import 'package:tipstugas/widgets/utilities/CustomAppbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget
{
	final url;
	WebViewScreen(this.url);

	@override
	_WebViewScreenState createState() => _WebViewScreenState(this.url);
}

class _WebViewScreenState extends State<WebViewScreen>
{
	final url;
	_WebViewScreenState(this.url);

	final Completer<WebViewController> _controller = Completer<WebViewController>();
	late WebViewController controllerGlobal;
	bool _isLoading = true;

	bool isOdds = false;

  	@override
  	void initState()
	{
    	super.initState();
    	if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

		if(this.url.toString().contains("oddsapp"))
		{
			print("Hiii");

			isOdds = true;
		}
  	}

  	@override
  	Widget build(BuildContext context)
	{
    	return Scaffold
		(
			appBar: appBar(isOdds ? "Oddspedia" : "Betting Guide", context, false),
        	body: Column
			(
          		children:
				[
            		Expanded
					(
              			child: Stack
						(
							children:
							[
                  				WebView
								(
									javascriptMode: JavascriptMode.unrestricted,
									initialUrl: this.url,
									// initialUrl: "https://www.tipstugas.pt/betguide.html",
									gestureNavigationEnabled: true,
									onWebViewCreated: (WebViewController webViewController)
									{
										_controller.future.then((value) => controllerGlobal = value);
										_controller.complete(webViewController);
                    				},
									onPageStarted: (String url)
									{
										print('Page started loading: $url');
										setState(() {
											_isLoading = true;
										});
                    				},
                    				onPageFinished: (String url)
									{
                      					print('Page finished loading: $url');
                      					setState(()
										{
											_isLoading = false;
                      					});
                    				},
                  				),
								//   appBar("Betting Guide", context),
								//   _isLoading ? Center(
								//     child: CustomLoader(color: ColorResources.COLOR_PRIMARY),
								//   ) : SizedBox.shrink(),
                			],
              			),
            		),
          		],
        	),
			bottomNavigationBar: bottomNavigationBar(context),
    	);
  	}

  	Future<bool> _exitApp() async
	{
    	if(controllerGlobal != null)
		{
      		if (await controllerGlobal.canGoBack())
			{
				controllerGlobal.goBack();
				return Future.value(false);
      		}
			else
			{
        		return Future.value(true);
     	 	}
		}
		else
		{
      		return Future.value(true);
    	}
  	}
}
