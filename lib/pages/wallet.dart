import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_booking/services/constant.dart';
import 'package:hotel_booking/services/database.dart';
import 'package:hotel_booking/services/shared_pref.dart';
import 'package:hotel_booking/services/widget_support.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  TextEditingController moneycontroller = TextEditingController();
  Map<String, dynamic>? paymentIntent;

  String? wallet, id;

  String getCurrentDateFormatted() {
    final now = DateTime.now();
    final day = DateFormat('dd').format(now);
    final month = DateFormat('MMM').format(now);
    return '$day\n$month';
  }

  getthesharedpref() async {
    wallet = await SharedpreferenceHelper().getUserWallet();
    id = await SharedpreferenceHelper().getUserId();
    transactionsstream = await DatabaseMethods().getUserTransactions(id!);
    setState(() {});
  }

  @override
  void initState() {
    getthesharedpref();
    super.initState();
  }

  Stream? transactionsstream;

  Widget allTransactions() {
    return StreamBuilder(
      stream: transactionsstream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              // scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  margin: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                          ),
                        ),
                        child: Text(
                          ds["Date"],
                          textAlign: TextAlign.center,
                          style: AppWidget.boldwhitetextstyle(24.0),
                        ),
                      ),
                      SizedBox(width: 50.0),
                      Column(
                        children: [
                          Text(
                            "Amount Added :",
                            style: AppWidget.normaltextstyle(18.0),
                          ),
                          Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            "\$" + ds["Amount"],
                            style: AppWidget.headlinetextstyle(30.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WALLET", style: AppWidget.headlinetextstyle(30.0)),
        centerTitle: true,
      ),
      body:
          wallet == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width / 1.2,
                            decoration: BoxDecoration(
                              color: Color(0xffececf8),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/wallet.png",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 50.0),
                                Column(
                                  children: [
                                    Text(
                                      "Your Wallet",
                                      style: AppWidget.normaltextstyle(20.0),
                                    ),
                                    Text(
                                      "\$${wallet!}",
                                      style: AppWidget.headlinetextstyle(30.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            moneycontroller.text = "50";
                            makePayement("50");
                          },
                          child: Container(
                            height: 40,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "50",
                                style: AppWidget.boldwhitetextstyle(25.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.0),
                        GestureDetector(
                          onTap: () {
                            moneycontroller.text = "100";
                            makePayement("100");
                          },
                          child: Container(
                            height: 40,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "100",
                                style: AppWidget.boldwhitetextstyle(25.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.0),
                        GestureDetector(
                          onTap: () {
                            moneycontroller.text = "200";
                            makePayement("200");
                          },
                          child: Container(
                            height: 40,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "200",
                                style: AppWidget.boldwhitetextstyle(25.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        openBox();
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            "Add Money",
                            style: AppWidget.boldwhitetextstyle(20.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffececf8),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60.0),
                            topRight: Radius.circular(60.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10.0),
                            Text(
                              "Your transaction",
                              style: AppWidget.headlinetextstyle(20.0),
                            ),
                            SizedBox(height: 10.0),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 4.5,
                              child: allTransactions(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Future<void> makePayement(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent?['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: 'Adnan',
            ),
          )
          .then((value) {});
      displayPaymentSheet(amount);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((value) async {
            int updateamount = int.parse(wallet!) + int.parse(amount);
            await DatabaseMethods().updatewallet(id!, updateamount.toString());
            await SharedpreferenceHelper().saveUserWallet(
              updateamount.toString(),
            );
            await getthesharedpref();
            String currentdate = getCurrentDateFormatted();
            Map<String, dynamic> addTransaction = {
              "Date": currentdate,
              "Amount": moneycontroller.text,
            };
            await DatabaseMethods().addUserTransaction(addTransaction, id!);
            setState(() {});
            showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder:
                  (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            Text("Payment Successfull"),
                          ],
                        ),
                      ],
                    ),
                  ),
            );
            paymentIntent = null;
          })
          .onError((error, stackTrace) {
            print("Error is:===>$error $stackTrace");
          });
    } on StripeException catch (e) {
      print("Error is:===> $e");
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (_) => AlertDialog(content: Text("Concelled")),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretkey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount) * 100);
    return calculatedAmount.toString();
  }

  Future openBox() => showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.cancel),
                      ),
                      SizedBox(width: 50.0),
                      Text(
                        "Add Money",
                        style: TextStyle(
                          color: Color(0xff008080),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: moneycontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Money",
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      makePayement(moneycontroller.text);
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Container(
                        width: 100.0,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Color(0xff008080),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );
}
