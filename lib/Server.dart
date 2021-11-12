import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tipstugas/API.dart';

class Server
{
	static premiumTips() async
	{
		try
		{
			var response = await http.get(Uri.parse(API.premiumTips));

			var responseJson = jsonDecode(response.body);

			return responseJson;
		}
		catch(e)
		{
			return false;
		}
	}

	static freeTips() async
	{
		try
		{
			var response = await http.get(Uri.parse(API.freeTips));

			var responseJson = jsonDecode(response.body);

			return responseJson;
		}
		catch(e)
		{
			return false;
		}
	}

	static strategyTips() async
	{
		try
		{
			var response = await http.get(Uri.parse(API.strategyTips));

			var responseJson = jsonDecode(response.body);

			return responseJson;
		}
		catch(e)
		{
			return false;
		}
	}

	static resumoTips() async
	{
		try
		{
			var response = await http.get(Uri.parse(API.resumoTips));

			var responseJson = jsonDecode(response.body);

			return responseJson;
		}
		catch(e)
		{
			return false;
		}
	}

	static images() async
	{
		try
		{
			var response = await http.get(Uri.parse(API.images));

			var responseJson = jsonDecode(response.body);

			return responseJson;
		}
		catch(e)
		{
			return false;
		}
	}
}