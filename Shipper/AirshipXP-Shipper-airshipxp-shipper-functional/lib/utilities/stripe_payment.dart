import 'dart:convert';

import 'package:airshipxp_shipper/components/constants.dart';
import 'package:airshipxp_shipper/utilities/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripePayment {
  makePayment(
      {required String email,
      required String amount,
      required BuildContext context}) async {
    try {
      // 1. Create a payment intent on the server
      final response = await http
          .post(Uri.parse('$baseUrl/api/getShipperPaymentIntent'), body: {
        'email': email,
        'amount': calculateAmount(amount),
      }, headers: {
        "Accept": "application/json",
        "Authorization":
            "Bearer ${await SessionManager().getString(SessionManager.userToken)}"
      });

      final jsonResponse = jsonDecode(response.body);

      print(jsonResponse.toString());
      print(jsonResponse['data']['paymentIntent']);

      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: jsonResponse['data']['paymentIntent'],
        merchantDisplayName: 'Airship Shipper card',
        customerId: jsonResponse['data']['shipper'],
        customerEphemeralKeySecret: jsonResponse['data']['ephemeralKey'],
      ));
      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment successful'),
        ),
      );

      return jsonResponse['data']['transactionid'];
    } catch (errorr) {
      if (errorr is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('An error occured : ${errorr.error.localizedMessage}'),
          ),
        );
        return "";
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occured : $errorr'),
          ),
        );
        return "";
      }
    }
  }

  calculateAmount(String amount) {
    final a;
    print("kk");
    if (int.tryParse(amount) != null) {
      a = ((int.parse(amount)) * 100).toString();
    } else {
      a = ((double.parse(amount)) * 100).toStringAsFixed(0);
    }
    print(a);
    return a;
  }
}
