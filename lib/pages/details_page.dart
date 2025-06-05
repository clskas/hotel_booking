import 'package:flutter/material.dart';
import 'package:hotel_booking/services/widget_support.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
                    Text("Hotel Beach", style: AppWidget.headlinetextstyle(22)),
                    Text("\$20", style: AppWidget.normaltextstyle(27.0)),
                    Divider(thickness: 2.0),
                    SizedBox(height: 20.0),
                    Text(
                      "What this place offers",
                      style: AppWidget.headlinetextstyle(22.0),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.wifi,
                          size: 30.0,
                          color: const Color.fromARGB(255, 11, 104, 180),
                        ),
                        SizedBox(width: 10.0),
                        Text("Wifi", style: AppWidget.normaltextstyle(22)),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Icon(
                          Icons.tv,
                          size: 30.0,
                          color: const Color.fromARGB(255, 11, 104, 180),
                        ),
                        SizedBox(width: 10.0),
                        Text("HDTV", style: AppWidget.normaltextstyle(22)),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Icon(
                          Icons.kitchen,
                          size: 30.0,
                          color: const Color.fromARGB(255, 11, 104, 180),
                        ),
                        SizedBox(width: 10.0),
                        Text("Kitchen", style: AppWidget.normaltextstyle(22)),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Icon(
                          Icons.bathroom,
                          size: 30.0,
                          color: const Color.fromARGB(255, 11, 104, 180),
                        ),
                        SizedBox(width: 10.0),
                        Text("Bathroom", style: AppWidget.normaltextstyle(22)),
                      ],
                    ),
                    Divider(thickness: 2.0),
                    Text(
                      "About this place",
                      style: AppWidget.headlinetextstyle(22.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit is a placeholder text commonly used in design and publishing industries to fill space and show the layout of a document or website before the final content is written. It's a Latin-looking phrase, but it's actually nonsense, derived from Cicero's writings but adapted and scrambled over time. The text is used because it's visually appealing and helps designers evaluate the visual impact of typography and layout without being distracted by meaningful content",
                    ),
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
                              "\$100 for 4 nights",
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
                                Container(
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
                                SizedBox(width: 10.0),
                                Text(
                                  "02,April 2025",
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
                                Container(
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
                                SizedBox(width: 10.0),
                                Text(
                                  "12,April 2025",
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
                            Container(
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
}
