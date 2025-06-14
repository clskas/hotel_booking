import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotel_booking/hotelowner/owner_home.dart';
import 'package:hotel_booking/services/database.dart';
import 'package:hotel_booking/services/shared_pref.dart';
import 'package:hotel_booking/services/widget_support.dart';
import 'package:image_picker/image_picker.dart';

class HotelDetails extends StatefulWidget {
  const HotelDetails({super.key});

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  bool isChecked = false,
      isChecked1 = false,
      isChecked2 = false,
      isChecked3 = false;

  String? id;

  getonthesharedpref() async {
    id = await SharedpreferenceHelper().getUserId();
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    getonthesharedpref();
  }

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  TextEditingController hotelnameController = TextEditingController();
  TextEditingController hotelchargesController = TextEditingController();
  TextEditingController hoteladressController = TextEditingController();
  TextEditingController hoteldescriptionController = TextEditingController();

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hotel Details",
                    style: AppWidget.boldwhitetextstyle(26.0),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    selectedImage != null
                        ? SizedBox(
                          height: 200,
                          width: 200,

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                        : GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Center(
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  width: 2.0,
                                  color: Colors.black,
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                                size: 50.0,
                              ),
                            ),
                          ),
                        ),
                    SizedBox(height: 20.0),
                    Text("Hotel Name", style: AppWidget.normaltextstyle(20.0)),
                    SizedBox(height: 5.0),
                    Container(
                      padding: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xffececf8),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: hotelnameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Hotel Name",
                          hintStyle: AppWidget.normaltextstyle(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Hotel Room Charges",
                      style: AppWidget.normaltextstyle(20.0),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      padding: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xffececf8),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: hotelchargesController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Room Charges",
                          hintStyle: AppWidget.normaltextstyle(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Hotel Adresse",
                      style: AppWidget.normaltextstyle(20.0),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      padding: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xffececf8),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: hoteladressController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Hotel Adress",
                          hintStyle: AppWidget.normaltextstyle(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "What service you want to offer",
                      style: AppWidget.normaltextstyle(20.0),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Icon(
                          Icons.wifi,
                          color: const Color.fromARGB(255, 7, 102, 179),
                          size: 30.0,
                        ),
                        SizedBox(width: 10.0),
                        Text("wifi", style: AppWidget.normaltextstyle(23.0)),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked1,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked1 = value!;
                            });
                          },
                        ),
                        Icon(
                          Icons.tv,
                          color: const Color.fromARGB(255, 7, 102, 179),
                          size: 30.0,
                        ),
                        SizedBox(width: 10.0),
                        Text("HDTV", style: AppWidget.normaltextstyle(23.0)),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked2,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked2 = value!;
                            });
                          },
                        ),
                        Icon(
                          Icons.kitchen,
                          color: const Color.fromARGB(255, 7, 102, 179),
                          size: 30.0,
                        ),
                        SizedBox(width: 10.0),
                        Text("Kitchen", style: AppWidget.normaltextstyle(23.0)),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked3,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked3 = value!;
                            });
                          },
                        ),
                        Icon(
                          Icons.bathroom,
                          color: const Color.fromARGB(255, 7, 102, 179),
                          size: 30.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "Bathroom",
                          style: AppWidget.normaltextstyle(23.0),
                        ),
                      ],
                    ),
                    Text(
                      "Hotel Description",
                      style: AppWidget.normaltextstyle(20.0),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      padding: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xffececf8),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: hoteldescriptionController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter description about hotel",
                          hintStyle: AppWidget.normaltextstyle(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () async {
                        // String addId = randomAlphaNumeric(10);
                        // Reference fireStoreRef = FirebaseStorage.instance.ref().child("blogimage").child(addId);
                        // final UploadTask task = fireStoreRef.putFile(selectedImage!);
                        // var downloadUrl = await (await task).ref.getDownloadURL();

                        Map<String, dynamic> addHotel = {
                          "Image": "",
                          "HotelName": hotelnameController.text,
                          "HotelCharges": hotelchargesController.text,
                          "HotelAdresse": hoteladressController.text,
                          "HotelDesc": hoteldescriptionController.text,
                          "Wifi": isChecked ? "true" : "false",
                          "HDTV": isChecked1 ? "true" : "false",
                          "Kitchen": isChecked2 ? "true" : "false",
                          "Bathroom": isChecked3 ? "true" : "false",
                          "id": id,
                        };
                        await DatabaseMethods().addHotel(addHotel, id!);
                        // await SharedpreferenceHelper().saveUserId(id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              "Hotels Details has been Updated successfully",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OwnerHome()),
                        );
                      },
                      child: Center(
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: AppWidget.boldwhitetextstyle(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
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
