import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_booking/services/constant.dart';
import 'package:hotel_booking/services/database.dart';
import 'package:hotel_booking/services/shared_pref.dart';
import 'package:hotel_booking/services/widget_support.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class DetailsPage extends StatefulWidget {
  String name, price, wifi, hdtv, kitchen, bathroom, desc, hotelid;

  DetailsPage({
    super.key,
    required this.bathroom,
    required this.desc,
    required this.hdtv,
    required this.kitchen,
    required this.name,
    required this.price,
    required this.wifi,
    required this.hotelid,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Map<String, dynamic>? paymentIntent;
  TextEditingController guestcontroller = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var finalamount;
  DateTime? startDate;
  DateTime? endDate;
  int daysDifference = 1;
  String? username, userid, userimage;

  getontheload() async {
    username = await SharedpreferenceHelper().getUserName();
    userid = await SharedpreferenceHelper().getUserId();
    userimage = await SharedpreferenceHelper().getUserImage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    finalamount = int.parse(widget.price);
    getontheload();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        startDate = picked;
        _calculateDifference();
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? (startDate ?? DateTime.now().add(Duration())),
      firstDate: startDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        endDate = picked;
        _calculateDifference();
      });
    }
  }

  void _calculateDifference() {
    if (startDate != null && endDate != null) {
      daysDifference = endDate!.difference(startDate!).inDays;
      finalamount = int.parse(widget.price) * daysDifference;
      print(daysDifference);
    }
  }

  String _formatDate(DateTime? date) {
    return date != null
        ? DateFormat("dd, MMM yyy").format(date)
        : "Select date";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      child: Image.asset(
                        "assets/images/hotel1.jpg",

                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.only(top: 50.0, left: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    Text(widget.name, style: AppWidget.headlinetextstyle(22)),
                    Text(
                      "\$${widget.price}",
                      style: AppWidget.normaltextstyle(27.0),
                    ),
                    Divider(thickness: 2.0),
                    SizedBox(height: 20.0),
                    Text(
                      "What this place offers",
                      style: AppWidget.headlinetextstyle(22.0),
                    ),
                    SizedBox(height: 5),
                    widget.wifi == "true"
                        ? Row(
                          children: [
                            Icon(
                              Icons.wifi,
                              size: 30.0,
                              color: const Color.fromARGB(255, 11, 104, 180),
                            ),
                            SizedBox(width: 10.0),
                            Text("Wifi", style: AppWidget.normaltextstyle(22)),
                          ],
                        )
                        : Container(),
                    SizedBox(height: 20.0),
                    widget.hdtv == "true"
                        ? Row(
                          children: [
                            Icon(
                              Icons.tv,
                              size: 30.0,
                              color: const Color.fromARGB(255, 11, 104, 180),
                            ),
                            SizedBox(width: 10.0),
                            Text("HDTV", style: AppWidget.normaltextstyle(22)),
                          ],
                        )
                        : Container(),
                    SizedBox(height: 20.0),
                    widget.kitchen == "true"
                        ? Row(
                          children: [
                            Icon(
                              Icons.kitchen,
                              size: 30.0,
                              color: const Color.fromARGB(255, 11, 104, 180),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              "Kitchen",
                              style: AppWidget.normaltextstyle(22),
                            ),
                          ],
                        )
                        : Container(),
                    SizedBox(height: 20.0),
                    widget.bathroom == "true"
                        ? Row(
                          children: [
                            Icon(
                              Icons.bathroom,
                              size: 30.0,
                              color: const Color.fromARGB(255, 11, 104, 180),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              "Bathroom",
                              style: AppWidget.normaltextstyle(22),
                            ),
                          ],
                        )
                        : Container(),
                    Divider(thickness: 2.0),
                    Text(
                      "About this place",
                      style: AppWidget.headlinetextstyle(22.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(widget.desc, style: AppWidget.normaltextstyle(16.0)),
                    SizedBox(height: 10),
                    Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),

                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$$finalamount for ${daysDifference}nights",
                              style: AppWidget.headlinetextstyle(20),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "Check-in Date",
                              style: AppWidget.normaltextstyle(20.0),
                            ),
                            Divider(),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _selectStartDate(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(
                                      Icons.calendar_month,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  _formatDate(startDate),
                                  style: AppWidget.normaltextstyle(20.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "Check-out Date",
                              style: AppWidget.normaltextstyle(20.0),
                            ),
                            Divider(),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _selectEndDate(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(
                                      Icons.calendar_month,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  _formatDate(endDate),
                                  style: AppWidget.normaltextstyle(20.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "Number of guests",
                              style: AppWidget.normaltextstyle(20),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xffececf8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                controller: guestcontroller,
                                onChanged: (value) {
                                  // finalamount = finalamount * int.parse(value);
                                  if (value.isNotEmpty &&
                                      int.parse(value) > 0) {
                                    setState(() {
                                      finalamount =
                                          finalamount * int.parse(value);
                                    });
                                  }
                                },
                                // controller: guestcontroller,
                                style: AppWidget.headlinetextstyle(20.0),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "1",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () {
                                makePayement(finalamount.toString());
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Book Now",
                                    style: AppWidget.whitetextstyle(20.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            ],
          ),
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
            String addid = randomAlphaNumeric(10);
            Map<String, dynamic> userhotelbooking = {
              "Username": username,
              // "UserImage": userimage,
              "CheckIn": _formatDate(startDate).toString(),
              "CheckOut": _formatDate(endDate).toString(),
              "Guests": guestcontroller.text,
              "total": finalamount.toString(),
              "HotelName": widget.name,
            };
            await DatabaseMethods().addUserBooking(
              userhotelbooking,
              userid!,
              addid,
            );
            await DatabaseMethods().addHotelownerBooking(
              userhotelbooking,
              widget.hotelid,
              addid,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  "Hotel Booked Successfully!",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            );

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
}
