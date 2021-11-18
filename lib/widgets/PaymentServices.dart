// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
// import 'package:flutter_inapp_purchase/modules.dart';

// class PaymentService 
// {
//   /// We want singelton object of ``PaymentService`` so create private constructor
//   /// 
//   /// Use PaymentService as ``PaymentService.instance``
// 	PaymentService._internal();

//   	static final PaymentService instance = PaymentService._internal();

// 	late  StreamSubscription<ConnectionResult> _connectionSubscription;
// 	late StreamSubscription<PurchasedItem> _purchaseUpdatedSubscription;
// 	late  StreamSubscription<PurchaseResult> _purchaseErrorSubscription;

//    	final List<String> _productIds = ['threemonths', 'monthly'];

// 	List<IAPItem> _products = [];
// 	List<PurchasedItem> _pastPurchases = [];

// 	ObserverList<Function> _proStatusChangedListeners = new ObserverList<Function>();

// 	/// view of the app will subscribe to this to get errors of the purchase
//   	ObserverList<Function(String)> _errorListeners = new ObserverList<Function(String)>();

// 	bool _isProUser = false;

//   	bool get isProUser => _isProUser;

// 	void initConnection() async 
// 	{
//     	await FlutterInappPurchase.instance.initConnection;
//     	_connectionSubscription = FlutterInappPurchase.connectionUpdated.listen((connected) {});
// 		_purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen(_handlePurchaseUpdate);

//     _purchaseErrorSubscription =
//         FlutterInappPurchase.purchaseError.listen(_handlePurchaseError);

//     _getItems();
//     _getPastPurchases();
//   }
//   /// call when user close the app
//   void dispose() {
//     _connectionSubscription.cancel();
//     _purchaseErrorSubscription.cancel();
//     _purchaseUpdatedSubscription.cancel();
//     FlutterInappPurchase.instance.endConnection;
//   }

// }

// class _handlePurchaseUpdate {
// }