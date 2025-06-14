import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfo(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addHotel(Map<String, dynamic> hotelInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Hotel")
        .doc(id)
        .set(hotelInfoMap);
  }

  Future<Stream<QuerySnapshot>> getHotels() async {
    return FirebaseFirestore.instance.collection("Hotel").snapshots();
  }

  Future addUserBooking(
    Map<String, dynamic> userInfoMap,
    String id,
    String bookid,
  ) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Booking")
        .doc(bookid)
        .set(userInfoMap);
  }

  Future addHotelownerBooking(
    Map<String, dynamic> userInfoMap,
    String id,
    String bookid,
  ) async {
    return await FirebaseFirestore.instance
        .collection("Hotel")
        .doc(id)
        .collection("Booking")
        .doc(bookid)
        .set(userInfoMap);
  }
  Future addUserTransaction(
    Map<String, dynamic> userInfoMap,
    String id,
  ) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Transaction")
        .add(userInfoMap);
  }

   Future<Stream<QuerySnapshot>> getUserTransactions(String id) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Transaction")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getUserbookings(String id) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Booking")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getAdminbookings(String id) async {
    return FirebaseFirestore.instance
        .collection("Hotel")
        .doc(id)
        .collection("Booking")
        .snapshots();
  }

  Future<QuerySnapshot> getUserbyemail(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: email)
        .get();
  }

  Future updatewallet(String id, String walletamount) async {
    return await FirebaseFirestore.instance.collection("users").doc(id).update({
      "Wallet": walletamount,
    });
  }
}
