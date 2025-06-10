import 'package:flutter/material.dart';
import 'package:hotel_booking/services/widget_support.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking", style: AppWidget.headlinetextstyle(30.0)),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 180,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xffececf8)
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/incoming.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Incoming\nBooking",
                        textAlign: TextAlign.center,
                        style: AppWidget.headlinetextstyle(20.0),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Color(0xffececf8)),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/past.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Past\nBooking",
                        textAlign: TextAlign.center,
                        style: AppWidget.normaltextstyle(24.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
