import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void premiumTips(BuildContext context)
{
	bool _value = false;
  	int val = -1;

	AlertDialog alert = AlertDialog
	(
		// backgroundColor: Colors.black38,
		content: Column
		(
        	mainAxisAlignment: MainAxisAlignment.center,
        	mainAxisSize: MainAxisSize.min,
        	children: <Widget>
			[
          		Text
				(
					"Escolha a subscrição, renova automaticamente para poder aceder ao VIP se não cancelar",
					style: GoogleFonts.ibmPlexSans
					(
						fontWeight: FontWeight.w500
					),
				),
				ListTile
				(
                	title: Text("Mensal - €14.99 EU"),
                	leading: Radio
					(
                  		value: 1,
                  		groupValue: val,
                  		onChanged: (value) 
						{
							// setState(() 
							// {
                    				//   val = value;
                    		// });
                  		},
                  		activeColor: Colors.green,
                	),
              	),
              	ListTile
			  	(
            		title: Text("Trimestral - €29.99 EU"),
                	leading: Radio
					(
						value: 2,
						groupValue: val,
						onChanged: (value) 
						{
							// setState(() {
							//   val = value;
							// });
                  		},
                  		activeColor: Colors.green,
                	),
              	),
				Row
				(
					mainAxisAlignment: MainAxisAlignment.end,
					children: 
					[
						Text
						(
							"CANCELAR",
							style: GoogleFonts.ibmPlexSans
							(
								fontWeight: FontWeight.w500,
								color: Colors.blue,
								fontSize: 12,
							),
						),
						SizedBox(width: 10),
						Text
						(
							"CONTINUAR",
							style: GoogleFonts.ibmPlexSans
							(
								fontWeight: FontWeight.w500,
								color: Colors.blue,
								fontSize: 12,
							),
						),
					],
				)
        	],
      	),
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
