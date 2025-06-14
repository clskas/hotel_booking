import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/services/database.dart';
import 'package:hotel_booking/services/shared_pref.dart';
import 'package:hotel_booking/services/widget_support.dart';
import 'package:intl/intl.dart';

class OwnerHome extends StatefulWidget {
  const OwnerHome({super.key});

  @override
  State<OwnerHome> createState() => _OwnerHomeState();
}

class _OwnerHomeState extends State<OwnerHome> {
  String? id, name;

  getonthesharedpref() async {
    id = await SharedpreferenceHelper().getUserId();
    name = await SharedpreferenceHelper().getUserName();
    bookingStream = await DatabaseMethods().getAdminbookings(id!);
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    getonthesharedpref();
  }

  Stream? bookingStream;
  Widget allAdminBookings() {
    return StreamBuilder(
      stream: bookingStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              //scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                final format = DateFormat('dd, MMM yyyy');
                final date = format.parse(ds["CheckIn"]);
                final now = DateTime.now();

                return date.isBefore(now)
                    ? Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Material(
                        elevation: 6.0,
                        borderRadius: BorderRadius.circular(20.0),

                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width / 1.4,
                          decoration: BoxDecoration(
                            color: Color(0xFFececf8),
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(width: 0.1),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  "assets/images/boy.jpg",
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.blue,
                                        size: 30.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        ds["Username"],
                                        style: AppWidget.normaltextstyle(19.0),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.blue,
                                        size: 30.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                            3,
                                        child: Text(
                                          ds["CheckIn"] +
                                              " to " +
                                              ds["CheckOut"],
                                          style: AppWidget.normaltextstyle(
                                            16.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.group,
                                        color: Colors.blue,
                                        size: 30.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        ds["Guests"],
                                        style: AppWidget.headlinetextstyle(
                                          20.0,
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Icon(
                                        Icons.monetization_on,
                                        color: Colors.blue,
                                        size: 25.0,
                                      ),
                                      SizedBox(width: 3.0),
                                      Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        "\$" + ds["total"],
                                        style: AppWidget.headlinetextstyle(
                                          18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    : Container();
              },
            )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          name == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                child: Stack(
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/home.jpg",
                        width: MediaQuery.of(context).size.width,
                        height: 280,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 280,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(83, 0, 0, 0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40.0, left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/wave.png",
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "Hello,${name!}",
                                style: AppWidget.boldwhitetextstyle(22.0),
                              ),
                            ],
                          ),
                          Text(
                            "Ready to welcome your next guest?",
                            style: AppWidget.whitetextstyle(20.0),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 4.5,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xffececf8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20.0),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 1.4,

                            child: allAdminBookings(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
